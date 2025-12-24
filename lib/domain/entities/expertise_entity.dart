import 'package:flutter/material.dart';
import 'skill_entity.dart';

/// Domain entity representing a technical expertise category.
class ExpertiseEntity {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<String> skills;
  final List<SkillEntity> skillEntities;
  final String? customIconUrl;
  final bool useCustomImage;

  const ExpertiseEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
    this.skillEntities = const [],
    this.customIconUrl,
    this.useCustomImage = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpertiseEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
