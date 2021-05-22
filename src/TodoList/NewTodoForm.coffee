import React from 'react'
import {ErrorMessage, Formik} from 'formik'
import * as yup from 'yup'
import useImmerPouch from '../useImmerPouch'

schema = yup.object().shape
  name: yup.string().required()

export default NewTodoForm = ->
  {createDoc} = do useImmerPouch

  handleCreate = (values, {resetForm}) ->
    await createDoc values
    do resetForm

  <Formik
    initialValues={{name: ''}}
    validationSchema={schema}
    onSubmit={handleCreate}
  >
    {({values, handleChange, handleSubmit}) ->
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
      </form>}
  </Formik>
