import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../presentation/home/controllers/home_controller.dart';
import 'custom_painters.dart';

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
            // AI Neural Network Grid
            _buildNeuralGrid(),
            
            // Electric Particles
            _buildElectricParticles(),
            
            // Flowing Waves
            _buildFlowingWaves(),
            
            // Galaxy Core (Enhanced with Electric Blue)
            _buildGalaxyCore(),

            // Galaxy Arms (Enhanced)
            _buildGalaxyArms(),

            // Neon Stars
            _buildNeonStars(),

            // Nebula Effects (Electric Blue)
            _buildNebulaEffects(),

            // Floating Orbs (Enhanced)
            _buildFloatingOrbs(),

            // Digital Rain Effect
            _buildDigitalRain(),
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
                AppColors.neonBlue.withOpacity(0.4),
                AppColors.primary.withOpacity(0.3),
                AppColors.primaryDark.withOpacity(0.2),
                AppColors.neonPurple.withOpacity(0.1),
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.glowBlue.withOpacity(0.3),
                blurRadius: 80,
                spreadRadius: 20,
              ),
              BoxShadow(
                color: AppColors.glowCyan.withOpacity(0.2),
                blurRadius: 120,
                spreadRadius: 40,
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
                    AppColors.primary.withOpacity(0.15),
                    AppColors.neonBlue.withOpacity(0.20),
                    AppColors.primaryLight.withOpacity(0.12),
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

  Widget _buildNeonStars() {
    return Stack(
      children: List.generate(60, (index) {
        final x = (index * 123.4) % Get.width;
        final y = (index * 234.5) % Get.height;
        final twinkle = math.sin(
            (controller.backgroundAnimation.value * 4 * math.pi) +
                (index * 0.5)
        ).abs();
        
        // Alternate between electric blue and cyan neon colors
        final color = index % 3 == 0 
            ? AppColors.neonBlue 
            : index % 3 == 1 
                ? AppColors.primaryLight 
                : AppColors.glowCyan;

        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: 2 + (twinkle * 3),
            height: 2 + (twinkle * 3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.4 + (twinkle * 0.5)),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 6 + (twinkle * 6),
                  spreadRadius: 1,
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
        // Large nebula cloud
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
                    AppColors.neonPurple.withOpacity(0.12),
                    AppColors.primary.withOpacity(0.15),
                    AppColors.neonBlue.withOpacity(0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        // Smaller nebula
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
                    AppColors.neonBlue.withOpacity(0.15),
                    AppColors.glowCyan.withOpacity(0.10),
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
        // Enhanced original orb
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
                  AppColors.primary.withOpacity(0.25),
                  AppColors.neonBlue.withOpacity(0.15),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.glowBlue.withOpacity(0.2),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
        ),
        // Enhanced second orb
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
                  AppColors.neonPurple.withOpacity(0.18),
                  AppColors.neonPink.withOpacity(0.10),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.glowPurple.withOpacity(0.12),
                  blurRadius: 40,
                  spreadRadius: 8,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitalRain() {
    return Stack(
      children: List.generate(40, (index) {
        final progress = (controller.backgroundAnimation.value + (index * 0.1)) % 1.0;
        final x = (index * 67.8) % Get.width;
        final startY = -100.0;
        final endY = Get.height + 100;
        final y = startY + (progress * (endY - startY));
        
        final color = index % 2 == 0 ? AppColors.neonBlue : AppColors.primaryLight;

        return Positioned(
          left: x + (20 * math.sin(progress * 4 * math.pi)),
          top: y,
          child: Container(
            width: 2,
            height: 8 + (progress * 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withOpacity(0.8),
                  color.withOpacity(0.3),
                  Colors.transparent,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
  
  Widget _buildNeuralGrid() {
    return CustomPaint(
      size: Size(Get.width, Get.height),
      painter: NeuralGridPainter(
        animationValue: controller.backgroundAnimation.value,
      ),
    );
  }
  
  Widget _buildElectricParticles() {
    return Stack(
      children: List.generate(25, (index) {
        final angle = (index * 2 * math.pi / 25) + (controller.backgroundAnimation.value * 2 * math.pi);
        final radius = 100 + (50 * math.sin(controller.backgroundAnimation.value * math.pi));
        final x = Get.width / 2 + (radius * math.cos(angle));
        final y = Get.height / 2 + (radius * math.sin(angle));
        
        return Positioned(
          left: x,
          top: y,
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.neonBlue,
              boxShadow: [
                BoxShadow(
                  color: AppColors.glowBlue.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
  
  Widget _buildFlowingWaves() {
    return CustomPaint(
      size: Size(Get.width, Get.height),
      painter: FlowingWavesPainter(
        animationValue: controller.backgroundAnimation.value,
      ),
    );
  }
}