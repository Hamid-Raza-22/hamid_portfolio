import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../../presentation/home/controllers/home_controller.dart';

class ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final int index;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.index,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
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

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return LayoutBuilder(
      builder: (context, constraints) {
        final iconSize = ResponsiveValue.get<double>(
          context,
          mobile: 80,
          smallTablet: 75,
          tablet: 90,
          desktop:75,
        );

        final padding = ResponsiveValue.get<EdgeInsets>(
          context,
          mobile: const EdgeInsets.all(40),
          smallTablet: const EdgeInsets.all(40),
          tablet: const EdgeInsets.all(37),
          desktop: const EdgeInsets.all(50),
        );

        return AnimatedBuilder(
          animation: Listenable.merge([controller.servicesScaleAnimation, _hoverController]),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 *
                    (1 - controller.servicesScaleAnimation.value) *
                    (widget.index % 2 == 0 ? 1 : -1),
              ),
              child: MouseRegion(
                onEnter: (_) {
                  setState(() => _isHovered = true);
                  _hoverController.forward();
                },
                onExit: (_) {
                  setState(() => _isHovered = false);
                  _hoverController.reverse();
                },
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    padding: padding,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _isHovered
                            ? AppColors.primary.withOpacity(0.6)
                            : AppColors.borderSecondary.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withOpacity(0.1 + (0.2 * _glowAnimation.value)),
                          blurRadius: 20 + (15 * _glowAnimation.value),
                          offset: const Offset(0, 5),
                          spreadRadius: 2 * _glowAnimation.value,
                        ),
                        if (_isHovered)
                          BoxShadow(
                            color: AppColors.glowBlue.withOpacity(0.3),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.cardBg.withOpacity(0.7),
                                AppColors.cardBgLight.withOpacity(0.5),
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: controller.floatingAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      0,
                                      controller.floatingAnimation.value * 0.1,
                                    ),
                                    child: Container(
                                      width: iconSize,
                                      height: iconSize,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            widget.color.withOpacity(0.3),
                                            widget.color.withOpacity(0.1),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: widget.color.withOpacity(_isHovered ? 0.6 : 0.3),
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: widget.color.withOpacity(0.3 + (0.3 * _glowAnimation.value)),
                                            blurRadius: 15 + (10 * _glowAnimation.value),
                                            spreadRadius: 2 + (3 * _glowAnimation.value),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        widget.icon,
                                        color: _isHovered ? widget.color : widget.color.withOpacity(0.8),
                                        size: iconSize * 0.55,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: ResponsiveTextStyle.headline(context).copyWith(
                                  fontSize: ResponsiveValue.get<double>(
                                    context,
                                    mobile: 17,
                                    smallTablet: 18,
                                    tablet: 19,
                                    desktop: 20,
                                  ),
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.description,
                                textAlign: TextAlign.center,
                                style: ResponsiveTextStyle.body(context).copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: ResponsiveValue.get<double>(
                                    context,
                                    mobile: 13,
                                    desktop: 14,
                                  ),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
