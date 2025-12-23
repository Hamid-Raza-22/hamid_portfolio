import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../controllers/home/home_controller.dart';
import '../../widgets/common/shimmer_widgets.dart';
import '../../widgets/sections/sections.dart';

/// Home page following MVVM pattern with GetView.
/// This is the main view that composes all section widgets.
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller.backgroundAnimation,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.8,
                colors: [
                  Color.lerp(
                    const Color(0xFF0F172A),
                    const Color(0xFF1E1B4B),
                    controller.backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF0C4A6E).withOpacity(0.3),
                    const Color(0xFF312E81).withOpacity(0.2),
                    controller.backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    AppColors.scaffoldBg,
                    const Color(0xFF020617),
                    controller.backgroundAnimation.value,
                  )!,
                ],
                stops: const [0.0, 0.35, 1.0],
              ),
            ),
            child: Stack(
              children: [
                const AnimatedBackground(),
                _buildGradientOrbs(),
                _buildMainContent(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGradientOrbs() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: AnimatedBuilder(
            animation: controller.backgroundAnimation,
            builder: (context, _) {
              return Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.15 * controller.backgroundAnimation.value),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 200,
          left: -150,
          child: AnimatedBuilder(
            animation: controller.backgroundAnimation,
            builder: (context, _) {
              return Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.1 * (1 - controller.backgroundAnimation.value)),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          const HeaderSection(),
          Obx(() {
            // Show skeleton while hero data is loading
            if (controller.heroSection.value == null) {
              return const HeroSkeleton();
            }
            return AnimatedBuilder(
              animation: Listenable.merge([
                controller.heroFadeAnimation,
                controller.heroSlideAnimation,
              ]),
              builder: (context, _) {
                return HeroSection(
                  fadeAnimationValue: controller.heroFadeAnimation.value,
                  slideAnimationValue: controller.heroSlideAnimation.value,
                );
              },
            );
          }),
          const WhySection(),
          Obx(() {
            // Show skeleton while services are loading
            if (controller.services.isEmpty) {
              return const ServicesSkeleton(itemCount: 4);
            }
            return ServicesSection(
              scaleValue: controller.servicesScaleAnimation.value,
              isVisible: controller.isServicesVisible.value,
            );
          }),
          Obx(() {
            // Show skeleton while portfolio items are loading
            if (controller.portfolioItems.isEmpty) {
              return const PortfolioSkeleton(itemCount: 3);
            }
            return PortfolioSection(
              rotationValue: controller.portfolioRotationAnimation.value,
              isVisible: controller.isPortfolioVisible.value,
            );
          }),
          const ContactSection(),
          const FooterSection(),
        ],
      ),
    );
  }
}
