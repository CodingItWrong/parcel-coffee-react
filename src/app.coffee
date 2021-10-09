import 'regenerator-runtime/runtime'
import React, {useState} from 'react'
import {PouchProvider} from './PouchContext'
import TodoList from './TodoList'
# import TodoList from './NaiveTodoList'

DB_SERVER = process.env.REACT_APP_COUCH_URL
DATABASE_NAME = 'parceltodos'

export default App = ->
  <PouchProvider dbServer={DB_SERVER} databaseName={DATABASE_NAME}>
    <TodoList />
  </PouchProvider>
