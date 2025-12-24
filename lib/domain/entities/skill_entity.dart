import 'package:flutter/material.dart';

/// Domain entity representing a skill with optional icon support.
class SkillEntity {
  final String name;
  final IconData? icon;
  final String? customIconUrl;
  final bool useCustomImage;

  const SkillEntity({
    required this.name,
    this.icon,
    this.customIconUrl,
    this.useCustomImage = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillEntity &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
