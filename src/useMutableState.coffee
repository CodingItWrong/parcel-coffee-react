import {useState} from 'react'
import produce from './produceCoffee'

export default useMutableState = (initialValue) ->
  [value, setValue] = useState(initialValue)

  mutateValue = (producer) ->
    setValue produce value, producer

  [value, mutateValue]
