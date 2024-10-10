const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 3000

// Mock database
const users = {
  132495: { name: 'John Doe', email: 'john.doe@example.com' },
  243596: { name: 'Jane Smith', email: 'jane.smith@example.com' },
  987123: { name: 'Patties Brown', email: 'pat@example.com' },
}

app.use(bodyParser.json())
app.post('/v1/api/pin/validate', (req, res) => {
  const pin = req.body.pin
  // const pin = req.body.body //hidden bug for scenario#2
  console.log(`req.body + ${JSON.stringify(req.body)}`)
  if (pin === undefined || pin === null || pin === '') {
    res.status(400).json({ error: 'Invalid request' })
    console.log('400')
  } else if (users[pin] === undefined) {
    res.status(401).json({ error: 'Unauthorised' })
    console.log('401 ja')
  } else {
    res.status(200).json(users[req.body.pin])
    console.log('200 ja')
  }
})

var server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`)
})
module.exports = server
