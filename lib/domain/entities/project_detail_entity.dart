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
  final String? customIconUrl;
  final bool useCustomImage;
  final int order;

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
    this.customIconUrl,
    this.useCustomImage = false,
    this.order = 0,
  });

  ProjectDetailEntity copyWith({
    String? id,
    String? title,
    String? category,
    String? year,
    Color? color,
    IconData? icon,
    String? description,
    List<String>? highlights,
    List<String>? tags,
    String? url,
    String? customIconUrl,
    bool? useCustomImage,
    int? order,
  }) {
    return ProjectDetailEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      year: year ?? this.year,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      highlights: highlights ?? this.highlights,
      tags: tags ?? this.tags,
      url: url ?? this.url,
      customIconUrl: customIconUrl ?? this.customIconUrl,
      useCustomImage: useCustomImage ?? this.useCustomImage,
      order: order ?? this.order,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectDetailEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
