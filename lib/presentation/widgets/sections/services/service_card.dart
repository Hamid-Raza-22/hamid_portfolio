import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../../domain/entities/service_entity.dart';
import '../../../controllers/home/home_controller.dart';
import '../../common/common_widgets.dart';

/// Service card widget with hover animations.
class ServiceCard extends StatefulWidget {
  final ServiceEntity service;
  final int index;

  const ServiceCard({
    super.key,
    required this.service,
    required this.index,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool isHovered = false;
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final iconSize = ResponsiveValue.get<double>(
          context,
          mobile: 56,
          smallTablet: 58,
          tablet: 60,
          desktop: 64,
        );

        final padding = ResponsiveValue.get<EdgeInsets>(
          context,
          mobile: const EdgeInsets.all(24),
          smallTablet: const EdgeInsets.all(26),
          tablet: const EdgeInsets.all(28),
          desktop: const EdgeInsets.all(32),
        );

        return AnimatedBuilder(
          animation: controller.servicesScaleAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 * (1 - controller.servicesScaleAnimation.value) * (widget.index % 2 == 0 ? 1 : -1),
              ),
              child: HoverContainer(
                builder: (isHovered) {
                  this.isHovered = isHovered;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    transform: Matrix4.identity()
                      ..translate(0.0, isHovered ? -8.0 : 0.0),
                    child: GlassContainer(
                      borderRadius: 20,
                      blurSigma: isHovered ? 15 : 10,
                      padding: padding,
                      backgroundColor: isHovered
                          ? widget.service.color.withOpacity(0.15)
                          : AppColors.glassBg,
                      borderColor: isHovered
                          ? widget.service.color.withOpacity(0.5)
                          : AppColors.glassBorder,
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: widget.service.color.withOpacity(0.25),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                                spreadRadius: 0,
                              ),
                            ]
                          : [],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildIcon(iconSize),
                          const SizedBox(height: 20),
                          _buildTitle(context),
                          const SizedBox(height: 10),
                          _buildDescription(context),
                          const Spacer(),
                          _buildLearnMore(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIcon(double iconSize) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isHovered
              ? [widget.service.color.withOpacity(0.3), widget.service.color.withOpacity(0.1)]
              : [widget.service.color.withOpacity(0.15), widget.service.color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.service.color.withOpacity(isHovered ? 0.5 : 0.2),
          width: 1,
        ),
      ),
      child: AnimatedBuilder(
        animation: controller.floatingAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, controller.floatingAnimation.value * 0.08),
            child: Icon(
              widget.service.icon,
              color: isHovered ? widget.service.color : widget.service.color.withOpacity(0.8),
              size: iconSize * 0.5,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      widget.service.title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: ResponsiveValue.get<double>(
          context,
          mobile: 17,
          smallTablet: 17,
          tablet: 18,
          desktop: 18,
        ),
        fontWeight: FontWeight.w600,
        color: isHovered ? AppColors.textPrimary : AppColors.textPrimary.withOpacity(0.9),
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      widget.service.description,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: ResponsiveValue.get<double>(
          context,
          mobile: 13,
          desktop: 14,
        ),
        color: AppColors.textSecondary,
        height: 1.5,
      ),
    );
  }

  Widget _buildLearnMore() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isHovered ? 1.0 : 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Learn More',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: widget.service.color,
            ),
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.arrow_forward_rounded,
            size: 16,
            color: widget.service.color,
          ),
        ],
      ),
    );
  }
}
