import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class AnimatedBackground extends GetView<HomeController> {
  const AnimatedBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.backgroundAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating gradient orbs
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
                      Colors.blue.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
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
                      Colors.purple.withOpacity(0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}