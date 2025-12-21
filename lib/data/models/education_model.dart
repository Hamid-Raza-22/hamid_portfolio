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
  }) {
    return EducationModel(
      id: id ?? this.id,
      degree: degree ?? this.degree,
      institution: institution ?? this.institution,
      duration: duration ?? this.duration,
      cgpa: cgpa ?? this.cgpa,
      specialization: specialization ?? this.specialization,
      project: project ?? this.project,
    );
  }
}
