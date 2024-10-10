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



## Steps to install and run maestro (e2e test framework)
1. Install [curl -fsSL "https://get.maestro.mobile.dev" | bash ](https://maestro.mobile.dev/getting-started/installing-maestro)
2. Locate to maestro test folder
`cd e2e_test`
3. run e2e test
`maestro test login.yaml`


## Troubleshooting
Error: cocopod not install or not invalid state. Solution [Intel one](https://stackoverflow.com/questions/62593939/cocoapods-not-installed-or-not-in-valid-state), [ARM one](https://stackoverflow.com/questions/64901180/how-to-run-cocoapods-on-apple-silicon-m1)

