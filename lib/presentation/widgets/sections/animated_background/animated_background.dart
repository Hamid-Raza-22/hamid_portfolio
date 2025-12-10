import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home/home_controller.dart';

/// Animated galaxy background widget.
/// Provides immersive space-themed background effects.
class AnimatedBackground extends GetView<HomeController> {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        controller.backgroundAnimation,
        controller.geometricRotationAnimation,
      ]),
      builder: (context, child) {
        return Stack(
          children: [
            _buildGalaxyCore(),
            _buildGalaxyArms(),
            _buildDistantStars(),
            _buildNebulaEffects(),
            _buildFloatingOrbs(),
            _buildStardust(),
          ],
        );
      },
    );
  }

  Widget _buildGalaxyCore() {
    return Positioned(
      top: Get.height * 0.3,
      right: Get.width * 0.7,
      child: Transform.rotate(
        angle: controller.geometricRotationAnimation.value * 0.2,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.8,
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.blue.withOpacity(0.2),
                Colors.purple.withOpacity(0.15),
                Colors.indigo.withOpacity(0.1),
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 50,
                spreadRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGalaxyArms() {
    return Stack(
      children: List.generate(4, (index) {
        final rotation = (index * math.pi / 2) +
            (controller.geometricRotationAnimation.value * 0.1);

        return Positioned(
          top: Get.height * 0.3,
          right: Get.width * 0.7,
          child: Transform.rotate(
            angle: rotation,
            child: Container(
              width: 600,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.transparent,
                    Colors.blue.withOpacity(0.08),
                    Colors.cyan.withOpacity(0.12),
                    Colors.white.withOpacity(0.06),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDistantStars() {
    return Stack(
      children: List.generate(50, (index) {
        final x = (index * 123.4) % Get.width;
        final y = (index * 234.5) % Get.height;
        final twinkle = math.sin(
            (controller.backgroundAnimation.value * 4 * math.pi) +
                (index * 0.5)
        ).abs();

        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: 2 + (twinkle * 2),
            height: 2 + (twinkle * 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.3 + (twinkle * 0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 4 + (twinkle * 4),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNebulaEffects() {
    return Stack(
      children: [
        Positioned(
          top: Get.height * 0.1,
          left: Get.width * 0.2,
          child: Transform.rotate(
            angle: controller.backgroundAnimation.value * 0.5,
            child: Container(
              width: 400,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Colors.pink.withOpacity(0.08),
                    Colors.purple.withOpacity(0.12),
                    Colors.indigo.withOpacity(0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: Get.height * 0.2,
          right: Get.width * 0.1,
          child: Transform.rotate(
            angle: -controller.backgroundAnimation.value * 0.3,
            child: Container(
              width: 250,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(125),
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    Colors.teal.withOpacity(0.1),
                    Colors.cyan.withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingOrbs() {
    return Stack(
      children: [
        Positioned(
          top: 100 + (50 * math.sin(controller.backgroundAnimation.value * 2 * math.pi)),
          right: 100 + (30 * math.cos(controller.backgroundAnimation.value * 2 * math.pi)),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.blue.withOpacity(0.15),
                  Colors.cyan.withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 200 + (40 * math.cos(controller.backgroundAnimation.value * 1.5 * math.pi)),
          left: 150 + (60 * math.sin(controller.backgroundAnimation.value * 1.8 * math.pi)),
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.purple.withOpacity(0.12),
                  Colors.pink.withOpacity(0.08),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.08),
                  blurRadius: 25,
                  spreadRadius: 3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStardust() {
    return Stack(
      children: List.generate(30, (index) {
        final progress = (controller.backgroundAnimation.value + (index * 0.1)) % 1.0;
        final x = (index * 67.8) % Get.width;
        final startY = Get.height + 50;
        final endY = -50;
        final y = startY + (progress * (endY - startY));

        return Positioned(
          left: x + (20 * math.sin(progress * 4 * math.pi)),
          top: y,
          child: Container(
            width: 1,
            height: 1,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.6),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.3),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
