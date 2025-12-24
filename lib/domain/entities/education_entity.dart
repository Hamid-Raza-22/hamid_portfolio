import 'package:flutter/material.dart';

/// Domain entity representing an education entry.
class EducationEntity {
  final String id;
  final String degree;
  final String institution;
  final String duration;
  final String? cgpa;
  final String? specialization;
  final String? project;
  final IconData? icon;
  final Color? color;
  final String? customIconUrl;
  final bool useCustomImage;
  final int order;

  const EducationEntity({
    required this.id,
    required this.degree,
    required this.institution,
    required this.duration,
    this.cgpa,
    this.specialization,
    this.project,
    this.icon,
    this.color,
    this.customIconUrl,
    this.useCustomImage = false,
    this.order = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EducationEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
