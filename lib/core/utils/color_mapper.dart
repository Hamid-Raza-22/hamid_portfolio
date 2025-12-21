import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Utility class for mapping color names to Color values and vice versa.
/// This is necessary because Color cannot be directly stored in Firebase.
class ColorMapper {
  ColorMapper._();

  static const Map<String, Color> _colorMap = {
    // App theme colors
    'primary': AppColors.primary,
    'primaryLight': AppColors.primaryLight,
    'accent': AppColors.accent,
    'accentPurple': AppColors.accentPurple,
    'scaffoldBg': AppColors.scaffoldBg,
    'cardBg': AppColors.cardBg,
    'textPrimary': AppColors.textPrimary,
    'textSecondary': AppColors.textSecondary,
    
    // Service colors
    'servicePurple': AppColors.servicePurple,
    'serviceBlue': AppColors.serviceBlue,
    'servicePink': AppColors.servicePink,
    'serviceGreen': AppColors.serviceGreen,
    'serviceCyan': AppColors.serviceCyan,
    'serviceOrange': AppColors.serviceOrange,
    'serviceRed': AppColors.serviceRed,
    'serviceYellow': AppColors.serviceYellow,
    
    // Basic colors
    'white': Colors.white,
    'black': Colors.black,
    'grey': Colors.grey,
    'red': Colors.red,
    'pink': Colors.pink,
    'purple': Colors.purple,
    'deepPurple': Colors.deepPurple,
    'indigo': Colors.indigo,
    'blue': Colors.blue,
    'lightBlue': Colors.lightBlue,
    'cyan': Colors.cyan,
    'teal': Colors.teal,
    'green': Colors.green,
    'lightGreen': Colors.lightGreen,
    'lime': Colors.lime,
    'yellow': Colors.yellow,
    'amber': Colors.amber,
    'orange': Colors.orange,
    'deepOrange': Colors.deepOrange,
    'brown': Colors.brown,
    'blueGrey': Colors.blueGrey,
    
    // WhatsApp green
    'whatsappGreen': const Color(0xFF25D366),
  };

  /// Get Color from color name string
  static Color fromString(String colorName) {
    return _colorMap[colorName] ?? AppColors.primary;
  }

  /// Get color name string from Color
  static String colorToString(Color color) {
    for (final entry in _colorMap.entries) {
      if (entry.value.value == color.value) {
        return entry.key;
      }
    }
    return 'primary';
  }

  /// Get all available color names
  static List<String> get availableColors => _colorMap.keys.toList();

  /// Get all available colors as map entries for selection UI
  static List<MapEntry<String, Color>> get colorEntries =>
      _colorMap.entries.toList();

  /// Convert Color to hex string for storage
  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  /// Convert hex string to Color
  static Color fromHex(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 6 || hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
