import 'package:flutter/material.dart';
import '../../core/utils/icon_mapper.dart';
import '../../core/utils/color_mapper.dart';
import '../../domain/entities/contact_info_entity.dart';

/// Data model for ContactInfo with JSON serialization.
class ContactInfoModel extends ContactInfoEntity {
  const ContactInfoModel({
    required super.id,
    required super.icon,
    required super.title,
    required super.value,
    required super.color,
    required super.actionType,
    super.customIconUrl,
    super.useCustomImage,
  });

  /// Create from Firestore document
  factory ContactInfoModel.fromJson(Map<String, dynamic> json, String docId) {
    return ContactInfoModel(
      id: docId,
      icon: IconMapper.fromString(json['icon'] as String? ?? 'info'),
      title: json['title'] as String? ?? '',
      value: json['value'] as String? ?? '',
      color: ColorMapper.fromString(json['color'] as String? ?? 'primary'),
      actionType: json['actionType'] as String? ?? '',
      customIconUrl: json['customIconUrl'] as String?,
      useCustomImage: json['useCustomImage'] as bool? ?? false,
    );
  }

  /// Convert to Firestore document
  Map<String, dynamic> toJson() {
    return {
      'icon': IconMapper.iconToString(icon),
      'title': title,
      'value': value,
      'color': ColorMapper.colorToString(color),
      'actionType': actionType,
      'useCustomImage': useCustomImage,
      if (customIconUrl != null) 'customIconUrl': customIconUrl,
    };
  }

  /// Create from domain entity
  factory ContactInfoModel.fromEntity(ContactInfoEntity entity) {
    return ContactInfoModel(
      id: entity.id,
      icon: entity.icon,
      title: entity.title,
      value: entity.value,
      color: entity.color,
      actionType: entity.actionType,
      customIconUrl: entity.customIconUrl,
      useCustomImage: entity.useCustomImage,
    );
  }

  /// Convert to domain entity
  ContactInfoEntity toEntity() {
    return ContactInfoEntity(
      id: id,
      icon: icon,
      title: title,
      value: value,
      color: color,
      actionType: actionType,
      customIconUrl: customIconUrl,
      useCustomImage: useCustomImage,
    );
  }

  /// Create a copy with modified fields
  ContactInfoModel copyWith({
    String? id,
    IconData? icon,
    String? title,
    String? value,
    Color? color,
    String? actionType,
    String? customIconUrl,
    bool? useCustomImage,
  }) {
    return ContactInfoModel(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      value: value ?? this.value,
      color: color ?? this.color,
      actionType: actionType ?? this.actionType,
      customIconUrl: customIconUrl ?? this.customIconUrl,
      useCustomImage: useCustomImage ?? this.useCustomImage,
    );
  }
}
