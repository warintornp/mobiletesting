const { Verifier } = require('@pact-foundation/pact');
const path = require('path');
//Start server 2
const { app } = require('./app.js');
// const server = app.listen('4000');

describe('Pact verification', () => {

    it('should validate the contract with ConsumerService', () => {
        const config = {
            providerBaseUrl: "http://localhost:4000",
            provider: "server2",
            pactUrls: [path.resolve(__dirname, '../server1/pacts/server1-server2.json')]
        };

        return new Verifier(config).verifyProvider().then(output => {
            console.log("result" + output);
        }).finally(() => app.close()); //Close server2
    });
});