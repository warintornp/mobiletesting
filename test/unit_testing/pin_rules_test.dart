import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';

void main() {
  group('isSequential', () {
    test('Given the PIN is sequential when validate then return true', () {
      final pin1 = "012345";
      expect(PinRules.isSequential(pin1), true);

      final pin2 = "123456";
      expect(PinRules.isSequential(pin2), true);

      final pin3 = "543210";
      expect(PinRules.isSequential(pin3), true);
    }, tags: 'unit');

    test('Given the PIN is sequential when validate then return false', () {
      final pin1 = "012875";
      expect(PinRules.isSequential(pin1), false);
    }, tags: 'unit');
  });
  // test(
  //     'Given the PIN contains sequential digits when validate then error message return',
  //     () {
  //   final pin1 = "012345";
  //   expect(PinRules().getErrorMessage(pin1), "Pin format is invalid");

  //   final pin2 = "123456";
  //   expect(PinRules().getErrorMessage(pin2), "Pin format is invalid");

  //   final pin3 = "543210";
  //   expect(PinRules().getErrorMessage(pin3), "Pin format is invalid");
  // });

  // test(
  //     'Given the PIN is not contains sequential digits when validate then error message should be null',
  //     () {
  //   expect(PinRules().getErrorMessage("012875"), null);
  // });

  test(
      'Given the PIN does not contains sequential digits but contains repeating digits then return error message',
      () {
    expect(PinRules().getErrorMessage("012872"), "Pin format is invalid");
  });
  test(
      'Given The customer is entering 6 digit a PIN when the PIN does not contains sequential digits And does not contains repeating digits then success message dialog displayed',
      () {
    expect(PinRules().getErrorMessage("012873"), null);
  });
}
