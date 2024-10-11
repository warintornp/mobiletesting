import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_service.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'login_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late LoginService loginService;

  setUp(() {
    mockClient = MockClient();
    loginService = LoginService(client: mockClient);
  });
  group('authenticate', () {
    test('API call throw error', () async {
      // Arrange
      when(mockClient.post(
              Uri.parse('http://localhost:3000/v1/api/pin/validate'),
              body: jsonEncode({'pin': '123456'}),
              headers: {"content-type": "application/json"}))
          .thenThrow(Exception('error'));
      // Act
      final result = await loginService.authenticate('123456');
      // Assert
      expect(result, false);
    });
    test('API call return 400 status code', () async {
      // Arrange
      when(mockClient.post(
              Uri.parse('http://localhost:3000/v1/api/pin/validate'),
              body: jsonEncode({'pin': '123456'}),
              headers: {"content-type": "application/json"}))
          .thenAnswer((_) async => http.Response('Invalid request', 400));
      // Act
      final result = await loginService.authenticate('123456');
      // Assert
      expect(result, false);
    });
    test('API call return 401 status code', () async {
      // Arrange
      when(mockClient.post(
              Uri.parse('http://localhost:3000/v1/api/pin/validate'),
              body: jsonEncode({'pin': '123456'}),
              headers: {"content-type": "application/json"}))
          .thenAnswer((_) async => http.Response('Unauthorised', 401));
      // Act
      final result = await loginService.authenticate('123456');
      // Assert
      expect(result, false);
    });
    group('API call return 200 status code', () {
      test('API call return null authorization token', () async {
        // Arrange
        when(mockClient.post(
                Uri.parse('http://localhost:3000/v1/api/pin/validate'),
                body: jsonEncode({'pin': '123456'}),
                headers: {"content-type": "application/json"}))
            .thenAnswer((_) async => http.Response("", 200));
        // Act
        final result = await loginService.authenticate('123456');
        // Assert
        expect(result, false);
      });
      test('API call return empty string authorization token', () async {
        // Arrange
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
        expect(result, false);
      });
      test('API call return authorization token and failed store the token',
          () async {
        // Arrange
        when(mockClient.post(
                Uri.parse('http://localhost:3000/v1/api/pin/validate'),
                body: jsonEncode({'pin': '123456'}),
                headers: {"content-type": "application/json"}))
            .thenAnswer((_) async => http.Response("", 200, headers: {
                  'authorization': 'Bearer token',
                }));
        when(loginService.sharedPreferences.setString('authToken', 'Bearer'))
            .thenThrow(Exception('error'));
        // Act
        final result = await loginService.authenticate('123456');
        // Assert
        expect(result, false);
      });

      test(
          'API call return authorization token and successfully store the token',
          () {});
    });
  });
}