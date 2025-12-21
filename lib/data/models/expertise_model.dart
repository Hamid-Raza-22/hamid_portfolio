import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../core/utils/color_mapper.dart';
import '../../domain/entities/expertise_entity.dart';

/// Data model for Expertise with JSON serialization.
class ExpertiseModel extends ExpertiseEntity {
  const ExpertiseModel({
    required super.id,
    required super.title,
    required super.icon,
    required super.color,
    required super.skills,
  });

  /// Create from Firestore document
  factory ExpertiseModel.fromJson(Map<String, dynamic> json, String docId) {
    return ExpertiseModel(
      id: docId,
      title: json['title'] as String? ?? '',
      icon: IconMapper.fromString(json['icon'] as String? ?? 'code_rounded'),
      color: ColorMapper.fromString(json['color'] as String? ?? 'primary'),
      skills: List<String>.from(json['skills'] ?? []),
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': IconMapper.iconToString(icon),
      'color': ColorMapper.colorToString(color),
      'skills': skills,
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
    );
  }

  /// Create a copy with modified fields
  ExpertiseModel copyWith({
    String? id,
    String? title,
    IconData? icon,
    Color? color,
    List<String>? skills,
  }) {
    return ExpertiseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      skills: skills ?? this.skills,
    );
  }
}
