import {complement, prop} from 'ramda'
import React from 'react'
import useImmerPouch from '../useImmerPouch'
import NewTodoForm from './NewTodoForm'
import TodoRow from './TodoRow'

incomplete = (todos) -> todos.filter complement prop 'complete'
complete = (todos) -> todos.filter prop 'complete'

export default TodoList = ->
  {docs: todos} = do useImmerPouch
  return null unless todos

  <div>
    <h1>Todos</h1>
    <NewTodoForm />
    <h2>Incomplete Todos</h2>
    <ul>
      {(incomplete todos).map (todo) ->
        <TodoRow key={todo._id} todo={todo} />}
    </ul>
    <h2>Complete Todos</h2>
    <ul>
      {(complete todos).map (todo) ->
        <TodoRow key={todo._id} todo={todo} />}
    </ul>
  </div>
