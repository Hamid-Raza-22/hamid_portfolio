import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../controllers/home_controller.dart';
import '../../../models/home/views/components/animated_background.dart';
import '../../../models/home/views/components/contact_section.dart';
import '../../../models/home/views/components/footer.dart';
import '../../../models/home/views/components/header.dart';
import '../../../models/home/views/components/hero_section.dart';
import '../../../models/home/views/components/portfolio_section.dart';
import '../../../models/home/views/components/services_section.dart';
import '../../../models/home/views/components/skills_section.dart';
import '../../../models/home/views/components/why_section.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
                radius: 1.5,
                colors: [
                  Color.lerp(
                    AppColors.scaffoldBg,
                    AppColors.primaryDark.withOpacity(0.1),
                    controller.backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    AppColors.cardBg,
                    AppColors.primary.withOpacity(0.05),
                    controller.backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    AppColors.scaffoldBg,
                    AppColors.surfaceDark,
                    controller.backgroundAnimation.value,
                  )!,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
            child: Stack(
              children: [
                const AnimatedBackground(),
                NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      controller.onScrollUpdate(notification.metrics.pixels);
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Header(),
                        HeroSection(
                          fadeAnimationValue: controller.heroFadeAnimation.value,
                          slideAnimationValue: controller.heroSlideAnimation.value,
                        ),
                        const WhySection(),
                        const SkillsSection(),
                        Obx(() => ServicesSection(
                          scaleValue: controller.servicesScaleAnimation.value,
                          isVisible: controller.isServicesVisible.value,
                        )),
                        Obx(() => PortfolioSection(
                          rotationValue: controller.portfolioRotationAnimation.value,
                          isVisible: controller.isPortfolioVisible.value,
                        )),
                        const ContactSection(),
                        const Footer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
