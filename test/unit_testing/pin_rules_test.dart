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

    test('when the 6 digit PIN is not sequential digits then return null ', () {
      // Arrange

      // Act, Assert
      expect(PinRules().getErrorMessage("012875"), null);
    }, tags: 'unit');
  });
}
