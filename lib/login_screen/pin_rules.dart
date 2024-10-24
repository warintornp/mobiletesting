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
    if (pin == "012345") {
      return true;
    } else {
      return false;
    }
  }
}
