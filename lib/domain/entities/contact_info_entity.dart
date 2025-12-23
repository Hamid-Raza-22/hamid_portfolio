import 'package:flutter/material.dart';

/// Domain entity representing a contact information item.
class ContactInfoEntity {
  final String id;
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final String actionType;
  final String? customIconUrl;
  final bool useCustomImage;

  const ContactInfoEntity({
    required this.id,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.actionType,
    this.customIconUrl,
    this.useCustomImage = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactInfoEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
