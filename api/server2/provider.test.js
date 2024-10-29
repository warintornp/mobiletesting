const { Verifier } = require('@pact-foundation/pact');
const path = require('path');

//Start server 2
const { server } = require('./app.js');
// const server = app.listen('4000');

describe('Pact verification', () => {

    it('should validate the contract with ConsumerService', () => {
        const opts = {
            providerBaseUrl: "http://localhost:4000",
            provider: "server2",
            pactUrls: [path.resolve(__dirname, '../server1/pacts/server1-server2.json')]
        };

        return new Verifier(opts).verifyProvider().then(output => {
            console.log(output);
        }).finally(() => server.close()); //Close server2
    });
});