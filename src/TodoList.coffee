import React, {useState} from 'react';
import useImmerPouch from './useImmerPouch';

NewTodoForm = ->
  {createDoc} = useImmerPouch()
  [newTodoName, setNewTodoName] = useState ''

  handleCreate = (submitEvent) ->
    do submitEvent.preventDefault
    return unless newTodoName
    await createDoc({name: newTodoName})
    setNewTodoName ''

  <form onSubmit={handleCreate}>
    <input
      type="text"
      placeholder="New Todo"
      value={newTodoName}
      onChange={(e) -> setNewTodoName e.target.value}
    />
    <button type="submit">
      Add
    </button>
  </form>

Todo = ({todo}) ->
  {updateDoc, deleteDoc} = useImmerPouch()

  completeTodo = -> updateDoc todo, (draft) -> draft.complete = true
  deleteTodo = -> deleteDoc todo

  <li>
    {todo.name}
    {!todo.complete && (
      <button onClick={completeTodo}>
        Complete
      </button>
    )}
    <button onClick={deleteTodo}>
      Delete
    </button>
  </li>

export default TodoList = ->
  {docs: todos} = useImmerPouch();
  return null unless todos

  incompleteTodos = todos.filter((todo) -> !todo.complete)
  completeTodos = todos.filter((todo) -> todo.complete)

  <div>
    <h1>Todos</h1>
    <NewTodoForm />
    <h2>Incomplete Todos</h2>
    <ul>
      {incompleteTodos.map((todo) -> (
        <Todo key={todo._id} todo={todo} />
      ))}
    </ul>
    <h2>Complete Todos</h2>
    <ul>
      {completeTodos.map((todo) -> (
        <Todo key={todo._id} todo={todo} />
      ))}
    </ul>
  </div>
