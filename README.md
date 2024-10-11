## Mock app(Flutter app)

### Step to start Flutter app
- [run app] `flutter run`
- [run app in chrome with disable -web-security] `flutter run -d chrome --web-browser-flag "--disable-web-security"`

### Generate Mock for test class 
`dart run build_runner build`

### Goldens test
`flutter test --update-goldens --tags=golden` 

### Update Goldens Reference Image 
`flutter test --update-goldens`

### Troubleshooting
Error: cocopod not install or not invalid state. Solution [Intel one](https://stackoverflow.com/questions/62593939/cocoapods-not-installed-or-not-in-valid-state), [ARM one](https://stackoverflow.com/questions/64901180/how-to-run-cocoapods-on-apple-silicon-m1)


## Node.js server1
### Step to start Node.js server1
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

## Node.js server2
### Step to start Node.js server2






## E2E testing (FE-BE)
### Steps to install and run E2E test using Maestro framework
1. Install [curl -fsSL "https://get.maestro.mobile.dev" | bash ](https://maestro.mobile.dev/getting-started/installing-maestro)
2. Locate to maestro test folder
`cd e2e_test`
3. run e2e test
`maestro test login.yaml`

### Steps to run E2E test using flutter framework
1. Require server1 running
`cd api/server1`
`node app.js`
2. Running integration test 
`flutter test integration_test/app_test.dart`

