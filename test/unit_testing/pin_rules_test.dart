import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';

void main() {
  test(
      'Given The customer is entering 6 digit a PIN when the PIN contains sequential digits then error message return',
      () {
    final pin1 = "012345";
    expect(PinRules().getErrorMessage(pin1), "Pin format is invalid");

    // final pin2 = "543210";
    // expect(PinRules().getErrorMessage(pin2), "Pin format is invalid");

    // final pin3 = "123456";
    // expect(PinRules().getErrorMessage(pin3), "Pin format is invalid");
  });
}
