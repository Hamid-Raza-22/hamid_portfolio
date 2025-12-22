import 'package:flutter/material.dart';

/// Domain entity representing a portfolio project.
class PortfolioEntity {
  final String id;
  final String title;
  final String category;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> tags;
  final String? imageUrl;
  final String? projectUrl;
  final String? customIconUrl;
  final bool useCustomImage;

  const PortfolioEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
    required this.color,
    required this.tags,
    this.imageUrl,
    this.projectUrl,
    this.customIconUrl,
    this.useCustomImage = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
