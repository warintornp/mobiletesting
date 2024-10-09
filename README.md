# mobiletesting

A new Flutter project.

## How to run 
- [run app] `flutter run`
- [run app in chrome with disable -web-security] `flutter run -d chrome --web-browser-flag "--disable-web-security"`
- [run api] `yarn install` && `node getUserDetails.js`

## Generate Mock for test class 
`dart run build_runner build`

## Goldens test
`flutter test --update-goldens --tags=golden` 

## Update Goldens Reference Image 
`flutter test --update-goldens`


# Node.js server1
## e2e testing
`npx jest app.test.js`