const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const port = 4000

app.use(bodyParser.json())
app.get('/v1/api/user/tier', (req, res) => {
  res.status(200).json('')
})
app.get('/v1/api/user/point', (req, res) => {
  res.status(200).json('')
})

var server = app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`)
})
module.exports = server
