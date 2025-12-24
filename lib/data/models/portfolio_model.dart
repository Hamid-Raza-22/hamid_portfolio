import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../core/utils/color_mapper.dart';
import '../../domain/entities/portfolio_entity.dart';

/// Data model for Portfolio with JSON serialization.
class PortfolioModel extends PortfolioEntity {
  const PortfolioModel({
    required super.id,
    required super.title,
    required super.category,
    required super.description,
    required super.icon,
    required super.color,
    required super.tags,
    super.imageUrl,
    super.projectUrl,
    super.customIconUrl,
    super.useCustomImage,
    super.order,
  });

  /// Create from Firestore document
  factory PortfolioModel.fromJson(Map<String, dynamic> json, String docId) {
    return PortfolioModel(
      id: docId,
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      description: json['description'] as String? ?? '',
      icon: IconMapper.fromString(json['icon'] as String? ?? 'help_outline'),
      color: ColorMapper.fromString(json['color'] as String? ?? 'primary'),
      tags: List<String>.from(json['tags'] ?? []),
      imageUrl: json['imageUrl'] as String?,
      projectUrl: json['projectUrl'] as String?,
      customIconUrl: json['customIconUrl'] as String?,
      useCustomImage: json['useCustomImage'] as bool? ?? false,
      order: json['order'] as int? ?? 0,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'description': description,
      'icon': IconMapper.iconToString(icon),
      'color': ColorMapper.colorToString(color),
      'tags': tags,
      'imageUrl': imageUrl,
      'projectUrl': projectUrl,
      'useCustomImage': useCustomImage,
      'order': order,
      if (customIconUrl != null) 'customIconUrl': customIconUrl,
    };
  }

  /// Create from domain entity
  factory PortfolioModel.fromEntity(PortfolioEntity entity) {
    return PortfolioModel(
      id: entity.id,
      title: entity.title,
      category: entity.category,
      description: entity.description,
      icon: entity.icon,
      color: entity.color,
      tags: entity.tags,
      imageUrl: entity.imageUrl,
      projectUrl: entity.projectUrl,
      customIconUrl: entity.customIconUrl,
      useCustomImage: entity.useCustomImage,
      order: entity.order,
    );
  }

  /// Convert to domain entity
  PortfolioEntity toEntity() {
    return PortfolioEntity(
      id: id,
      title: title,
      category: category,
      description: description,
      icon: icon,
      color: color,
      tags: tags,
      imageUrl: imageUrl,
      projectUrl: projectUrl,
      customIconUrl: customIconUrl,
      useCustomImage: useCustomImage,
      order: order,
    );
  }

  /// Create a copy with modified fields
  @override
  PortfolioModel copyWith({
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
    return PortfolioModel(
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
}
