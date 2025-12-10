import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../../domain/entities/portfolio_entity.dart';
import '../../common/common_widgets.dart';

/// Portfolio card widget with hover effects.
class PortfolioCard extends StatefulWidget {
  final PortfolioEntity portfolio;
  final int index;
  final double rotationValue;

  const PortfolioCard({
    super.key,
    required this.portfolio,
    required this.index,
    required this.rotationValue,
  });

  @override
  State<PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    setState(() => isHovered = hovering);
    if (hovering) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final clampedRotation = widget.rotationValue.clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: MouseRegion(
            onEnter: (_) => _onHover(true),
            onExit: (_) => _onHover(false),
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: widget.portfolio.color.withOpacity(0.2 * _glowAnimation.value),
                    blurRadius: 30 * _glowAnimation.value,
                    offset: const Offset(0, 15),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: isHovered ? 15 : 10,
                    sigmaY: isHovered ? 15 : 10,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(
                      ResponsiveValue.get<double>(context, mobile: 24, desktop: 32),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isHovered
                            ? [
                                widget.portfolio.color.withOpacity(0.15),
                                AppColors.cardBg.withOpacity(0.9),
                              ]
                            : [
                                AppColors.glassBg,
                                AppColors.cardBg.withOpacity(0.5),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isHovered
                            ? widget.portfolio.color.withOpacity(0.5)
                            : AppColors.glassBorder,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIconAndCategory(),
                        const SizedBox(height: 20),
                        _buildTitle(context),
                        const SizedBox(height: 12),
                        _buildDescription(context),
                        const Spacer(),
                        _buildTags(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIconAndCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isHovered
                  ? [widget.portfolio.color.withOpacity(0.3), widget.portfolio.color.withOpacity(0.1)]
                  : [widget.portfolio.color.withOpacity(0.15), widget.portfolio.color.withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.portfolio.color.withOpacity(isHovered ? 0.5 : 0.2),
              width: 1,
            ),
          ),
          child: Icon(
            widget.portfolio.icon,
            color: isHovered ? widget.portfolio.color : widget.portfolio.color.withOpacity(0.8),
            size: 28,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: widget.portfolio.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: widget.portfolio.color.withOpacity(0.2)),
          ),
          child: Text(
            widget.portfolio.category,
            style: TextStyle(
              color: widget.portfolio.color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      widget.portfolio.title,
      style: TextStyle(
        fontSize: ResponsiveValue.get<double>(context, mobile: 20, desktop: 22),
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      widget.portfolio.description,
      style: TextStyle(
        fontSize: ResponsiveValue.get<double>(context, mobile: 14, desktop: 15),
        color: AppColors.textSecondary,
        height: 1.5,
      ),
    );
  }

  Widget _buildTags() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.portfolio.tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.glassBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        );
      }).toList(),
    );
  }
}
