import 'package:flutter/material.dart';

class AppColors {
  // Primary colors - Modern Gradient
  static const primary = Color(0xFF6366F1);       // Indigo
  static const primaryLight = Color(0xFF818CF8);
  static const primaryDark = Color(0xFF4F46E5);
  
  // Accent colors
  static const accent = Color(0xFF06B6D4);        // Cyan
  static const accentLight = Color(0xFF22D3EE);
  static const accentPink = Color(0xFFEC4899);    // Pink for highlights
  static const accentPurple = Color(0xFF8B5CF6);  // Purple
  
  // Background colors
  static const scaffoldBg = Color(0xFF030712);    // Near black with blue tint
  static const cardBg = Color(0xFF0F172A);        // Slate dark
  static const cardBgLight = Color(0xFF1E293B);   // Slate medium
  static const surfaceBg = Color(0xFF111827);     // Gray-900
  
  // Glass effect colors
  static const glassBg = Color(0x1AFFFFFF);       // White 10%
  static const glassBorder = Color(0x33FFFFFF);   // White 20%
  
  // Text colors
  static const textPrimary = Color(0xFFF8FAFC);   // Slate-50
  static const textSecondary = Color(0xFF94A3B8); // Slate-400
  static const textMuted = Color(0xFF64748B);     // Slate-500
  
  // Gradient presets
  static const List<Color> primaryGradient = [
    Color(0xFF6366F1),
    Color(0xFF8B5CF6),
    Color(0xFFA855F7),
  ];
  
  static const List<Color> accentGradient = [
    Color(0xFF06B6D4),
    Color(0xFF3B82F6),
    Color(0xFF6366F1),
  ];
  
  static const List<Color> warmGradient = [
    Color(0xFFF97316),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
  ];
  
  // Service card colors
  static const serviceBlue = Color(0xFF3B82F6);
  static const serviceGreen = Color(0xFF10B981);
  static const serviceOrange = Color(0xFFF97316);
  static const servicePink = Color(0xFFEC4899);
  static const servicePurple = Color(0xFF8B5CF6);
  static const serviceCyan = Color(0xFF06B6D4);
  static const serviceRed = Color(0xFFEF4444);
  static const serviceYellow = Color(0xFFEAB308);
}