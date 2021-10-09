import React, {useState} from 'react'
import {usePouch} from '../PouchContext'

export default function NewTodoForm() {
  const [name, setName] = useState('')
  const {createDoc} = usePouch()

  const handleCreate = async e => {
    e.preventDefault()
    if (!name) {
      return;
    }
    await createDoc({name})
    setName('')
  }

  return (
    <form onSubmit={handleCreate}>
      <input
        type="text"
        placeholder="New Todo"
        value={name}
        onChange={e => setName(e.target.value)}
      />
      <button type="submit">Add</button>
    </form>
  )
}
