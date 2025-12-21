import '../../domain/entities/certification_entity.dart';

/// Data model for Certification with JSON serialization.
class CertificationModel extends CertificationEntity {
  const CertificationModel({
    required super.id,
    required super.title,
    required super.issuer,
    required super.year,
  });

  /// Create from Firestore document
  factory CertificationModel.fromJson(Map<String, dynamic> json, String docId) {
    return CertificationModel(
      id: docId,
      title: json['title'] as String? ?? '',
      issuer: json['issuer'] as String? ?? '',
      year: json['year'] as String? ?? '',
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'issuer': issuer,
      'year': year,
    };
  }

  /// Create from domain entity
  factory CertificationModel.fromEntity(CertificationEntity entity) {
    return CertificationModel(
      id: entity.id,
      title: entity.title,
      issuer: entity.issuer,
      year: entity.year,
    );
  }

  /// Convert to domain entity
  CertificationEntity toEntity() {
    return CertificationEntity(
      id: id,
      title: title,
      issuer: issuer,
      year: year,
    );
  }

  /// Create a copy with modified fields
  CertificationModel copyWith({
    String? id,
    String? title,
    String? issuer,
    String? year,
  }) {
    return CertificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      issuer: issuer ?? this.issuer,
      year: year ?? this.year,
    );
  }
}
