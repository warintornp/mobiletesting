import 'package:flutter/material.dart';

enum UserTier {
  gold,
  silver,
  bronze,
  unknown,
}

extension TierColorExtension on UserTier {
  Color get color {
    switch (this) {
      case UserTier.gold:
        return Colors.amber;
      case UserTier.silver:
        return Colors.grey;
      case UserTier.bronze:
        return Colors.brown;
      case UserTier.unknown:
        return Colors.black;
    }
  }
}

extension UserTierExtension on UserTier {
  static UserTier fromString(String tier) {
    switch (tier.toLowerCase()) {
      case 'gold':
        return UserTier.gold;
      case 'silver':
        return UserTier.silver;
      case 'bronze':
        return UserTier.bronze;
      default:
        return UserTier.unknown;
    }
  }
}
