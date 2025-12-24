import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../core/utils/color_mapper.dart';
import '../../domain/entities/education_entity.dart';

/// Data model for Education with JSON serialization.
class EducationModel extends EducationEntity {
  const EducationModel({
    required super.id,
    required super.degree,
    required super.institution,
    required super.duration,
    super.cgpa,
    super.specialization,
    super.project,
    super.icon,
    super.color,
    super.customIconUrl,
    super.useCustomImage,
    super.order,
  });

  /// Create from Firestore document
  factory EducationModel.fromJson(Map<String, dynamic> json, String docId) {
    return EducationModel(
      id: docId,
      degree: json['degree'] as String? ?? '',
      institution: json['institution'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      cgpa: json['cgpa'] as String?,
      specialization: json['specialization'] as String?,
      project: json['project'] as String?,
      icon: json['icon'] != null ? IconMapper.fromString(json['icon'] as String) : Icons.school_rounded,
      color: json['color'] != null ? ColorMapper.fromString(json['color'] as String) : Colors.blue,
      customIconUrl: json['customIconUrl'] as String?,
      useCustomImage: json['useCustomImage'] as bool? ?? false,
      order: json['order'] as int? ?? 0,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'degree': degree,
      'institution': institution,
      'duration': duration,
      'cgpa': cgpa,
      'specialization': specialization,
      'project': project,
      'icon': icon != null ? IconMapper.iconToString(icon!) : 'school_rounded',
      'color': color != null ? ColorMapper.colorToString(color!) : 'blue',
      'customIconUrl': customIconUrl,
      'useCustomImage': useCustomImage,
      'order': order,
    };
  }

  /// Create from domain entity
  factory EducationModel.fromEntity(EducationEntity entity) {
    return EducationModel(
      id: entity.id,
      degree: entity.degree,
      institution: entity.institution,
      duration: entity.duration,
      cgpa: entity.cgpa,
      specialization: entity.specialization,
      project: entity.project,
      icon: entity.icon,
      color: entity.color,
      customIconUrl: entity.customIconUrl,
      useCustomImage: entity.useCustomImage,
      order: entity.order,
    );
  }

  /// Convert to domain entity
  EducationEntity toEntity() {
    return EducationEntity(
      id: id,
      degree: degree,
      institution: institution,
      duration: duration,
      cgpa: cgpa,
      specialization: specialization,
      project: project,
      icon: icon,
      color: color,
      customIconUrl: customIconUrl,
      useCustomImage: useCustomImage,
      order: order,
    );
  }

  /// Create a copy with modified fields
  EducationModel copyWith({
    String? id,
    String? degree,
    String? institution,
    String? duration,
    String? cgpa,
    String? specialization,
    String? project,
    IconData? icon,
    Color? color,
    String? customIconUrl,
    bool? useCustomImage,
    int? order,
  }) {
    return EducationModel(
      id: id ?? this.id,
      degree: degree ?? this.degree,
      institution: institution ?? this.institution,
      duration: duration ?? this.duration,
      cgpa: cgpa ?? this.cgpa,
      specialization: specialization ?? this.specialization,
      project: project ?? this.project,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      customIconUrl: customIconUrl ?? this.customIconUrl,
      useCustomImage: useCustomImage ?? this.useCustomImage,
      order: order ?? this.order,
    );
  }
}
