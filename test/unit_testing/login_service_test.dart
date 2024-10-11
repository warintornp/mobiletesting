import 'package:flutter_test/flutter_test.dart';

void main() {
  group('authenticate', () {
    test('API call throw error', () {});
    test('API call return non-200 status code', () {});
    group('API call return 200 status code', () {
      test('API call return null authorization token', () {});
      test(
          'API call return authorization token and successfully store the token',
          () {});
      test('API call return authorization token and failed store the token',
          () {});
    });
  });
}
