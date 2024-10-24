import 'dart:math';

class PinRule {
  final bool Function(String pin) condition;
  final String description;

  PinRule(this.condition, this.description);
}

// workshop #3
class PinRules {
  final List<PinRule> _rules = [
    PinRule((pin) => !isSequential(pin), "Pin format is invalid"),
  ];

  String? getErrorMessage(String pin) {
    // possible to return null or error message
    if (!_rules[0].condition(pin)) {
      return _rules[0].description;
    } else {
      return null;
    }
  }

  static bool isSequential(String pin) {
    bool isIncreasing = true;

    for (int i = 0; i < pin.length - 1; i++) {
      int currentDigit = int.parse(pin[i]);
      int nextDigit = int.parse(pin[i + 1]);

      if (currentDigit + 1 != nextDigit) {
        isIncreasing = false;
      }
    }

    return isIncreasing;
  }
}
