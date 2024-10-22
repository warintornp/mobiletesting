import 'dart:math';

class PinRule {
  final bool Function(String pin) condition;
  final String description;

  PinRule(this.condition, this.description);
}

class PinRules {
  final List<PinRule> _rules = [
    PinRule((pin) => sixLength(pin), "Must be 6 characters long"),
    PinRule((pin) => containsOnlyDigits(pin), "PIN must contain only digits"),
    PinRule((pin) => !isSequential(pin), "PIN must not be sequential"),
    PinRule((pin) => !hasSameNumber(pin), "PIN must not have repeating digits"),
    PinRule((pin) => !totalEqualsToThirteen(pin),
        "Sum of digits must not be equal to 13"),
  ];

  // bool validate(String pin) {
  //   return _rules.every((rule) => rule.rule(pin));
  // }

  // String? validate(String pin) {
  //   return _rules.map((rule) {
  //     if (!rule.condition(pin)) {
  //       print("validate failed: " + rule.description);
  //       return false;
  //       // return rule.description;
  //     }
  //     return true;
  //     // return null;
  //   }).every((result) => result);
  // }

  String? getErrorMessage(String pin) {
    for (int i = 0; i < _rules.length; i++) {
      if (!_rules[i].condition(pin)) {
        return _rules[i].description;
      }
    }
    return null;
  }

  static bool sixLength(String pin) {
    return pin.length == 6;
  }

  static bool containsOnlyDigits(String pin) {
    return pin.contains(RegExp(r'^[0-9]+$'));
  }

  static bool isSequential(String pin) {
    //012345 - true
    //543210 - true
    //123456 - true
    //012875 - false
    if (pin.length < 2) return false;

    bool isIncreasing = true;
    bool isDecreasing = true;

    for (int i = 0; i < pin.length - 1; i++) {
      int currentDigit = int.parse(pin[i]);
      int nextDigit = int.parse(pin[i + 1]);

      if (currentDigit + 1 != nextDigit) {
        isIncreasing = false;
      }
      if (currentDigit - 1 != nextDigit) {
        isDecreasing = false;
      }
    }

    return isIncreasing || isDecreasing;
  }

  static bool hasSameNumber(String pin) {
    Set<String> distinctChars = {};

    for (int i = 0; i < pin.length; i++) {
      distinctChars.add(pin[i]);
    }

    return distinctChars.join().length < pin.length;
  }

  static bool totalEqualsToThirteen(String pin) {
    int total = 0;
    for (int i = 0; i < pin.length; i++) {
      total += int.parse(pin[i]);
    }
    return total == 13;
  }
}
