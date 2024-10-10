const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 3000

const authToken = {
  132495: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
  243596: 'eyJlbWFpbCI6InBhdEBleGFtcGxlLmNvbSJ9',
  987123: 'rr4RIu-hZkeryZRXK7dEwquQn4rVGqZFEmKWwuR_kYs',
}
const users = {
  eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9: {
    name: 'John Doe',
    email: 'john.doe@example.com',
  },
  eyJlbWFpbCI6InBhdEBleGFtcGxlLmNvbSJ9: {
    name: 'Jane Smith',
    email: 'jane.smith@example.com',
  },
  'rr4RIu-hZkeryZRXK7dEwquQn4rVGqZFEmKWwuR_kYs': {
    name: 'Patties Brown',
    email: 'pat@example.com',
  },
}

app.use(bodyParser.json())
app.post('/v1/api/pin/validate', (req, res) => {
  const pin = req.body.pin
  // const pin = req.body.body //hidden bug for scenario#2
  console.log(`req.body + ${JSON.stringify(req.body)}`)
  if (pin === undefined || pin === null || pin === '') {
    res.status(400).json({ error: 'Invalid request' })
    console.log('400')
  } else if (authToken[pin] === undefined) {
    res.status(401).json({ error: 'Unauthorised' })
    console.log('401 ja')
  } else {
    // res.status(200).json(users[req.body.pin]);

    res.setHeader('Authorization', 'Bearer ' + authToken[pin])
    res.status(200).json()
    console.log('200 ja')
  }
})

var server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`)
})
module.exports = server
