const request = require('supertest')
const app = require('./app')

describe('POST /v1/api/pin/validate', () => {
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
    expect(response.header.authorization).toBeUndefined()
  })

  it('400 pin is empty string', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: '' })

    expect(response.status).toBe(400)
    expect(response.header.authorization).toBeUndefined()
  })

  afterAll((done) => {
    app.close()
    done()
  })
})
