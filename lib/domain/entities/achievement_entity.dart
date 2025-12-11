import 'package:flutter/material.dart';

/// Domain entity representing an achievement.
class AchievementEntity {
  final String id;
  final IconData icon;
  final String text;

  const AchievementEntity({
    required this.id,
    required this.icon,
    required this.text,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
