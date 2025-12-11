import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'app_spacing.dart';

/// Centralized decoration constants following DRY principle.
/// Provides consistent box decorations across the application.
abstract class AppDecorations {
  AppDecorations._();

  // Glass card decoration
  static BoxDecoration glassCard({
    double borderRadius = AppSpacing.radiusLg,
    Color? borderColor,
    double opacity = 0.5,
  }) {
    return BoxDecoration(
      color: AppColors.cardBg.withOpacity(opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? AppColors.glassBorder,
      ),
    );
  }

  // Glass card with colored border
  static BoxDecoration glassCardColored({
    required Color color,
    double borderRadius = AppSpacing.radiusLg,
    double opacity = 0.5,
    double borderOpacity = 0.3,
  }) {
    return BoxDecoration(
      color: AppColors.cardBg.withOpacity(opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: color.withOpacity(borderOpacity)),
    );
  }

  // Gradient card decoration
  static BoxDecoration gradientCard({
    required List<Color> colors,
    double borderRadius = AppSpacing.radiusXl,
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: colors,
        begin: begin,
        end: end,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  // Icon container decoration
  static BoxDecoration iconContainer({
    required Color color,
    double borderRadius = AppSpacing.radiusSm,
    double opacity = 0.15,
  }) {
    return BoxDecoration(
      color: color.withOpacity(opacity),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  // Badge decoration
  static BoxDecoration badge({
    required Color color,
    double borderRadius = AppSpacing.radiusFull,
    double opacity = 0.15,
    bool hasBorder = true,
  }) {
    return BoxDecoration(
      color: color.withOpacity(opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      border: hasBorder ? Border.all(color: color.withOpacity(0.3)) : null,
    );
  }

  // Dot indicator decoration
  static BoxDecoration dot({
    required Color color,
    double size = 6.0,
  }) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    );
  }

  // Primary gradient box shadow
  static List<BoxShadow> primaryShadow({double opacity = 0.3}) {
    return [
      BoxShadow(
        color: AppColors.primary.withOpacity(opacity),
        blurRadius: 15,
        offset: const Offset(0, 6),
      ),
    ];
  }

  // Hover shadow
  static List<BoxShadow> hoverShadow({
    Color? color,
    double blurRadius = 25,
    double opacity = 0.5,
  }) {
    return [
      BoxShadow(
        color: (color ?? AppColors.primary).withOpacity(opacity),
        blurRadius: blurRadius,
        offset: const Offset(0, 10),
        spreadRadius: 0,
      ),
    ];
  }

  // Page gradient background
  static BoxDecoration pageBackground() {
    return const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment.topLeft,
        radius: 1.8,
        colors: [
          Color(0xFF0F172A),
          Color(0xFF0C4A6E),
          AppColors.scaffoldBg,
        ],
        stops: [0.0, 0.35, 1.0],
      ),
    );
  }
}

/// Extension for backdrop blur filter
extension BackdropBlurExtension on Widget {
  Widget withBackdropBlur({
    double sigmaX = 10,
    double sigmaY = 10,
    double borderRadius = AppSpacing.radiusLg,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
        child: this,
      ),
    );
  }
}
