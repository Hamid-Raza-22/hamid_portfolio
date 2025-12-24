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
  final int order;

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
    this.order = 0,
  });

  PortfolioEntity copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    IconData? icon,
    Color? color,
    List<String>? tags,
    String? imageUrl,
    String? projectUrl,
    String? customIconUrl,
    bool? useCustomImage,
    int? order,
  }) {
    return PortfolioEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      projectUrl: projectUrl ?? this.projectUrl,
      customIconUrl: customIconUrl ?? this.customIconUrl,
      useCustomImage: useCustomImage ?? this.useCustomImage,
      order: order ?? this.order,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortfolioEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
