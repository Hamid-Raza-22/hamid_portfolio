import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

/// Reusable bullet list widget following DRY principle.
class BulletList extends StatelessWidget {
  final List<String> items;
  final Color dotColor;
  final TextStyle? textStyle;
  final double dotSize;
  final double spacing;

  const BulletList({
    super.key,
    required this.items,
    this.dotColor = AppColors.accent,
    this.textStyle,
    this.dotSize = 6,
    this.spacing = AppSpacing.sm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => _BulletItem(
        text: item,
        dotColor: dotColor,
        textStyle: textStyle ?? AppTextStyles.bodyMedium,
        dotSize: dotSize,
        spacing: spacing,
      )).toList(),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;
  final Color dotColor;
  final TextStyle textStyle;
  final double dotSize;
  final double spacing;

  const _BulletItem({
    required this.text,
    required this.dotColor,
    required this.textStyle,
    required this.dotSize,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacing),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
