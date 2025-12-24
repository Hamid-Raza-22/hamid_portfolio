import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../core/utils/color_mapper.dart';
import '../../domain/entities/project_detail_entity.dart';

/// Data model for ProjectDetail with JSON serialization.
class ProjectDetailModel extends ProjectDetailEntity {
  const ProjectDetailModel({
    required super.id,
    required super.title,
    required super.category,
    required super.year,
    required super.color,
    required super.icon,
    required super.description,
    required super.highlights,
    required super.tags,
    super.url,
    super.customIconUrl,
    super.useCustomImage,
    super.order,
  });

  /// Create from Firestore document
  factory ProjectDetailModel.fromJson(Map<String, dynamic> json, String docId) {
    return ProjectDetailModel(
      id: docId,
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      year: json['year'] as String? ?? '',
      color: ColorMapper.fromString(json['color'] as String? ?? 'primary'),
      icon: IconMapper.fromString(json['icon'] as String? ?? 'folder'),
      description: json['description'] as String? ?? '',
      highlights: List<String>.from(json['highlights'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      url: json['url'] as String?,
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
      'year': year,
      'color': ColorMapper.colorToString(color),
      'icon': IconMapper.iconToString(icon),
      'description': description,
      'highlights': highlights,
      'tags': tags,
      'url': url,
      'useCustomImage': useCustomImage,
      'order': order,
      if (customIconUrl != null) 'customIconUrl': customIconUrl,
    };
  }

  /// Create from domain entity
  factory ProjectDetailModel.fromEntity(ProjectDetailEntity entity) {
    return ProjectDetailModel(
      id: entity.id,
      title: entity.title,
      category: entity.category,
      year: entity.year,
      color: entity.color,
      icon: entity.icon,
      description: entity.description,
      highlights: entity.highlights,
      tags: entity.tags,
      url: entity.url,
      customIconUrl: entity.customIconUrl,
      useCustomImage: entity.useCustomImage,
      order: entity.order,
    );
  }

  /// Convert to domain entity
  ProjectDetailEntity toEntity() {
    return ProjectDetailEntity(
      id: id,
      title: title,
      category: category,
      year: year,
      color: color,
      icon: icon,
      description: description,
      highlights: highlights,
      tags: tags,
      url: url,
      customIconUrl: customIconUrl,
      useCustomImage: useCustomImage,
      order: order,
    );
  }

  /// Create a copy with modified fields
  @override
  ProjectDetailModel copyWith({
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
    return ProjectDetailModel(
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
}
