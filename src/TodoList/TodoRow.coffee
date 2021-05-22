import React from 'react'
import useImmerPouch from '../useImmerPouch'

export default TodoRow = ({todo}) ->
  {updateDoc, deleteDoc} = do useImmerPouch

  completeTodo = -> updateDoc todo, (draft) -> draft.complete = true
  deleteTodo = -> deleteDoc todo

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
