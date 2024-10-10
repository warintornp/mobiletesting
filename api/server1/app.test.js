const request = require('supertest')
const app = require('./app')

describe('POST pin validation', () => {
  it('200', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: '132495' })

    expect(response.status).toBe(200)
    expect(response.header.authorization).toEqual(
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
    )
  })

  it('401 Unauthorised', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: 'eiei' })

    expect(response.status).toBe(401)
    expect(response.body).toEqual({ error: 'Unauthorised' })
    expect(response.header.authorization).toBeUndefined()
  })

  it('400 pin field is absent', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ body: '243546' })

    expect(response.status).toBe(400)
    expect(response.header.authorization).toBeUndefined()
  })

  it('400 pin is null', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: null })

    expect(response.status).toBe(400)
    expect(response.body).toEqual({ error: 'Invalid request' })
    expect(response.header.authorization).toBeUndefined()
  })

  it('400 pin is empty string', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: '' })

    expect(response.status).toBe(400)
    expect(response.body).toEqual({ error: 'Invalid request' })
    expect(response.header.authorization).toBeUndefined()
  })

  afterAll((done) => {
    app.close()
    done()
  })
})

describe('GET user detail', () => {
  it('200 with user detail WHEN authToken is valid', async () => {
    const response = await request(app)
      .get('/v1/api/user')
      .set('authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')

    expect(response.status).toBe(200)
    expect(response.body).toEqual({
      name: 'John Doe',
      email: 'john.doe@example.com',
    })
  })

  it('401 Unauthorised WHEN authToken is invalid token', async () => {
    const response = await request(app)
      .get('/v1/api/user')
      .set('authorization', 'Bearer 11111')

    expect(response.status).toBe(401)
    expect(response.body).toEqual({ error: 'Unauthorised' })
  })
  it('400  WHEN authToken is invalid format', async () => {
    const response = await request(app)
      .get('/v1/api/user')
      .set('authorization', 'Bearer11111')

    expect(response.status).toBe(400)
    expect(response.body).toEqual({ error: 'Invalid request' })
  })
  it('400 WHEN authToken is absent', async () => {})
  it('401 WHEN authToken is empty string', async () => {})

  afterAll((done) => {
    app.close()
    done()
  })
})

// it('200 with valid token', async () => {
//   const response = await request(app)
//     .post('/v1/api/pin/validate')
//     .set('Authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')
//     .send({ pin: '243596' })

//   expect(response.status).toBe(200)
// })

// it('401 with invalid token', async () => {
//   const response = await request(app)
//     .post('/v1/api/pin/validate')
//     .set('Authorization', 'Bearer invalid_token')
//     .send({ pin: '132495' })

//   expect(response.status).toBe(401)
//   expect(response.body).toEqual({ error: 'Unauthorised' })
// })

// it('401 without token', async () => {
//   const response = await request(app)
//     .post('/v1/api/pin/validate')
//     .send({ pin: '132495' })

//   expect(response.status).toBe(401)
//   expect(response.body).toEqual({ error: 'Unauthorised' })
// })
