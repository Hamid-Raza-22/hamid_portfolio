import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'hover_container.dart';

/// Reusable navigation item widget following DRY principle.
class NavItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const NavItem({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverContainer(
      onTap: onTap,
      builder: (isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isHovered
                ? AppColors.primary.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isHovered ? AppColors.primaryLight : AppColors.textSecondary,
              fontSize: 15,
              fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        );
      },
    );
  }
}

/// Footer link variant of nav item.
class FooterNavItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const FooterNavItem({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return HoverContainer(
      onTap: onTap,
      builder: (isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
              color: isHovered ? AppColors.primaryLight : AppColors.textSecondary,
            ),
          ),
        );
      },
    );
  }
}
