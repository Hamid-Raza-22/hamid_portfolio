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
          mobile: 80,
          smallTablet: 75,
          tablet: 90,
          desktop:75,
        );

        final padding = ResponsiveValue.get<EdgeInsets>(
          context,
          mobile: const EdgeInsets.all(40),
          smallTablet: const EdgeInsets.all(40),
          tablet: const EdgeInsets.all(37),
          desktop: const EdgeInsets.all(50),
        );

        return AnimatedBuilder(
          animation: controller.servicesScaleAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                0,
                50 *
                    (1 - controller.servicesScaleAnimation.value) *
                    (index % 2 == 0 ? 1 : -1),
              ),
              child: MouseRegion(
                onEnter: (_) {},
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: padding,
                  decoration: BoxDecoration(
                    // --- MODIFICATION START ---
                    color: Colors
                        .transparent, // Set background color to transparent
                    // --- MODIFICATION END ---
                    borderRadius: BorderRadius.circular(10),
                    // Optional: You might want to adjust or remove the border if the background is transparent
                    // depending on the desired visual effect against the page background.
                    border: Border.all(
                      color: Colors.grey[800]!.withOpacity(0.5),
                    ), // Example: Make border less opaque or a different color
                    boxShadow: [
                      // Shadows will still be visible
                      BoxShadow(
                        color: color.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: controller.floatingAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              0,
                              controller.floatingAnimation.value * 0.1,
                            ),
                            child: Container(
                              width: iconSize,
                              height: iconSize,
                              decoration: BoxDecoration(
                                color: color.withOpacity(
                                  0.2,
                                ), // Icon background can remain
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
                                size: iconSize * 0.6,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: ResponsiveTextStyle.headline(context).copyWith(
                          fontSize: ResponsiveValue.get<double>(
                            context,
                            mobile: 16,
                            smallTablet: 17,
                            tablet: 18,
                            desktop: 18,
                          ),
                          color: Colors
                              .white, // Ensure text is visible against transparent background
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: ResponsiveTextStyle.body(context).copyWith(
                          color: Colors.grey[300], // Ensure text is visible
                          // height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
