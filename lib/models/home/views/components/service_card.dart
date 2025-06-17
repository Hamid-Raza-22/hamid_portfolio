import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../controllers/home_controller.dart';

class ServiceCard extends GetView<HomeController> {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final int index;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final iconSize = ResponsiveValue.get<double>(
          context,
          mobile: 40,
          smallTablet: 45,
          tablet: 45,
          desktop: 50,
        );

        final padding = ResponsiveValue.get<EdgeInsets>(
          context,
          mobile: const EdgeInsets.all(12),
          smallTablet: const EdgeInsets.all(15),
          tablet: const EdgeInsets.all(18),
          desktop: const EdgeInsets.all(20),
        );

        return AnimatedBuilder(
          animation: controller.servicesScaleAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 * (1 - controller.servicesScaleAnimation.value) *
                    (index % 2 == 0 ? 1 : -1),
              ),
              child: MouseRegion(
                onEnter: (_) {},
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  // padding: const EdgeInsets.all(20),
                  padding: padding,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[800]!),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedBuilder(
                        animation: controller.floatingAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                0, controller.floatingAnimation.value * 0.1),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                icon,
                                color: color,
                                size: 24,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      // const SizedBox(height: 15),
                      // Text(
                      //   title,
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      Text(
                        title,
                        style: ResponsiveTextStyle.headline(context).copyWith(
                          fontSize: ResponsiveValue.get<double>(
                            context,
                            mobile: 16,
                            smallTablet: 17,
                            tablet: 18,
                            desktop: 18,
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      const SizedBox(height: 8),
                      // Text(
                      //   description,
                      //   style: TextStyle(
                      //     color: Colors.grey[400],
                      //     fontSize: 14,
                      //     height: 1.4,
                      //   ),
                      // ),
                      Text(
                        description,
                        style: ResponsiveTextStyle.body(context),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },);
  }
}