import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class PortfolioSection extends StatelessWidget {
  final double rotationValue;
  final bool isVisible;

  const PortfolioSection({
    super.key,
    required this.rotationValue,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Transform.translate(
      offset: Offset(0, 100 * (1 - rotationValue)),
      child: Opacity(
        opacity: isVisible ? rotationValue : 0.0,
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Our Awesome Portfolio',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: controller.geometricRotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: controller.geometricRotationAnimation.value,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[600]!),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPortfolioItem(200, 250, 0),
                  _buildPortfolioItem(180, 220, 1),
                  _buildPortfolioItem(200, 280, 2),
                ],
              ),
              const SizedBox(height: 40),
              _buildProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioItem(double width, double height, int index) {
    final controller = Get.find<HomeController>();

    return Transform.translate(
      offset: Offset(
        30 * (1 - rotationValue) * (index % 2 == 0 ? 1 : -1),
        0,
      ),
      child: Transform.scale(
        scale: 0.8 + (0.2 * rotationValue),
        child: MouseRegion(
          onEnter: (_) {},
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: AnimatedBuilder(
                animation: controller.floatingAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, controller.floatingAnimation.value * 0.2),
                    child: Icon(
                      Icons.web,
                      color: Colors.grey[600],
                      size: 40,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          width: 60 * rotationValue,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        AnimatedBuilder(
          animation: Get.find<HomeController>().pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: Get.find<HomeController>().pulseAnimation.value,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}