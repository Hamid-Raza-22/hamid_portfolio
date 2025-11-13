import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../../presentation/home/controllers/home_controller.dart';
import 'service_card.dart'; // Assuming ServiceCard is also made responsive or handles it internally

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

    // Determine the number of columns and child aspect ratio based on screen size
    final int crossAxisCount = ResponsiveValue.get<int>(
      context,
      mobile: 1, // 1 column on mobile
      smallTablet: 2, // 2 columns on small tablets
      tablet: 3, // 2 columns on tablets
      desktop: 4, // 3 columns on desktop
    );

    final double childAspectRatio = ResponsiveValue.get<double>(
      context,
      mobile: 1.5, // Adjust for better fit on mobile (height > width)
      smallTablet: 1.4,
      tablet: 1.1,
      desktop: 1.15, // Can be adjusted for optimal look on desktop
    );

    final double mainAxisSpacing = ResponsiveValue.get<double>(context, mobile: 15, desktop: 20);
    final double crossAxisSpacing = ResponsiveValue.get<double>(context, mobile: 15, desktop: 20);

    return Transform.scale(
      scale: 0.9 + (0.1 * scaleValue), // This animation can remain as is
      child: Opacity(
        opacity: isVisible ? scaleValue : 0.0, // This animation can remain as is
        child: Container(
          // Use ResponsivePadding for the main container
          padding: ResponsivePadding.all(context, multiplier: 1.25), // e.g., mobile: 20, desktop: 50
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
                children: [
                  Flexible( // Use Flexible to prevent overflow if text is too long
                    child: Row(
                      children: [
                        AnimatedBuilder(
                          animation: controller.geometricRotationAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: controller.geometricRotationAnimation.value * 0.3,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [AppColors.primary, AppColors.neonBlue],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.glowBlue.withOpacity(0.5),
                                      blurRadius: 15,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.widgets_rounded,
                                  color: Colors.black,
                                  size: ResponsiveValue.get<double>(context, mobile: 20, desktop: 24),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: ResponsiveValue.get<double>(context, mobile: 10, desktop: 20)), // Responsive spacing
                        Flexible(
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                AppColors.textPrimary,
                                AppColors.primary,
                                AppColors.neonBlue,
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ).createShader(bounds),
                            child: Text(
                              'Services We Provide\nFor You',
                              style: ResponsiveTextStyle.headline(context).copyWith(
                                fontSize: ResponsiveValue.get<double>(
                                  context, 
                                  mobile: 28, 
                                  smallTablet: 32, 
                                  tablet: 36, 
                                  desktop: 38
                                ),
                                fontWeight: FontWeight.w800,
                                height: 1.2,
                                letterSpacing: -0.5,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // If you had elements on the right side of this Row, ensure they are also responsive
                ],
              ),
              SizedBox(height: ResponsiveValue.get<double>(context, mobile: 30, desktop: 50)), // Responsive spacing

              GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true, // Important for GridView inside a Column
                physics: const NeverScrollableScrollPhysics(), // If you don't want GridView to scroll independently
                childAspectRatio: childAspectRatio,
                mainAxisSpacing: mainAxisSpacing,
                crossAxisSpacing: crossAxisSpacing,
                // Optional: Responsive padding for the GridView itself if needed,
                // otherwise the container padding might be sufficient.
                // padding: ResponsivePadding.symmetric(context, horizontalMultiplier: 0.5),
                children: const [
                  // Assuming ServiceCard is designed to be responsive
                  // or takes parameters that can be made responsive.
                  // If ServiceCard itself needs explicit responsive properties,
                  // you might pass them down or refactor ServiceCard.
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
                    description: 'We provide UI/UX Design services,\nwith the best quality',
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
                    description: 'We provide Photography services,\nwith the best quality',
                    color: Colors.pink,
                    index: 4,
                  ),
                  ServiceCard(
                    icon: Icons.videocam,
                    title: 'Videography',
                    description: 'Create a platform with the best\nand coolest quality from us.',
                    color: Colors.blue,
                    index: 5,
                  ), ServiceCard(
                    icon: Icons.local_fire_department_rounded,
                    title: 'Videography',
                    description: 'Create a platform with the best\nand coolest quality from us.',
                    color: Colors.orange,
                    index: 6,
                  ), ServiceCard(
                    icon: Icons.face,
                    title: 'Videography',
                    description: 'Create a platform with the best\nand coolest quality from us.',
                    color: Colors.blue,
                    index: 7,
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