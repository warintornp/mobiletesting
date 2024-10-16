const { PactV4 } = require('@pact-foundation/pact')
const path = require('path')
const { fetchUserPoint } = require('./app');
const { error } = require('console');

const provider = new PactV4({
    consumer: 'server1',
    provider: 'server2',
    dir: path.resolve(__dirname, 'pacts'),
    logLevel: 'DEBUG',
});

describe('Requesting point from server 2', () => {
    it('has auth token', async () => {
        await provider
            .addInteraction()
            .given('user authorization')
            .uponReceiving('a request for point')
            .withRequest('GET', '/v1/api/user/point', (builder) => {
                builder.headers({ Authorization: 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9' })
            })
            .willRespondWith(200, (builder) => {
                builder.jsonBody({ point: 100 })
            })
            .executeTest(async (mockService) => {
                const response = await fetchUserPoint(mockService.url, 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9')
                console.log(response)
                expect(response.point).toBe(100);
            })
    })

    it('has no auth token', async () => {
        await provider
            .addInteraction()
            .given('user authorization')
            .uponReceiving('a request for point')
            .withRequest('GET', '/v1/api/user/point', (builder) => {
                builder.headers({ Authorization: '' })
            })
            .willRespondWith(400, (builder) => {
                builder.jsonBody({error: 'Invalid request'})
            })
            .executeTest(async (mockService) => {
                const response = await fetchUserPoint(mockService.url, '')
                console.log(response)
                expect(response.error).toBe('Invalid request');
            })
    })
})