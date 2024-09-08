const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

// Mock database
const users = {
  '132435': { name: 'John Doe', email: 'john.doe@example.com' },
  '243546': { name: 'Jane Smith', email: 'jane.smith@example.com' }
};

// Middleware
app.use(bodyParser.json());

// Endpoint to get user details by PIN
app.get('/getUserDetails', (req, res) => {
  const pin = req.query.pin;
  
  // Check if pin exists in the mock database
  if (users[pin]) {
    res.status(200).json(users[pin]);
  } else {
    res.status(404).json({ error: 'User not found' });
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
