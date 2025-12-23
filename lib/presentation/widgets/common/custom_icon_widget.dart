import 'package:flutter/material.dart';

/// A reusable widget for displaying icons with optional custom image support.
/// Provides consistent rendering of icons and custom uploaded images across the app.
class CustomIconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final String? customIconUrl;
  final bool useCustomImage;
  final double? containerSize;
  final double borderRadius;
  final Color? backgroundColor;

  const CustomIconWidget({
    super.key,
    required this.icon,
    required this.color,
    this.size = 24,
    this.customIconUrl,
    this.useCustomImage = false,
    this.containerSize,
    this.borderRadius = 12,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowCustomImage = useCustomImage && 
        customIconUrl != null && 
        customIconUrl!.isNotEmpty;

    final effectiveContainerSize = containerSize ?? (size + 20);
    final imageSize = size + 4;

    if (shouldShowCustomImage) {
      return Container(
        width: effectiveContainerSize,
        height: effectiveContainerSize,
        padding: EdgeInsets.all((effectiveContainerSize - imageSize) / 2),
        decoration: BoxDecoration(
          color: backgroundColor ?? color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius - 2),
          child: Image.network(
            customIconUrl!,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              icon,
              color: color,
              size: size,
            ),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all((effectiveContainerSize - size) / 2),
      decoration: BoxDecoration(
        color: backgroundColor ?? color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(icon, color: color, size: size),
    );
  }
}

/// A simpler inline custom icon that doesn't include a container.
/// Use this when you need just the icon/image without background styling.
class CustomIconInline extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final String? customIconUrl;
  final bool useCustomImage;
  final double borderRadius;

  const CustomIconInline({
    super.key,
    required this.icon,
    required this.color,
    this.size = 24,
    this.customIconUrl,
    this.useCustomImage = false,
    this.borderRadius = 6,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowCustomImage = useCustomImage && 
        customIconUrl != null && 
        customIconUrl!.isNotEmpty;

    if (shouldShowCustomImage) {
      return SizedBox(
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(
            customIconUrl!,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              icon,
              color: color,
              size: size,
            ),
          ),
        ),
      );
    }

    return Icon(icon, color: color, size: size);
  }
}
