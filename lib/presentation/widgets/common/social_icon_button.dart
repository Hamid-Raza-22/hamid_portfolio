import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'hover_container.dart';

/// Reusable social icon button widget following DRY principle.
/// Used in Footer and Contact sections.
class SocialIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final double size;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.size = 38,
  });

  @override
  Widget build(BuildContext context) {
    return HoverContainer(
      onTap: onTap,
      builder: (isHovered) {
        return Tooltip(
          message: label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.primary.withOpacity(0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isHovered
                    ? AppColors.primary.withOpacity(0.4)
                    : AppColors.glassBorder,
              ),
            ),
            child: Icon(
              icon,
              color: isHovered ? AppColors.primaryLight : AppColors.textMuted,
              size: size * 0.47,
            ),
          ),
        );
      },
    );
  }
}

/// Larger social icon variant for Contact section.
/// Supports custom images for consistency with Contact Page.
class SocialIconLarge extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String? customIconUrl;
  final bool useCustomImage;

  const SocialIconLarge({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.customIconUrl,
    this.useCustomImage = false,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowCustomImage = useCustomImage && customIconUrl != null && customIconUrl!.isNotEmpty;
    
    return HoverContainer(
      onTap: onTap,
      builder: (isHovered) {
        return Tooltip(
          message: label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.primary.withOpacity(0.2)
                  : AppColors.glassBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isHovered
                    ? AppColors.primary.withOpacity(0.5)
                    : AppColors.glassBorder,
              ),
            ),
            child: shouldShowCustomImage
                ? Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        customIconUrl!,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Icon(
                          icon,
                          color: isHovered ? AppColors.primaryLight : AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  )
                : Icon(
                    icon,
                    color: isHovered ? AppColors.primaryLight : AppColors.textSecondary,
                    size: 20,
                  ),
          ),
        );
      },
    );
  }
}
