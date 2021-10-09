import React from 'react'
import {usePouch} from '../PouchContext'
import NewTodoForm from './NewTodoForm'
import TodoRow from './TodoRow'

const incomplete = todo => !todo.complete
const complete = todo => todo.complete

export default function TodoList() {
  const {docs: todos} = usePouch()
  if (!todos) {
    return null
  }

  return (
    <div>
      <h1>Naive Todos</h1>
      <NewTodoForm />
      <h2>Incomplete Todos</h2>
      <ul>
        {todos.filter(incomplete).map((todo) =>
          <TodoRow key={todo._id} todo={todo} />)}
      </ul>
      <h2>Complete Todos</h2>
      <ul>
        {todos.filter(complete).map((todo) =>
          <TodoRow key={todo._id} todo={todo} />)}
      </ul>
    </div>
  )
}
