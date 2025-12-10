import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'hover_container.dart';

/// Reusable animated button widget following DRY principle.
/// Used across Hero section, Contact section, and Header.
class AnimatedButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isPrimary;
  final VoidCallback? onTap;
  final bool iconLeading;

  const AnimatedButton({
    super.key,
    required this.text,
    this.icon,
    this.isPrimary = true,
    this.onTap,
    this.iconLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    return HoverContainer(
      onTap: onTap,
      builder: (isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? LinearGradient(
                    colors: isHovered
                        ? [AppColors.primaryLight, AppColors.accent]
                        : AppColors.primaryGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: isPrimary
                ? null
                : Border.all(
                    color: isHovered
                        ? AppColors.primaryLight
                        : AppColors.glassBorder,
                    width: 1.5,
                  ),
            boxShadow: isPrimary && isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                      spreadRadius: 0,
                    ),
                  ]
                : isPrimary
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconLeading && icon != null) ...[
                Icon(
                  icon,
                  color: isPrimary
                      ? Colors.white
                      : (isHovered ? AppColors.primaryLight : AppColors.textSecondary),
                  size: 18,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                text,
                style: TextStyle(
                  color: isPrimary
                      ? Colors.white
                      : (isHovered ? AppColors.primaryLight : AppColors.textSecondary),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              if (!iconLeading && icon != null) ...[
                const SizedBox(width: 10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(isHovered ? 4 : 0, 0, 0),
                  child: Icon(
                    icon,
                    color: isPrimary
                        ? Colors.white
                        : (isHovered ? AppColors.primaryLight : AppColors.textSecondary),
                    size: 18,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
