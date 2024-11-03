import 'dart:math';

class PinRule {
  final bool Function(String pin) condition;
  PinRule(this.condition);
}

// workshop #3
class PinRules {
  final List<PinRule> _rules = [PinRule((pin) => isSequential(pin))];

  String? getErrorMessage(String pin) {
    return _rules[0].condition(pin) ? "Pin format is invalid" : null;
  }

  static bool isSequential(String pin) {
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
}
