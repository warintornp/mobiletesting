import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/pin_rules.dart';

void main() {
  group('PinRules', () {
    test('return error message WHEN pin contains specific digit twices', () {
      // Arrange
      final pinRules = PinRules();

      // Assert
      expect(pinRules.getErrorMessage("132435"),
          'PIN must not have repeating digits');
      expect(pinRules.getErrorMessage("243546"),
          'PIN must not have repeating digits');
    }, tags: 'unit');

    test('return no error message WHEN rules are compiled', () {

      // Arrange
      final pinRules = PinRules();
      // Assert
      expect(pinRules.getErrorMessage("132495"), null);
      expect(pinRules.getErrorMessage("243596"), null);
      expect(pinRules.getErrorMessage("987123"), null);
    }, tags: 'unit');
  });
}
