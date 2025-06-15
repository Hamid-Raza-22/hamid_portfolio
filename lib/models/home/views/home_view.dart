import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'components/animated_background.dart';
import 'components/contact_section.dart';
import 'components/footer.dart';
import 'components/header.dart';
import 'components/hero_section.dart';
import 'components/portfolio_section.dart';
import 'components/services_section.dart';
import 'components/why_section.dart';

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
                    const Color(0xFF1a1a2e),
                    const Color(0xFF16213e),
                    controller.backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF0f3460),
                    const Color(0xFF1a1a2e),
                    controller.backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF0a0a0a),
                    const Color(0xFF0f0f23),
                    controller.backgroundAnimation.value,
                  )!,
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
            child: Stack(
              children: [
                const AnimatedBackground(),
                SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    children: [
                      const Header(),
                      // Obx(() =>
                          HeroSection(
                        fadeAnimationValue: controller.heroFadeAnimation.value,
                        slideAnimationValue: controller.heroSlideAnimation.value,
                      ),
                      // ),
                      const WhySection(),
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
              ],
            ),
          );
        },
      ),
    );
  }
}