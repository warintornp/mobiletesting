const { PactV4 } = require('@pact-foundation/pact')
const path = require('path')
const { app, fetchUserPoint, fetchUserTier } = require('./app');

const provider = new PactV4({
    consumer: 'server1',
    provider: 'server2',
    dir: path.resolve(__dirname, 'pacts')
})

describe('Requesting point from server 2', () => {
    it('auth token is valid', async () => {
        await provider.addInteraction()
            .given('valid auth token')
            .uponReceiving('requesting user point')
            .withRequest('GET', '/v1/api/user/point', (builder) => {
                builder.headers({ Authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9' })
            })
            .willRespondWith(200, (builder) => {
                builder.jsonBody({ point: 100 })
            })
            .executeTest( async (mockService) => {
                console.log(mockService.url)
                const response = await fetchUserPoint(mockService.url, 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')
                expect(response.point).toBe(100);
            })
    })
    it('auth token is invalid', async () => {
        await provider.addInteraction()
            .given('invalid auth token')
            .uponReceiving('requesting user point')
            .withRequest('GET', '/v1/api/user/point', (builder) => {
                builder.headers({ Authorization: 'Bearer 123' })
            })
            .willRespondWith(401, (builder) => {
                builder.jsonBody({ point: undefined })
            })
            .executeTest( async (mockService) => {
                const response = await fetchUserPoint(mockService.url, 'Bearer 123')
                expect(response.point).toBe(undefined);
            })
    })
    afterAll((done) => {
        app.close()
        done()
      })
})

describe('Requesting tier from server 2', () => {
    it('auth token is valid', async () => {
        await provider.addInteraction()
            .given('valid auth token')
            .uponReceiving('requesting user tier')
            .withRequest('GET', '/v1/api/user/tier', (builder) => {
                builder.headers({ Authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9' })
            })
            .willRespondWith(200, (builder) => {
                builder.jsonBody({ tier: 'bronze' })
            })
            .executeTest( async (mockService) => {
                const response = await fetchUserTier(mockService.url, 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')
                expect(response.tier).toBe('bronze');
            })
    })
    it('auth token is invalid', async () => {
        await provider.addInteraction()
            .given('invalid auth token')
            .uponReceiving('requesting user tier')
            .withRequest('GET', '/v1/api/user/tier', (builder) => {
                builder.headers({ Authorization: 'Bearer 123' })
            })
            .willRespondWith(401, (builder) => {
                builder.jsonBody({ tier: undefined })
            })
            .executeTest( async (mockService) => {
                const response = await fetchUserTier(mockService.url, 'Bearer 123')
                expect(response.tier).toBe(undefined);
            })
    })
    afterAll((done) => {
        app.close()
        done()
      })
})