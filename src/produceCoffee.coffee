import produce from 'immer'

export default produceCoffee = (baseState, producer) ->
  produce(baseState, (draft) ->
    producer draft
    undefined)
