import 'package:flutter/material.dart';

/// Domain entity representing a social media link.
class SocialLinkEntity {
  final String id;
  final String name;
  final IconData icon;
  final String url;

  const SocialLinkEntity({
    required this.id,
    required this.name,
    required this.icon,
    required this.url,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialLinkEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
