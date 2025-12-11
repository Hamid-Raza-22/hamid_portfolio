import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

/// Reusable glass morphism card widget following DRY principle.
class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color? borderColor;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double blurSigma;
  final double? width;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = AppSpacing.radiusLg,
    this.borderColor,
    this.opacity = 0.5,
    this.padding,
    this.margin,
    this.blurSigma = 10,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ?? AppColors.glassBorder,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Glass card with colored border
class GlassCardColored extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;

  const GlassCardColored({
    super.key,
    required this.child,
    required this.color,
    this.borderRadius = AppSpacing.radiusLg,
    this.padding,
    this.margin,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      borderRadius: borderRadius,
      borderColor: color.withOpacity(0.3),
      padding: padding,
      margin: margin,
      width: width,
      child: child,
    );
  }
}
