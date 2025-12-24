import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../core/utils/color_mapper.dart';
import '../../domain/entities/expertise_entity.dart';
import '../../domain/entities/skill_entity.dart';

/// Data model for Expertise with JSON serialization.
class ExpertiseModel extends ExpertiseEntity {
  const ExpertiseModel({
    required super.id,
    required super.title,
    required super.icon,
    required super.color,
    required super.skills,
    super.skillEntities,
    super.customIconUrl,
    super.useCustomImage,
  });

  /// Create from Firestore document
  factory ExpertiseModel.fromJson(Map<String, dynamic> json, String docId) {
    // Parse skillEntities if available, otherwise create from skills list
    final List<SkillEntity> parsedSkillEntities = [];
    if (json['skillEntities'] != null) {
      for (final skillJson in (json['skillEntities'] as List)) {
        parsedSkillEntities.add(SkillEntity(
          name: skillJson['name'] as String? ?? '',
          icon: skillJson['icon'] != null 
              ? IconMapper.fromString(skillJson['icon'] as String) 
              : null,
          customIconUrl: skillJson['customIconUrl'] as String?,
          useCustomImage: skillJson['useCustomImage'] as bool? ?? false,
        ));
      }
    }
    
    return ExpertiseModel(
      id: docId,
      title: json['title'] as String? ?? '',
      icon: IconMapper.fromString(json['icon'] as String? ?? 'code_rounded'),
      color: ColorMapper.fromString(json['color'] as String? ?? 'primary'),
      skills: List<String>.from(json['skills'] ?? []),
      skillEntities: parsedSkillEntities,
      customIconUrl: json['customIconUrl'] as String?,
      useCustomImage: json['useCustomImage'] as bool? ?? false,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': IconMapper.iconToString(icon),
      'color': ColorMapper.colorToString(color),
      'skills': skills,
      'skillEntities': skillEntities.map((skill) {
        return {
          'name': skill.name,
          if (skill.icon != null) 'icon': IconMapper.iconToString(skill.icon!),
          if (skill.customIconUrl != null) 'customIconUrl': skill.customIconUrl,
          'useCustomImage': skill.useCustomImage,
        };
      }).toList(),
      'useCustomImage': useCustomImage,
      if (customIconUrl != null) 'customIconUrl': customIconUrl,
    };
  }

  /// Create from domain entity
  factory ExpertiseModel.fromEntity(ExpertiseEntity entity) {
    return ExpertiseModel(
      id: entity.id,
      title: entity.title,
      icon: entity.icon,
      color: entity.color,
      skills: entity.skills,
      skillEntities: entity.skillEntities,
      customIconUrl: entity.customIconUrl,
      useCustomImage: entity.useCustomImage,
    );
  }

  /// Convert to domain entity
  ExpertiseEntity toEntity() {
    return ExpertiseEntity(
      id: id,
      title: title,
      icon: icon,
      color: color,
      skills: skills,
      skillEntities: skillEntities,
      customIconUrl: customIconUrl,
      useCustomImage: useCustomImage,
    );
  }

  /// Create a copy with modified fields
  ExpertiseModel copyWith({
    String? id,
    String? title,
    IconData? icon,
    Color? color,
    List<String>? skills,
    List<SkillEntity>? skillEntities,
    String? customIconUrl,
    bool? useCustomImage,
  }) {
    return ExpertiseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      skills: skills ?? this.skills,
      skillEntities: skillEntities ?? this.skillEntities,
      customIconUrl: customIconUrl ?? this.customIconUrl,
      useCustomImage: useCustomImage ?? this.useCustomImage,
    );
  }
}
