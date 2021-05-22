import React, {useState} from 'react'
import TodoContainer from './TodoContainer'
import TodoList from './TodoList'

export default App = ->
  <TodoContainer>
    {(todoProps) -> <TodoList {...todoProps} />}
  </TodoContainer>
