import '../../domain/entities/nav_item_entity.dart';

/// Data model for NavItem with JSON serialization.
class NavItemModel extends NavItemEntity {
  const NavItemModel({
    required super.id,
    required super.title,
    super.sectionKey,
  });

  /// Create from Firestore document
  factory NavItemModel.fromJson(Map<String, dynamic> json, String docId) {
    return NavItemModel(
      id: docId,
      title: json['title'] as String? ?? '',
      sectionKey: json['sectionKey'] as String?,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'sectionKey': sectionKey,
    };
  }

  /// Create from domain entity
  factory NavItemModel.fromEntity(NavItemEntity entity) {
    return NavItemModel(
      id: entity.id,
      title: entity.title,
      sectionKey: entity.sectionKey,
    );
  }

  /// Convert to domain entity
  NavItemEntity toEntity() {
    return NavItemEntity(
      id: id,
      title: title,
      sectionKey: sectionKey,
    );
  }

  /// Create a copy with modified fields
  NavItemModel copyWith({
    String? id,
    String? title,
    String? sectionKey,
  }) {
    return NavItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      sectionKey: sectionKey ?? this.sectionKey,
    );
  }
}
