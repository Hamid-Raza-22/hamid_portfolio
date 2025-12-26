import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../controllers/home/home_controller.dart';
import '../../common/common_widgets.dart';
import 'service_card.dart';

/// Services section displaying all offered services.
class ServicesSection extends StatelessWidget {
  final double scaleValue;
  final bool isVisible;

  const ServicesSection({
    super.key,
    required this.scaleValue,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    final crossAxisCount = ResponsiveValue.get<int>(
      context,
      mobile: 1,
      smallTablet: 2,
      tablet: 3,
      desktop: 4,
    );

    final childAspectRatio = ResponsiveValue.get<double>(
      context,
      mobile: 1.2,
      smallTablet: 1.0,
      tablet: 0.9,
      desktop: 0.95,
    );

    final mainAxisSpacing = ResponsiveValue.get<double>(context, mobile: 16, desktop: 24);
    final crossAxisSpacing = ResponsiveValue.get<double>(context, mobile: 16, desktop: 24);

    final clampedScale = scaleValue.clamp(0.0, 1.0);

    return Transform.scale(
      scale: 0.9 + (0.1 * clampedScale),
      child: Opacity(
        opacity: isVisible ? clampedScale : 0.0,
        child: Container(
          padding: ResponsivePadding.all(context, multiplier: 1.5),
          child: Column(
            children: [
              _buildSectionHeader(context, controller),
              SizedBox(height: ResponsiveValue.get<double>(context, mobile: 32, desktop: 48)),
              Obx(() => GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: childAspectRatio,
                mainAxisSpacing: mainAxisSpacing,
                crossAxisSpacing: crossAxisSpacing,
                children: controller.services.asMap().entries.map((entry) {
                  return ServiceCard(
                    service: entry.value,
                    index: entry.key,
                  );
                }).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, HomeController controller) {
    final isMobile = ResponsiveValue.get<bool>(context, mobile: true, desktop: false);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        SectionBadge(
          text: 'SERVICES',
          color: AppColors.accent,
          leadingWidget: AnimatedBuilder(
            animation: controller.geometricRotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.geometricRotationAnimation.value * 0.3,
                child: const Icon(
                  Icons.code_rounded,
                  color: AppColors.accent,
                  size: 16,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        GradientText(
          text: 'What I Offer',
          colors: const [Colors.white, AppColors.primaryLight, AppColors.accent],
          stops: const [0.0, 0.5, 1.0],
          style: ResponsiveTextStyle.headline(context).copyWith(
            fontSize: ResponsiveValue.get<double>(
              context,
              mobile: 28,
              smallTablet: 34,
              tablet: 40,
              desktop: 48,
            ),
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -1,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: ResponsiveValue.get<double>(
            context,
            mobile: double.infinity,
            smallTablet: double.infinity,
            tablet: 450,
            desktop: 550,
          ),
          child: Text(
            'Comprehensive solutions tailored to bring your digital vision to life with cutting-edge technology.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: ResponsiveValue.get<double>(
                context,
                mobile: 14,
                smallTablet: 15,
                tablet: 16,
                desktop: 17,
              ),
              height: 1.6,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
      ],
    );
  }
}
