import '../../domain/entities/profile_entity.dart';

/// Data model for Profile with JSON serialization.
class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.name,
    required super.title,
    required super.experience,
    required super.summary,
    required super.workPreferences,
    required super.location,
    required super.languages,
  });

  /// Create from Firestore document
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      experience: json['experience'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      workPreferences: json['workPreferences'] as String? ?? '',
      location: json['location'] as String? ?? '',
      languages: json['languages'] as String? ?? '',
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'experience': experience,
      'summary': summary,
      'workPreferences': workPreferences,
      'location': location,
      'languages': languages,
    };
  }

  /// Create from domain entity
  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      name: entity.name,
      title: entity.title,
      experience: entity.experience,
      summary: entity.summary,
      workPreferences: entity.workPreferences,
      location: entity.location,
      languages: entity.languages,
    );
  }

  /// Convert to domain entity
  ProfileEntity toEntity() {
    return ProfileEntity(
      name: name,
      title: title,
      experience: experience,
      summary: summary,
      workPreferences: workPreferences,
      location: location,
      languages: languages,
    );
  }

  /// Create a copy with modified fields
  ProfileModel copyWith({
    String? name,
    String? title,
    String? experience,
    String? summary,
    String? workPreferences,
    String? location,
    String? languages,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      title: title ?? this.title,
      experience: experience ?? this.experience,
      summary: summary ?? this.summary,
      workPreferences: workPreferences ?? this.workPreferences,
      location: location ?? this.location,
      languages: languages ?? this.languages,
    );
  }
}
