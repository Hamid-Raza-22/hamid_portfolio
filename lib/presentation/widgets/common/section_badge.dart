import 'package:flutter/material.dart';

/// Reusable section badge widget following DRY principle.
/// Used across multiple sections (Services, Portfolio, Contact, Why).
class SectionBadge extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;
  final Widget? leadingWidget;

  const SectionBadge({
    super.key,
    required this.text,
    required this.color,
    this.icon,
    this.leadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingWidget != null) leadingWidget!,
          if (icon != null && leadingWidget == null)
            Icon(
              icon,
              color: color,
              size: 16,
            ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
