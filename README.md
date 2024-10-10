# mobiletesting

A new Flutter project.

## How to run 
- [run app] `flutter run`
- [run app in chrome with disable -web-security] `flutter run -d chrome --web-browser-flag "--disable-web-security"`


## Generate Mock for test class 
`dart run build_runner build`

## Goldens test
`flutter test --update-goldens --tags=golden` 

## Update Goldens Reference Image 
`flutter test --update-goldens`


## Step to start Node.js server1
1. navigate to server1's location. Given now terminal is at root project folder
`cd api/server1`
2. pull server dependency
`npm install`
3. start server
`node app.js`
4. verify server health by running `app.consumer.http`. Need to install vscode extension, [REST Client](https://marketplace.visualstudio.com/items?itemName=humao.rest-client) first.
5. Run e2e testing
`npx jest app.test.js`

Note: To run specific describe in test file, `npx jest app.test.js -t {describe name}`


## Step to start Node.js server2