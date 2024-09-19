import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/pin_rules.dart';

void main() {
  group('PinRules', () {
    test('validate should return true for complied pin', () {
      // Arrange
      final pinRules = PinRules();

      // Assert
      expect(pinRules.validate("132435"), true);
      expect(pinRules.validate("243546"),
          true); // Replace 'Expected Result' with the actual expected result
    });
  });
}
