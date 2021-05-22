import React from 'react';
import {ErrorMessage, Formik} from 'formik';
import * as yup from 'yup';
import useImmerPouch from './useImmerPouch';

schema = yup.object().shape({
  name: yup.string().required(),
})

NewTodoForm = ->
  {createDoc} = useImmerPouch()

  handleCreate = (values, {resetForm}) ->
    await createDoc values
    do resetForm

  <Formik
    initialValues={{name: ''}}
    validationSchema={schema}
    onSubmit={handleCreate}
  >
    {({values, handleChange, handleSubmit}) => (
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          name="name"
          placeholder="New Todo"
          value={values.name}
          onChange={handleChange}
        />
        <ErrorMessage name="name" />
        <button type="submit">Add</button>
      </form>
    )}
  </Formik>

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
