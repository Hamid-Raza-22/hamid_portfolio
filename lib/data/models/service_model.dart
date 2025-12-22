import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../core/utils/color_mapper.dart';
import '../../domain/entities/service_entity.dart';

/// Data model for Service with JSON serialization.
class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required super.id,
    required super.icon,
    required super.title,
    required super.description,
    required super.color,
    super.customIconUrl,
    super.useCustomImage,
  });

  /// Create from Firestore document
  factory ServiceModel.fromJson(Map<String, dynamic> json, String docId) {
    return ServiceModel(
      id: docId,
      icon: IconMapper.fromString(json['icon'] as String? ?? 'help_outline'),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      color: ColorMapper.fromString(json['color'] as String? ?? 'primary'),
      customIconUrl: json['customIconUrl'] as String?,
      useCustomImage: json['useCustomImage'] as bool? ?? false,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'icon': IconMapper.iconToString(icon),
      'title': title,
      'description': description,
      'color': ColorMapper.colorToString(color),
      'useCustomImage': useCustomImage,
      if (customIconUrl != null) 'customIconUrl': customIconUrl,
    };
  }

  /// Create from domain entity
  factory ServiceModel.fromEntity(ServiceEntity entity) {
    return ServiceModel(
      id: entity.id,
      icon: entity.icon,
      title: entity.title,
      description: entity.description,
      color: entity.color,
      customIconUrl: entity.customIconUrl,
      useCustomImage: entity.useCustomImage,
    );
  }

  /// Convert to domain entity
  ServiceEntity toEntity() {
    return ServiceEntity(
      id: id,
      icon: icon,
      title: title,
      description: description,
      color: color,
      customIconUrl: customIconUrl,
      useCustomImage: useCustomImage,
    );
  }

  /// Create a copy with modified fields
  ServiceModel copyWith({
    String? id,
    IconData? icon,
    String? title,
    String? description,
    Color? color,
    String? customIconUrl,
    bool? useCustomImage,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      color: color ?? this.color,
      customIconUrl: customIconUrl ?? this.customIconUrl,
      useCustomImage: useCustomImage ?? this.useCustomImage,
    );
  }
}
