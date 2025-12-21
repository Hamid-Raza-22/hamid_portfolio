import '../../domain/entities/stat_entity.dart';

/// Data model for Stat with JSON serialization.
class StatModel extends StatEntity {
  const StatModel({
    required super.id,
    required super.value,
    required super.label,
  });

  /// Create from Firestore document
  factory StatModel.fromJson(Map<String, dynamic> json, String docId) {
    return StatModel(
      id: docId,
      value: json['value'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
    };
  }

  /// Create from domain entity
  factory StatModel.fromEntity(StatEntity entity) {
    return StatModel(
      id: entity.id,
      value: entity.value,
      label: entity.label,
    );
  }

  /// Convert to domain entity
  StatEntity toEntity() {
    return StatEntity(
      id: id,
      value: value,
      label: label,
    );
  }

  /// Create a copy with modified fields
  StatModel copyWith({
    String? id,
    String? value,
    String? label,
  }) {
    return StatModel(
      id: id ?? this.id,
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }
}
