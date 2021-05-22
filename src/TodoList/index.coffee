import {complement, prop} from 'ramda'
import React from 'react'
import useImmerPouch from '../useImmerPouch'
import NewTodoForm from './NewTodoForm'
import TodoRow from './TodoRow'

incomplete = complement prop 'complete'
complete = prop 'complete'
renderTodo = (todo) -> <TodoRow key={todo._id} todo={todo} />

export default TodoList = ->
  {docs: todos} = do useImmerPouch
  return null unless todos

  <div>
    <h1>Todos</h1>
    <NewTodoForm />
    <h2>Incomplete Todos</h2>
    <ul>
      {(todos.filter incomplete).map renderTodo}
    </ul>
    <h2>Complete Todos</h2>
    <ul>
      {(todos.filter complete).map renderTodo}
    </ul>
  </div>
