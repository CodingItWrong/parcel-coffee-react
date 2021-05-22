import {complement, prop} from 'ramda'
import React from 'react'
import useImmerPouch from '../useImmerPouch'
import NewTodoForm from './NewTodoForm'
import TodoRow from './TodoRow'

export default TodoList = ->
  {docs: todos} = do useImmerPouch
  return null unless todos

  incompleteTodos = todos.filter complement prop 'complete'
  completeTodos = todos.filter prop 'complete'

  <div>
    <h1>Todos</h1>
    <NewTodoForm />
    <h2>Incomplete Todos</h2>
    <ul>
      {incompleteTodos.map (todo) ->
        <TodoRow key={todo._id} todo={todo} />}
    </ul>
    <h2>Complete Todos</h2>
    <ul>
      {completeTodos.map (todo) ->
        <TodoRow key={todo._id} todo={todo} />}
    </ul>
  </div>
