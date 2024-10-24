import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';

void main() {
  test(
      'Given the PIN contains sequential digits when validate then error message return',
      () {
    final pin1 = "012345";
    expect(PinRules().getErrorMessage(pin1), "Pin format is invalid");

    final pin2 = "123456";
    expect(PinRules().getErrorMessage(pin2), "Pin format is invalid");

    final pin3 = "543210";
    expect(PinRules().getErrorMessage(pin3), "Pin format is invalid");
  });

  test(
      'Given the PIN is not contains sequential digits when validate then error message should be null',
      () {
    expect(PinRules().getErrorMessage("012875"), null);
  });
}
