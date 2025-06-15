import 'package:flutter/material.dart';

import '../../../../core/constants/responsive_constants.dart';
import '../../controllers/home_controller.dart';
import 'package:get/get.dart';

class HeroSection extends StatelessWidget {
  final double fadeAnimationValue;
  final Offset slideAnimationValue;

  const HeroSection({
    super.key,
    required this.fadeAnimationValue,
    required this.slideAnimationValue,
  });

  @override  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _buildMobileHero(),
      desktop: _buildDesktopHero(),
    );
  }
  Widget _buildMobileHero() {
    return Column(
      children: [
        _buildAnimatedText(),
        const SizedBox(height: 20),
        _buildAnimatedHeroImage(),
        const SizedBox(height: 20),
        _buildAnimatedDescription(),
        const SizedBox(height: 20),
        _buildAnimatedServiceButton(),
      ],
    );
  }

  // Update text sizes for mobile
  Widget _buildAnimatedText() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < ResponsiveBreakpoints.mobile;

        return ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Colors.blue],
          ).createShader(bounds),
          child: Text(
            'Build Your\nAwesome\nPlatform',
            style: TextStyle(
              fontSize: isMobile ? 32 : 52,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
        );
      },
    );
  }
  Widget _buildDesktopHero() {
    return Transform.translate(
      offset: slideAnimationValue,
      child: Opacity(
        opacity: fadeAnimationValue,
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimatedText(),
                    const SizedBox(height: 25),
                    _buildAnimatedDescription(),
                    const SizedBox(height: 40),
                    _buildAnimatedServiceButton(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: _buildAnimatedHeroImage(),
              ),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildAnimatedDescription() {
    return Text(
      'Hamid Raza studio is a digital studio that offers several services\nsuch as UI/UX Design to developers, we will provide the best\nservice for those of you who use our services.',
      style: TextStyle(
        color: Colors.grey[300],
        fontSize: 17,
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildAnimatedServiceButton() {
    return MouseRegion(
      onEnter: (_) {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: const Text(
          'Our Services',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeroImage() {
    final controller = Get.find<HomeController>();

    return AnimatedBuilder(
      animation: controller.floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, controller.floatingAnimation.value),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: controller.heroFadeAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: controller.heroFadeAnimation.value,
                    child: Container(
                      width: 280,
                      height: 350,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 40,
                            offset: const Offset(0, 20),
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: AnimatedBuilder(
                          animation: controller.pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: controller.pulseAnimation.value,
                              child: const Icon(
                                Icons.person,
                                size: 120,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}