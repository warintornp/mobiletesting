const request = require('supertest')
const app = require('./getUserDetails')

describe('POST /v1/api/pin/validate', () => {
  it('200', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: '243546' })

    expect(response.status).toBe(200) // Adjust the expected status code
    // expect(response.body).toEqual({ valid: true })
  })

  it('401 Unauthorised', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: 'eiei' })

    expect(response.status).toBe(401)
    expect(response.body).toEqual({ error: 'Unauthorised' })
  })

  it('400 pin is absent', async () => {
    const response = await request(app).post('/v1/api/pin/validate').send({})

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
