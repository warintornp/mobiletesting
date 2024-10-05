import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/pin_rules.dart';

void main() {
  group('PinRules', () {
    test('return false when has same digit', () {
      // Arrange
      final pinRules = PinRules();

      // Assert
      expect(pinRules.getErrorMessage("132435"),
          'PIN must not have repeating digits');
      expect(pinRules.getErrorMessage("243546"),
          'PIN must not have repeating digits');
    });

    test('return true when rules are compiled', () {
      // Arrange
      final pinRules = PinRules();

      // Assert
      expect(pinRules.getErrorMessage("132495"), null);
      expect(pinRules.getErrorMessage("243596"), null);
      expect(pinRules.getErrorMessage("987123"), null);
    });
  });
}
