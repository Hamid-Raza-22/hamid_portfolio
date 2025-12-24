import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../core/utils/color_mapper.dart';
import '../../domain/entities/experience_entity.dart';

/// Data model for Experience with JSON serialization.
class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.id,
    required super.title,
    required super.company,
    required super.location,
    required super.duration,
    required super.highlights,
    super.icon,
    super.color,
    super.customIconUrl,
    super.useCustomImage,
    super.order,
  });

  /// Create from Firestore document
  factory ExperienceModel.fromJson(Map<String, dynamic> json, String docId) {
    return ExperienceModel(
      id: docId,
      title: json['title'] as String? ?? '',
      company: json['company'] as String? ?? '',
      location: json['location'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      highlights: List<String>.from(json['highlights'] ?? []),
      icon: json['icon'] != null ? IconMapper.fromString(json['icon'] as String) : Icons.work_rounded,
      color: json['color'] != null ? ColorMapper.fromString(json['color'] as String) : Colors.blue,
      customIconUrl: json['customIconUrl'] as String?,
      useCustomImage: json['useCustomImage'] as bool? ?? false,
      order: json['order'] as int? ?? 0,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'location': location,
      'duration': duration,
      'highlights': highlights,
      'icon': icon != null ? IconMapper.iconToString(icon!) : 'work_rounded',
      'color': color != null ? ColorMapper.colorToString(color!) : 'blue',
      'customIconUrl': customIconUrl,
      'useCustomImage': useCustomImage,
      'order': order,
    };
  }

  /// Create from domain entity
  factory ExperienceModel.fromEntity(ExperienceEntity entity) {
    return ExperienceModel(
      id: entity.id,
      title: entity.title,
      company: entity.company,
      location: entity.location,
      duration: entity.duration,
      highlights: entity.highlights,
      icon: entity.icon,
      color: entity.color,
      customIconUrl: entity.customIconUrl,
      useCustomImage: entity.useCustomImage,
      order: entity.order,
    );
  }

  /// Convert to domain entity
  ExperienceEntity toEntity() {
    return ExperienceEntity(
      id: id,
      title: title,
      company: company,
      location: location,
      duration: duration,
      highlights: highlights,
      icon: icon,
      color: color,
      customIconUrl: customIconUrl,
      useCustomImage: useCustomImage,
      order: order,
    );
  }

  /// Create a copy with modified fields
  ExperienceModel copyWith({
    String? id,
    String? title,
    String? company,
    String? location,
    String? duration,
    List<String>? highlights,
    IconData? icon,
    Color? color,
    String? customIconUrl,
    bool? useCustomImage,
    int? order,
  }) {
    return ExperienceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      duration: duration ?? this.duration,
      highlights: highlights ?? this.highlights,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      customIconUrl: customIconUrl ?? this.customIconUrl,
      useCustomImage: useCustomImage ?? this.useCustomImage,
      order: order ?? this.order,
    );
  }
}
