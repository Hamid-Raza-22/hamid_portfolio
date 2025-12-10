import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../controllers/home/home_controller.dart';
import 'hero_painters.dart';

/// Animated hero image with floating effect and decorations.
class HeroImage extends GetView<HomeController> {
  final bool isMobileLayout;

  const HeroImage({super.key, required this.isMobileLayout});

  @override
  Widget build(BuildContext context) {
    final containerBaseWidth = ResponsiveValue.get<double>(
      context,
      mobile: 220,
      smallTablet: 250,
      tablet: 260,
      desktop: 280,
    );
    final containerBaseHeight = ResponsiveValue.get<double>(
      context,
      mobile: 280,
      smallTablet: 310,
      tablet: 330,
      desktop: 350,
    );

    const imageGap = 2.0;
    final imageWidth = ResponsiveValue.get<double>(
      context,
      mobile: 180 - (2 * imageGap),
      smallTablet: 210 - (2 * imageGap),
      tablet: 225 - (2 * imageGap),
      desktop: 240 - (2 * imageGap),
    );
    final imageHeight = ResponsiveValue.get<double>(
      context,
      mobile: 240 - (2 * imageGap),
      smallTablet: 260 - (2 * imageGap),
      tablet: 270 - (2 * imageGap),
      desktop: 300 - (2 * imageGap),
    );

    final borderRadius = ResponsiveValue.get<double>(
      context,
      mobile: 20,
      desktop: 25,
    );

    return AnimatedBuilder(
      animation: controller.floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            controller.floatingAnimation.value * (isMobileLayout ? 0.7 : 1.0),
          ),
          child: SizedBox(
            width: containerBaseWidth * 2.2,
            height: containerBaseHeight * 2.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                HeroBackgroundDecorations(
                  containerWidth: containerBaseWidth,
                  containerHeight: containerBaseHeight,
                ),
                AnimatedBuilder(
                  animation: controller.heroFadeAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: isMobileLayout
                          ? 1.0
                          : controller.heroFadeAnimation.value,
                      child: Container(
                        width: containerBaseWidth,
                        height: containerBaseHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 25,
                              offset: const Offset(0, 15),
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                              spreadRadius: -5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedBuilder(
                            animation: controller.pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: controller.pulseAnimation.value,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    borderRadius - 4,
                                  ),
                                  child: Image.asset(
                                    AppAssets.anotherImage,
                                    width: imageWidth,
                                    height: imageHeight,
                                    fit: BoxFit.cover,
                                  ),
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
          ),
        );
      },
    );
  }
}

/// Background decorative elements for hero image.
class HeroBackgroundDecorations extends StatelessWidget {
  final double containerWidth;
  final double containerHeight;

  const HeroBackgroundDecorations({
    super.key,
    required this.containerWidth,
    required this.containerHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blue background card
        Positioned(
          top: containerHeight * 0.4,
          left: containerWidth * 0.1,
          child: Transform.rotate(
            angle: 0.15,
            child: Container(
              width: containerWidth * 1.4,
              height: containerHeight * 1.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF1E3A8A).withOpacity(0.8),
                    const Color(0xFF3B82F6).withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 30,
                    offset: const Offset(10, 15),
                    spreadRadius: -5,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Scattered dots
        ...List.generate(12, (index) {
          final positions = [
            {'top': 0.05, 'left': 0.1},
            {'top': 0.15, 'right': 0.05},
            {'top': 0.25, 'left': 0.02},
            {'top': 0.35, 'right': 0.15},
            {'top': 0.45, 'left': 0.08},
            {'top': 0.55, 'right': 0.03},
            {'bottom': 0.35, 'left': 0.05},
            {'bottom': 0.25, 'right': 0.12},
            {'bottom': 0.15, 'left': 0.15},
            {'bottom': 0.05, 'right': 0.08},
            {'top': 0.08, 'left': 0.8},
            {'bottom': 0.4, 'right': 0.7},
          ];

          final pos = positions[index];
          return Positioned(
            top: pos['top'] != null ? containerHeight * pos['top']! : null,
            bottom: pos['bottom'] != null ? containerHeight * pos['bottom']! : null,
            left: pos['left'] != null ? containerWidth * pos['left']! : null,
            right: pos['right'] != null ? containerWidth * pos['right']! : null,
            child: Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          );
        }),

        // Triangle outline
        Positioned(
          top: containerHeight * 0.15,
          left: containerWidth * 0.2,
          child: CustomPaint(
            size: const Size(35, 35),
            painter: TrianglePainter(color: Colors.white.withOpacity(0.8)),
          ),
        ),

        // Mountain peaks
        Positioned(
          top: containerHeight * 0.08,
          left: containerWidth * 0.55,
          child: CustomPaint(
            size: const Size(45, 25),
            painter: MountainPeaksPainter(color: Colors.white.withOpacity(0.7)),
          ),
        ),

        // Circle outline
        Positioned(
          top: containerHeight * 0.12,
          right: containerWidth * 0.15,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 2.5,
              ),
            ),
          ),
        ),

        // Play button
        Positioned(
          bottom: containerHeight * 0.25,
          left: containerWidth * 0.15,
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white.withOpacity(0.8),
              size: 22,
            ),
          ),
        ),

        // Plus sign
        Positioned(
          bottom: containerHeight * 0.15,
          right: containerWidth * 0.1,
          child: CustomPaint(
            size: const Size(25, 25),
            painter: PlusPainter(color: Colors.white.withOpacity(0.7)),
          ),
        ),
      ],
    );
  }
}
