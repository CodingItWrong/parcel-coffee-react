import React from 'react';
import PouchDB from 'pouchdb';
import {createContext, useContext, useEffect, useState} from 'react';
import {v4 as uuid} from 'uuid';

// Connects to a PouchDB database synced to a remote CouchDB database. Loads all
// docs into state, and automatically updates them in state upon create/update/
// delete.

const PouchContext = createContext();

export function PouchProvider({children, dbServer, databaseName}) {
  const [db, setDb] = useState(null);
  const [docs, setDocs] = useState(null);

  useEffect(() => {
    function syncToRemote({localDb}) {
      const remoteIdentifier = `${dbServer}/${databaseName}`;
      const remoteDb = new PouchDB(remoteIdentifier);
      const syncHandler = localDb
        .sync(remoteDb, {
          live: true,
          retry: true,
        })
        .on('change', function (change) {
          console.log('POUCHDB CHANGE', change);
          // yo, something changed!
        })
        .on('paused', function (info) {
          console.log('POUCHDB PAUSED', info);
        })
        .on('active', function (info) {
          console.log('POUCHDB ACTIVE', info);
        })
        .on('error', function (err) {
          console.log('POUCHDB ERROR', err);
        });
      return syncHandler;
    }

    if (!db) {
      const localDb = new PouchDB(databaseName);
      const syncHandler = syncToRemote({localDb});
      setDb(localDb);

      const loadDocumentsIntoState = () =>
        localDb.allDocs({include_docs: true}).then(result => {
          const newDocs = result.rows.map(row => row.doc);
          setDocs(newDocs);
        });

      loadDocumentsIntoState();

      localDb.changes({since: 'now', live: true}).on('change', change => {
        loadDocumentsIntoState();
      });

      return () => {
        syncHandler.cancel();
      };
    }
  }, [db, dbServer, databaseName]);

  return (
    <PouchContext.Provider value={{db, docs}}>{children}</PouchContext.Provider>
  );
}

export function usePouch() {
  const {db, docs} = useContext(PouchContext);

  function createDoc(attributes) {
    const _id = uuid();
    const newDocWithId = {
      _id,
      ...attributes,
    };
    return db.put(newDocWithId);
  }

  function updateDoc(doc, docReducer) {
    return db.get(doc._id).then(doc => {
      const updatedDoc = docReducer(doc);
      return db.put(updatedDoc);
    });
  }

  function deleteDoc(doc) {
    return db.get(doc._id).then(doc => db.remove(doc));
  }

  return {docs, createDoc, updateDoc, deleteDoc};
}
