import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/user_tier.dart';

void main() {
  group('TierColorExtension', () {
    test('Gold tier should return amber color', () {
      expect(UserTier.gold.color, equals(Colors.amber));
    });

    test('Silver tier should return grey color', () {
      expect(UserTier.silver.color, equals(Colors.grey));
    });

    test('Bronze tier should return brown color', () {
      expect(UserTier.bronze.color, equals(Colors.brown));
    });
  });

  group('UserTierExtension', () {
    test('fromString should return UserTier.gold for "gold"', () {
      expect(UserTierExtension.fromString('gold'), equals(UserTier.gold));
    });

    test('fromString should return UserTier.silver for "silver"', () {
      expect(UserTierExtension.fromString('silver'), equals(UserTier.silver));
    });

    test('fromString should return UserTier.bronze for "bronze"', () {
      expect(UserTierExtension.fromString('bronze'), equals(UserTier.bronze));
    });

    test('fromString should be case-insensitive', () {
      expect(UserTierExtension.fromString('GOLD'), equals(UserTier.gold));
      expect(UserTierExtension.fromString('Silver'), equals(UserTier.silver));
      expect(UserTierExtension.fromString('brONzE'), equals(UserTier.bronze));
    });

    test('fromString should return UserTier.bronze for unknown string', () {
      expect(UserTierExtension.fromString('unknown'), equals(UserTier.bronze));
    });
  });
}
