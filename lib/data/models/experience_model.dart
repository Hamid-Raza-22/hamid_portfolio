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
  }) {
    return ExperienceModel(
      id: id ?? this.id,
      title: title ?? this.title,
      company: company ?? this.company,
      location: location ?? this.location,
      duration: duration ?? this.duration,
      highlights: highlights ?? this.highlights,
    );
  }
}
