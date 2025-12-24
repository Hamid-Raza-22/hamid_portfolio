import 'package:flutter/material.dart';

/// Domain entity representing a work experience entry.
class ExperienceEntity {
  final String id;
  final String title;
  final String company;
  final String location;
  final String duration;
  final List<String> highlights;
  final IconData? icon;
  final Color? color;
  final String? customIconUrl;
  final bool useCustomImage;
  final int order;

  const ExperienceEntity({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.duration,
    required this.highlights,
    this.icon,
    this.color,
    this.customIconUrl,
    this.useCustomImage = false,
    this.order = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperienceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
