import React from 'react'
import {usePouch} from '../PouchContext'

export default function TodoRow({todo}) {
  const {updateDoc, deleteDoc} = usePouch()

  const completeTodo = () => updateDoc(todo, (doc) => ({ ...doc, complete: true }))
  const deleteTodo = () => deleteDoc(todo)

  return (
    <li>
      {todo.name}
      {todo.complete ||
        <button onClick={completeTodo}>
          Complete
        </button>}
      <button onClick={deleteTodo}>
        Delete
      </button>
    </li>
  )
}
