import '../../domain/entities/hero_section_entity.dart';

/// Data model for HeroSection with JSON serialization.
class HeroSectionModel extends HeroSectionEntity {
  const HeroSectionModel({
    required super.id,
    required super.greeting,
    required super.name,
    required super.title,
    required super.subtitle,
    required super.description,
    required super.ctaButtonText,
    required super.ctaButtonLink,
    super.profileImageUrl,
    super.backgroundImageUrl,
    super.videoUrl,
    super.isActive,
  });

  /// Create from Firestore document
  factory HeroSectionModel.fromJson(Map<String, dynamic> json, String docId) {
    return HeroSectionModel(
      id: docId,
      greeting: json['greeting'] as String? ?? 'Hello, I\'m',
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      description: json['description'] as String? ?? '',
      ctaButtonText: json['ctaButtonText'] as String? ?? 'Get In Touch',
      ctaButtonLink: json['ctaButtonLink'] as String? ?? '',
      profileImageUrl: json['profileImageUrl'] as String?,
      backgroundImageUrl: json['backgroundImageUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'greeting': greeting,
      'name': name,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'ctaButtonText': ctaButtonText,
      'ctaButtonLink': ctaButtonLink,
      'profileImageUrl': profileImageUrl,
      'backgroundImageUrl': backgroundImageUrl,
      'videoUrl': videoUrl,
      'isActive': isActive,
    };
  }

  /// Create from domain entity
  factory HeroSectionModel.fromEntity(HeroSectionEntity entity) {
    return HeroSectionModel(
      id: entity.id,
      greeting: entity.greeting,
      name: entity.name,
      title: entity.title,
      subtitle: entity.subtitle,
      description: entity.description,
      ctaButtonText: entity.ctaButtonText,
      ctaButtonLink: entity.ctaButtonLink,
      profileImageUrl: entity.profileImageUrl,
      backgroundImageUrl: entity.backgroundImageUrl,
      videoUrl: entity.videoUrl,
      isActive: entity.isActive,
    );
  }

  /// Convert to domain entity
  HeroSectionEntity toEntity() {
    return HeroSectionEntity(
      id: id,
      greeting: greeting,
      name: name,
      title: title,
      subtitle: subtitle,
      description: description,
      ctaButtonText: ctaButtonText,
      ctaButtonLink: ctaButtonLink,
      profileImageUrl: profileImageUrl,
      backgroundImageUrl: backgroundImageUrl,
      videoUrl: videoUrl,
      isActive: isActive,
    );
  }

  /// Create a copy with modified fields
  HeroSectionModel copyWith({
    String? id,
    String? greeting,
    String? name,
    String? title,
    String? subtitle,
    String? description,
    String? ctaButtonText,
    String? ctaButtonLink,
    String? profileImageUrl,
    String? backgroundImageUrl,
    String? videoUrl,
    bool? isActive,
  }) {
    return HeroSectionModel(
      id: id ?? this.id,
      greeting: greeting ?? this.greeting,
      name: name ?? this.name,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      ctaButtonText: ctaButtonText ?? this.ctaButtonText,
      ctaButtonLink: ctaButtonLink ?? this.ctaButtonLink,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      backgroundImageUrl: backgroundImageUrl ?? this.backgroundImageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      isActive: isActive ?? this.isActive,
    );
  }
}
