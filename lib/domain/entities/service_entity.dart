import 'package:flutter/material.dart';

/// Domain entity representing a service offered.
/// This is a pure Dart class with no framework dependencies (except Flutter for IconData/Color).
class ServiceEntity {
  final String id;
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final String? customIconUrl;
  final bool useCustomImage;

  const ServiceEntity({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.customIconUrl,
    this.useCustomImage = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
