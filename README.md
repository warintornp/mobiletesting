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


## Node.js server1
### navigate to server1's location. Given now terminal is at root project folder
`cd api/server1`
### pull server dependency
`yarn install`
### start server
`node getUserDetails.js`
### Run e2e testing
`npx jest app.test.js`