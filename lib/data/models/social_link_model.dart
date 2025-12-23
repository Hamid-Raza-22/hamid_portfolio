import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../domain/entities/social_link_entity.dart';

/// Data model for SocialLink with JSON serialization.
class SocialLinkModel extends SocialLinkEntity {
  const SocialLinkModel({
    required super.id,
    required super.name,
    required super.icon,
    required super.url,
    super.customIconUrl,
    super.useCustomImage,
  });

  /// Create from Firestore document
  factory SocialLinkModel.fromJson(Map<String, dynamic> json, String docId) {
    return SocialLinkModel(
      id: docId,
      name: json['name'] as String? ?? '',
      icon: IconMapper.fromString(json['icon'] as String? ?? 'link'),
      url: json['url'] as String? ?? '',
      customIconUrl: json['customIconUrl'] as String?,
      useCustomImage: json['useCustomImage'] as bool? ?? false,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': IconMapper.iconToString(icon),
      'url': url,
      'useCustomImage': useCustomImage,
      if (customIconUrl != null) 'customIconUrl': customIconUrl,
    };
  }

  /// Create from domain entity
  factory SocialLinkModel.fromEntity(SocialLinkEntity entity) {
    return SocialLinkModel(
      id: entity.id,
      name: entity.name,
      icon: entity.icon,
      url: entity.url,
      customIconUrl: entity.customIconUrl,
      useCustomImage: entity.useCustomImage,
    );
  }

  /// Convert to domain entity
  SocialLinkEntity toEntity() {
    return SocialLinkEntity(
      id: id,
      name: name,
      icon: icon,
      url: url,
      customIconUrl: customIconUrl,
      useCustomImage: useCustomImage,
    );
  }

  /// Create a copy with modified fields
  SocialLinkModel copyWith({
    String? id,
    String? name,
    IconData? icon,
    String? url,
    String? customIconUrl,
    bool? useCustomImage,
  }) {
    return SocialLinkModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      url: url ?? this.url,
      customIconUrl: customIconUrl ?? this.customIconUrl,
      useCustomImage: useCustomImage ?? this.useCustomImage,
    );
  }
}
