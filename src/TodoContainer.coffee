import produce from './produceCoffee'
import {useState} from 'react'

initialTodos = []

export default TodoContainer = ({children}) ->
  [todos, setTodos] = useState initialTodos

  createTodo = (name) ->
    id = 1 + Math.max(0, ...todos.map((todo) -> todo.id))
    newTodo = {id, name, complete: false}
    setTodos produce(todos, (draft) -> draft.push newTodo)

  completeTodo = (todoToComplete) ->
    setTodos produce(todos, (draft) ->
      found = draft.find (todo) -> todo.id == todoToComplete.id
      found.complete = true)

  deleteTodo = (todoToDelete) ->
    setTodos todos.filter (todo) -> todo.id != todoToDelete.id

  children({todos, createTodo, completeTodo, deleteTodo})
