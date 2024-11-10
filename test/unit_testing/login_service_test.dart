import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/authorization_status.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mobiletesting/secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'login_service_test.mocks.dart';

@GenerateMocks([http.Client, SecureStorage])
void main() {
  MockClient mockClient = MockClient();
  MockSecureStorage mockSecureStorage = MockSecureStorage();
  late LoginService loginService;

  setUp(() {
    loginService =
        LoginService(client: mockClient, secureStorage: mockSecureStorage);
  });
  group('authenticate', () {
    test('return technical error when API call return 400 status code',
        () async {
      // Arrange
      when(mockClient.post(
              Uri.parse('http://localhost:3000/v1/api/pin/validate'),
              body: jsonEncode({'pin': '123456'}),
              headers: {"content-type": "application/json"}))
          .thenAnswer((_) async => http.Response('Invalid request', 400));
      // Act
      final result = await loginService.authenticate('123456');
      // Assert
      expect(result, AuthorizationStatus.technicalError);
    }, tags: 'unit');
    test('return unauthorised error when API call return 401 status code',
        () async {
      // Arrange
      when(mockClient.post(
              Uri.parse('http://localhost:3000/v1/api/pin/validate'),
              body: jsonEncode({'pin': '123456'}),
              headers: {"content-type": "application/json"}))
          .thenAnswer((_) async => http.Response('Unauthorised', 401));
      // Act
      final result = await loginService.authenticate('123456');
      // Assert
      expect(result, AuthorizationStatus.unauthorised);
    }, tags: 'unit');
    group('API call return 200 status code', () {
      test(
          'return technical error when API call return null authorization token',
          () async {
        // Arrange
        when(mockClient.post(
                Uri.parse('http://localhost:3000/v1/api/pin/validate'),
                body: jsonEncode({'pin': '123456'}),
                headers: {"content-type": "application/json"}))
            .thenAnswer((_) async => http.Response("", 200));

        // Act
        final result = await loginService.authenticate("123456");
        // Assert
        expect(result, AuthorizationStatus.technicalError);
      }, tags: 'unit');
      test(
          'return technical error when API call return empty string authorization token',
          () async {
        when(mockClient.post(
                Uri.parse('http://localhost:3000/v1/api/pin/validate'),
                body: jsonEncode({'pin': '123456'}),
                headers: {"content-type": "application/json"}))
            .thenAnswer((_) async => http.Response("", 200, headers: {
                  'authorization': '',
                }));
        // Act
        final result = await loginService.authenticate('123456');
        // Assert
        expect(result, AuthorizationStatus.technicalError);
      }, tags: 'unit');
      test(
          'return Technical error when API call return authorization token and error when store the token',
          () async {
        // Arrange
        when(mockClient.post(
                Uri.parse('http://localhost:3000/v1/api/pin/validate'),
                body: jsonEncode({'pin': '123456'}),
                headers: {"content-type": "application/json"}))
            .thenAnswer((_) async => http.Response("", 200, headers: {
                  'authorization': 'Bearer token',
                }));
        when(mockSecureStorage.store('authToken', 'Bearer token'))
            .thenThrow(Exception('error'));
        // Act
        final result = await loginService.authenticate('123456');
        // Assert
        expect(result, AuthorizationStatus.technicalError);
      }, tags: 'unit');

      test(
          'return success when API call return authorization token and successfully or failed store the token',
          () async {
        // Arrange
        when(mockClient.post(
                Uri.parse('http://localhost:3000/v1/api/pin/validate'),
                body: jsonEncode({'pin': '123456'}),
                headers: {"content-type": "application/json"}))
            .thenAnswer((_) async => http.Response("", 200, headers: {
                  'authorization': 'Bearer token',
                }));
        when(mockSecureStorage.store('authToken', 'Bearer token'))
            .thenAnswer((_) async {});
        // Act
        final result = await loginService.authenticate('123456');
        // Assert
        expect(result, AuthorizationStatus.success);
      }, tags: 'unit');
    });
  });
}
