const request = require('supertest')
const nock = require('nock')
const { app } = require('./app')

describe('POST pin validation', () => {
  it('return 200 when pin exists', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: '132495' })

    expect(response.status).toBe(200)
    expect(response.header.authorization).toEqual("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9");
  })

  it('return 401 when pin exists', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: '132496' })

    expect(response.status).toBe(401)
    expect(response.body.error).toBe("Unauthorised")
  })

  it('return 400 when pin input is null', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: null })

    expect(response.status).toBe(400)
    expect(response.body.error).toBe("Invalid request")
  })

  it('return 400 when pin input is empty', async () => {
    const response = await request(app)
      .post('/v1/api/pin/validate')
      .send({ pin: '' })

    expect(response.status).toBe(400)
    expect(response.body.error).toBe("Invalid request")
  })

  it('return 400 when pin input is undefined', async () => {
    const response = await request(app).post('/v1/api/pin/validate').send()

    expect(response.status).toBe(400)
    expect(response.body.error).toBe("Invalid request")
  })

  afterAll((done) => {
    app.close()
    done()
  })
})

describe('GET user detail', () => {
  describe('auth token is valid', () => {
    it('200 with user detail WHEN authToken is valid and able to retrieve tier and point', async () => {
      // Arrange
      const server2BasedUrl = 'http://localhost:4000'
      nock(server2BasedUrl)
        .get('/v1/api/user/point')
        .reply(200, { point: 1000 })
      nock(server2BasedUrl)
        .get('/v1/api/user/tier')
        .reply(200, { tier: 'bronze' })

      // Act
      const response = await request(app)
        .get('/v1/api/user')
        .set('Authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')

      //Assert should be like this make test cannot capture changes from server2 contract
      expect(response.status).toBe(200)
      expect(response.body.name).toEqual('John Doe')
      expect(response.body.email).toEqual('john.doe@example.com')
      expect(response.body.tier).toEqual('bronze')
      expect(response.body.point).toEqual(1000)

      expect(response.header.authorization).toEqual(
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
      )
    })

    it('200 with user detail without tier WHEN cannot retrieve user tier', async () => {
      // Arrange
      const server2BasedUrl = 'http://localhost:4000'
      nock(server2BasedUrl)
        .get('/v1/api/user/point')
        .reply(200, { point: 1000 })
      nock(server2BasedUrl)
        .get('/v1/api/user/tier')
        .reply(200, { notFoundTier: 'bronze' })

      // Act
      const response = await request(app)
        .get('/v1/api/user')
        .set('Authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')

      //Assert should be like this make test cannot capture changes from server2 contract
      expect(response.status).toBe(200)
      expect(response.body.name).toEqual('John Doe')
      expect(response.body.email).toEqual('john.doe@example.com')
      expect(response.body.tier).toEqual(undefined)
      expect(response.body.point).toEqual(1000)

      expect(response.header.authorization).toEqual(
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
      )
    })

    it('200 with user detail without tier WHEN the endpoint return error code', async () => {
      // Arrange
      const server2BasedUrl = 'http://localhost:4000'
      nock(server2BasedUrl)
        .get('/v1/api/user/point')
        .reply(200, { point: 1000 })

      nock(server2BasedUrl)
        .get('/v1/api/user/tier')
        .reply(500, { error: 'Internal Server Error' })

      // Act
      const response = await request(app)
        .get('/v1/api/user')
        .set('Authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')

      //Assert should be like this make test cannot capture changes from server2 contract
      expect(response.status).toBe(200)
      expect(response.body.name).toEqual('John Doe')
      expect(response.body.email).toEqual('john.doe@example.com')
      expect(response.body.tier).toEqual(undefined)
      expect(response.body.point).toEqual(1000)

      expect(response.header.authorization).toEqual(
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
      )
    })
  })

  it('401 Unauthorised WHEN authToken is invalid token', async () => {
    const response = await request(app)
      .get('/v1/api/user')
      .set('Authorization', 'Bearer 11111')

    expect(response.status).toBe(401)
    expect(response.body).toEqual({ error: 'Unauthorised' })
  })
  it('400  WHEN authToken is invalid format', async () => {
    const response = await request(app)
      .get('/v1/api/user')
      .set('Authorization', 'Bearer11111')

    expect(response.status).toBe(400)
    expect(response.body).toEqual({ error: 'Invalid request' })
  })
  it('401 Unauthorised WHEN authToken is absent', async () => {
    const response = await request(app).get('/v1/api/user')

    expect(response.status).toBe(401)
    expect(response.body).toEqual({ error: 'Unauthorised' })
  })
  it('400 WHEN authToken is empty string', async () => {
    const response = await request(app)
      .get('/v1/api/user')
      .set('Authorization', '')

    expect(response.status).toBe(400)
    expect(response.body).toEqual({ error: 'Invalid request' })
  })

  afterAll((done) => {
    nock.cleanAll()
    app.close()
    done()
  })
})
