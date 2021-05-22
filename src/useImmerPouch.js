import produce from 'immer';
import {usePouch} from './PouchContext';

// Adapts PouchContext.usePouch to allow a mutable interface for updating docs,
// provided by immer.js
export default function useImmerPouch() {
  const {docs, createDoc, updateDoc: rawUpdateDoc, deleteDoc} = usePouch();

  const updateDoc = (doc, callback) =>
    rawUpdateDoc(doc, doc => produce(doc, draft => {
      callback(draft);
      // ignore returned value, to support coffeescript
    }));

  return {docs, createDoc, updateDoc, deleteDoc};
}
