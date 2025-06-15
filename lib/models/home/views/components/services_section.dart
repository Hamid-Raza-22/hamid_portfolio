import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'service_card.dart';

class ServicesSection extends StatelessWidget {
  final double scaleValue;
  final bool isVisible;

  const ServicesSection({
    super.key,
    required this.scaleValue,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Transform.scale(
      scale: 0.9 + (0.1 * scaleValue),
      child: Opacity(
        opacity: isVisible ? scaleValue : 0.0,
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: controller.geometricRotationAnimation,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: controller.geometricRotationAnimation.value * 0.3,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.white, Colors.lightBlue],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.white, Colors.blue],
                        ).createShader(bounds),
                        child: const Text(
                          'The Service We Provide\nFor You',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.1,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
                children: const [
                  ServiceCard(
                    icon: Icons.code,
                    title: 'Development',
                    description: 'Create a platform with the best\nand coolest quality from us.',
                    color: Colors.purple,
                    index: 0,
                  ),
                  ServiceCard(
                    icon: Icons.palette,
                    title: 'UI/UX Designer',
                    description: 'We provide UI/UX Design services,\nand of course with the best quality',
                    color: Colors.red,
                    index: 1,
                  ),
                  ServiceCard(
                    icon: Icons.design_services,
                    title: 'Graphic Designer',
                    description: 'We provide Graphic Design\nservices, with the best designers',
                    color: Colors.orange,
                    index: 2,
                  ),
                  ServiceCard(
                    icon: Icons.movie,
                    title: 'Motion Graphic',
                    description: 'Create a platform with the best\nand coolest quality from us.',
                    color: Colors.green,
                    index: 3,
                  ),
                  ServiceCard(
                    icon: Icons.camera_alt,
                    title: 'Photography',
                    description: 'We provide Photography services,\nand of course with the best quality',
                    color: Colors.pink,
                    index: 4,
                  ),
                  ServiceCard(
                    icon: Icons.videocam,
                    title: 'Videography',
                    description: 'Create a platform with the best\nand coolest quality from us.',
                    color: Colors.blue,
                    index: 5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}