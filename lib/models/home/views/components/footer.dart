import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class Footer extends GetView<HomeController> {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - controller.portfolioRotationAnimation.value)),
          child: Opacity(
            opacity: controller.portfolioRotationAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: controller.pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: controller.pulseAnimation.value,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.5),
                                        blurRadius: 10 * controller.pulseAnimation.value,
                                        spreadRadius: 2 * controller.pulseAnimation.value,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Hamid Raza',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildFooterLink('Support', 0),
                          const SizedBox(width: 30),
                          _buildFooterLink('Privacy Policy', 1),
                          const SizedBox(width: 30),
                          _buildFooterLink('Terms and Conditions', 2),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    height: 1,
                    color: Colors.grey[800],
                    margin: EdgeInsets.symmetric(
                      horizontal: 100 * (1 - controller.portfolioRotationAnimation.value),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: controller.floatingAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, controller.floatingAnimation.value * 0.1),
                        child: Text(
                          '© 2023 Hamid Raza, All Rights Reserved',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooterLink(String text, int index) {
    return AnimatedBuilder(
      animation: controller.portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            20 * (1 - controller.portfolioRotationAnimation.value) * (index % 2 == 0 ? 1 : -1),
            0,
          ),
          child: MouseRegion(
            onEnter: (_) {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Text(
                text,
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),
        );
      },
    );
  }
}