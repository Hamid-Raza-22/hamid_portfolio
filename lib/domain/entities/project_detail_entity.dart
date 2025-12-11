import 'package:flutter/material.dart';

/// Domain entity representing a detailed project entry for Projects page.
class ProjectDetailEntity {
  final String id;
  final String title;
  final String category;
  final String year;
  final Color color;
  final IconData icon;
  final String description;
  final List<String> highlights;
  final List<String> tags;
  final String? url;

  const ProjectDetailEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.year,
    required this.color,
    required this.icon,
    required this.description,
    required this.highlights,
    required this.tags,
    this.url,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectDetailEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
