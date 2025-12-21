import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../domain/entities/achievement_entity.dart';

/// Data model for Achievement with JSON serialization.
class AchievementModel extends AchievementEntity {
  const AchievementModel({
    required super.id,
    required super.icon,
    required super.text,
  });

  /// Create from Firestore document
  factory AchievementModel.fromJson(Map<String, dynamic> json, String docId) {
    return AchievementModel(
      id: docId,
      icon: IconMapper.fromString(json['icon'] as String? ?? 'star_rounded'),
      text: json['text'] as String? ?? '',
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'icon': IconMapper.iconToString(icon),
      'text': text,
    };
  }

  /// Create from domain entity
  factory AchievementModel.fromEntity(AchievementEntity entity) {
    return AchievementModel(
      id: entity.id,
      icon: entity.icon,
      text: entity.text,
    );
  }

  /// Convert to domain entity
  AchievementEntity toEntity() {
    return AchievementEntity(
      id: id,
      icon: icon,
      text: text,
    );
  }

  /// Create a copy with modified fields
  AchievementModel copyWith({
    String? id,
    IconData? icon,
    String? text,
  }) {
    return AchievementModel(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      text: text ?? this.text,
    );
  }
}
