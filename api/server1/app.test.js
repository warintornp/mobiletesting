const request = require('supertest')
const app = require('./app')

describe('POST /v1/api/pin/validate', () => {
  it('200', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: '243546' })

    expect(response.status).toBe(401)
  })

  it('401 Unauthorised', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: 'eiei' })

    expect(response.status).toBe(401)
    expect(response.body).toEqual({ error: 'Unauthorised' })
  })

  it('400 pin is absent', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ body: '243546' })

    expect(response.status).toBe(400)
  })

  it('400 pin is null', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: null })

    expect(response.status).toBe(400)
  })

  it('400 pin is empty string', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: '' })

    expect(response.status).toBe(400)
  })

  afterAll((done) => {
    app.close()
    done()
  })
})
