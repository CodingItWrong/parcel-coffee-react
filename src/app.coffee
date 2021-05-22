import React, {useState} from 'react'

export default App = ->
  [count, setCount] = useState 0

  <div>
    Count: {count}
    <button onClick={-> setCount count + 1}>
      Increment
    </button>
  </div>
