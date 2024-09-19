import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/pin_rules.dart';

void main() {
  group('PinRules', () {
    test('return false when has same digit', () {
      // Arrange
      final pinRules = PinRules();

      // Assert
      expect(pinRules.validate("132435"), false);
      expect(pinRules.validate("243546"),
          false); // Replace 'Expected Result' with the actual expected result
    });

    test('return true when rules are compiled', () {
      // Arrange
      final pinRules = PinRules();

      // Assert
      expect(pinRules.validate("132495"), true);
      expect(pinRules.validate("243596"), true);
      expect(pinRules.validate("987123"),
          true); // Replace 'Expected Result' with the actual expected result
    });
  });
}
