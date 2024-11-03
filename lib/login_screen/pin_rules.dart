import 'dart:math';

class PinRule {
  final bool Function(String pin) condition;
  PinRule(this.condition);
}

// workshop #3
class PinRules {
  final List<PinRule> _rules = [
    PinRule((pin) => isSequential(pin)),
    PinRule((pin) => isRepeatingDigits(pin)),
    PinRule((pin) => isTotalEqualsToFifteen(pin))
  ];

  String? getErrorMessage(String pin) {
    for (int i = 0; i < _rules.length; i++) {
      if (_rules[i].condition(pin)) {
        return "Pin format is invalid";
      }
    }
    return null;
    // return _rules[0].condition(pin) ? "Pin format is invalid" : null;
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

  static bool isRepeatingDigits(String pin) {
    return pin.length != pin.split('').toSet().length;
  }

  static bool isTotalEqualsToFifteen(String pin) {
    int total = 0;
    for (int i = 0; i < pin.length; i++) {
      total += int.parse(pin[i]);
    }
    return total == 15;
  }
}
