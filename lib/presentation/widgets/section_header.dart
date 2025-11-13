import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive_utils.dart';

/// Reusable section header with gradient text and optional icon
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final bool showDivider;
  final TextAlign textAlign;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.showDivider = true,
    this.textAlign = TextAlign.center,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : textAlign == TextAlign.right
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: textAlign == TextAlign.center
              ? MainAxisAlignment.center
              : textAlign == TextAlign.right
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.neonBlue],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.glowBlue.withOpacity(0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.black,
                  size: ResponsiveUtils.getIconSize(context, baseSize: 24),
                ),
              ),
              SizedBox(width: ResponsiveUtils.getSpacing(context, multiplier: 0.5)),
            ],
            Flexible(
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    AppColors.textPrimary,
                    AppColors.primary,
                    AppColors.neonBlue,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ).createShader(bounds),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.responsiveFontSize(
                      context,
                      mobile: 28,
                      tablet: 36,
                      desktop: 42,
                      ultraWide: 48,
                    ),
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                  textAlign: textAlign,
                ),
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: ResponsiveUtils.getSpacing(context)),
              trailing!,
            ],
          ],
        ),
        if (subtitle != null) ...[
          SizedBox(height: ResponsiveUtils.getSpacing(context, multiplier: 0.5)),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: ResponsiveUtils.responsiveFontSize(
                context,
                mobile: 14,
                desktop: 16,
              ),
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: textAlign,
          ),
        ],
        if (showDivider) ...[
          SizedBox(height: ResponsiveUtils.getSpacing(context)),
          _buildDivider(context),
        ],
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    if (textAlign == TextAlign.center) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDividerLine(),
          _buildDividerDot(),
          _buildDividerLine(),
        ],
      );
    }

    return Row(
      children: [
        _buildDividerLine(flex: 1),
        _buildDividerDot(),
      ],
    );
  }

  Widget _buildDividerLine({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              AppColors.primary.withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDividerDot() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.glowBlue.withOpacity(0.6),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

/// Mini section header for subsections
class MiniSectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color? color;

  const MiniSectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final headerColor = color ?? AppColors.primary;

    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: headerColor, size: 20),
          const SizedBox(width: 12),
        ],
        Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveUtils.responsiveFontSize(context, mobile: 18, desktop: 20),
            fontWeight: FontWeight.w700,
            color: headerColor,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
