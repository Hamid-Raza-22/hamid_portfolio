import 'package:flutter/material.dart';
import '../../../core/theme/app_spacing.dart';

/// Reusable icon container widget following DRY principle.
class IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final double iconSize;
  final double borderRadius;

  const IconBox({
    super.key,
    required this.icon,
    required this.color,
    this.size = 48,
    this.iconSize = 24,
    this.borderRadius = AppSpacing.radiusSm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(icon, color: color, size: iconSize),
    );
  }
}

/// Small icon box variant
class IconBoxSmall extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconBoxSmall({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconBox(
      icon: icon,
      color: color,
      size: 40,
      iconSize: 20,
      borderRadius: AppSpacing.radiusXs,
    );
  }
}

/// Large icon box variant
class IconBoxLarge extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconBoxLarge({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IconBox(
      icon: icon,
      color: color,
      size: 64,
      iconSize: 32,
      borderRadius: AppSpacing.radiusMd,
    );
  }
}
