import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/responsive_constants.dart';
import 'gradient_text.dart';
import 'section_badge.dart';

/// Reusable page header widget following DRY principle.
class PageHeader extends StatelessWidget {
  final String badgeText;
  final Color badgeColor;
  final String title;
  final List<Color> titleColors;
  final String? subtitle;

  const PageHeader({
    super.key,
    required this.badgeText,
    required this.badgeColor,
    required this.title,
    this.titleColors = const [Colors.white, AppColors.primaryLight],
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionBadge(
          text: badgeText,
          color: badgeColor,
          leadingWidget: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: badgeColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(height: 24),
        GradientText(
          text: title,
          colors: titleColors,
          style: TextStyle(
            fontSize: ResponsiveValue.get<double>(context, mobile: 32, desktop: 48),
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -1,
          ),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 500),
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveValue.get<double>(context, mobile: 15, desktop: 16),
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
