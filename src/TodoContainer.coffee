import _ from 'lodash'
import useMutableState from './useMutableState'

initialTodos = []

export default TodoContainer = ({children}) ->
  [todos, updateTodos] = useMutableState initialTodos

  createTodo = (name) ->
    id = 1 + Math.max(0, ...todos.map((todo) -> todo.id))
    newTodo = {id, name, complete: false}
    updateTodos (draft) -> draft.push newTodo

  completeTodo = (todoToComplete) ->
    updateTodos (draft) ->
      found = draft.find (todo) -> todo.id == todoToComplete.id
      found.complete = true

  deleteTodo = (todoToDelete) ->
    updateTodos (draft) -> _.remove(draft, (todo) -> todo.id == todoToDelete.id)

  children({todos, createTodo, completeTodo, deleteTodo})
