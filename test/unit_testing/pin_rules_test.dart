import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';

void main() {
  group('isSequential', () {
    test(
        'when the 6 digit PIN contains sequential digits then return error message “Pin format is invalid” ',
        () {
      // Arrange

      // Act, Assert
      expect(PinRules().getErrorMessage("012345"), "Pin format is invalid");
      expect(PinRules().getErrorMessage("543210"), "Pin format is invalid");
      expect(PinRules().getErrorMessage("123456"), "Pin format is invalid");
    }, tags: 'unit');
  });

  group('isRepeatingDigits', () {
    test('when isRepeatingDigits is true then return "Pin format is invalid"',
        () {
      // Arrange

      // Act, Assert
      expect(PinRules().getErrorMessage("011234"), "Pin format is invalid");
    }, tags: 'unit');
  });
  group('isTotalEqualsToFifteen', () {
    test(
        'when isTotalEqualsToFifteen is true then return "Pin format is invalid"',
        () {
      // Arrange

      // Act, Assert
      expect(PinRules().getErrorMessage("015234"), "Pin format is invalid");
    }, tags: 'unit');

    test(
        'when pin is not sequential and not total equals to 15 and no repeating digit then return null',
        () {
      // Arrange

      // Act, Assert
      expect(PinRules().getErrorMessage("015238"), null);
      expect(PinRules().getErrorMessage("012875"), null);
    }, tags: 'unit');
  });
}
