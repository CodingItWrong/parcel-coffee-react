import React, {useState} from 'react';

NewTodoForm = ({createTodo}) ->
  [newTodoName, setNewTodoName] = useState ''

  handleCreate = (submitEvent) ->
    do submitEvent.preventDefault
    return unless newTodoName
    createTodo newTodoName
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

Todo = ({todo, completeTodo, deleteTodo}) ->
  <li>
    {todo.name}
    {!todo.complete && (
      <button onClick={-> completeTodo todo}>
        Complete
      </button>
    )}
    <button onClick={-> deleteTodo todo}>
      Delete
    </button>
  </li>

export default TodoList = ({
  todos,
  createTodo,
  completeTodo,
  deleteTodo,
}) ->
  incompleteTodos = todos.filter((todo) -> !todo.complete)
  completeTodos = todos.filter((todo) -> todo.complete)

  <div>
    <h1>Todos</h1>
    <NewTodoForm createTodo={createTodo} />
    <h2>Incomplete Todos</h2>
    <ul>
      {incompleteTodos.map((todo) -> (
        <Todo
          key={todo.id}
          todo={todo}
          completeTodo={completeTodo}
          deleteTodo={deleteTodo}
        />
      ))}
    </ul>
    <h2>Complete Todos</h2>
    <ul>
      {completeTodos.map((todo) -> (
        <Todo key={todo.id} todo={todo} deleteTodo={deleteTodo} />
      ))}
    </ul>
  </div>
