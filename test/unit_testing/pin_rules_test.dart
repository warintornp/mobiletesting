import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';

void main() {
  group('isSequential', () {
    test('Given the PIN is sequential when evaluate then return true', () {
      final pin1 = "012345";
      expect(PinRules.isSequential(pin1), true);

      final pin2 = "123456";
      expect(PinRules.isSequential(pin2), true);

      final pin3 = "543210";
      expect(PinRules.isSequential(pin3), true);
    }, tags: 'unit');

    test('Given the PIN is sequential when evaluate then return false', () {
      final pin1 = "012875";
      expect(PinRules.isSequential(pin1), false);
    }, tags: 'unit');
  });

  group('isRepeatingDigits', () {
    test('Given the PIN is Repeating Digits when evaluate then return true',
        () {
      final pin1 = "012342";
      expect(PinRules.isRepeatingDigits(pin1), true);
    }, tags: 'unit');

    test(
        'Given the PIN is not Repeating Digits when evaluate then return false',
        () {
      final pin1 = "012875";
      expect(PinRules.isRepeatingDigits(pin1), false);
    }, tags: 'unit');
  });

  group('isTotalEqualsToFifteen', () {
    test(
        'Given the PIN is Total Equals To Fifteen when evaluate then return true',
        () {
      final pin1 = "012345";
      expect(PinRules.isTotalEqualsToFifteen(pin1), true);
    }, tags: 'unit');

    test(
        'Given the PIN is Total Equals To Fifteen when evaluate then return false',
        () {
      final pin1 = "012875";
      expect(PinRules.isTotalEqualsToFifteen(pin1), false);
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
      'Given the PIN does not contains sequential digits and does not contains repeating digits but total is 15 then return error message',
      () {
    expect(PinRules().getErrorMessage("012453"), "Pin format is invalid");
  });
  test(
      'Given The customer is entering 6 digit a PIN when the PIN does not contains sequential digits And does not contains repeating digits And total is not 15 then success message dialog displayed',
      () {
    expect(PinRules().getErrorMessage("012873"), null);
  });
}
