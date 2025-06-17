import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/responsive_constants.dart'; // Ensure this path is correct
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
          // Use ResponsivePadding for the main container
          padding: ResponsivePadding.all(context, multiplier: 1.0), // Example: 40 on desktop, 16 on mobile
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Use ResponsiveTextStyle for the title
                  Text(
                    'Our Awesome Portfolio',
                    style: ResponsiveTextStyle.headline(context).copyWith(
                      // You can still override specific properties if needed
                      // fontSize: ResponsiveValue.get<double>(context, mobile: 28, desktop: 32),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: controller.geometricRotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: controller.geometricRotationAnimation.value,
                        child: Container(
                          width: ResponsiveValue.get<double>(context, mobile: 35, desktop: 40), // Responsive width
                          height: ResponsiveValue.get<double>(context, mobile: 35, desktop: 40), // Responsive height
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[600]!),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.refresh,
                            color: Colors.white,
                            size: ResponsiveValue.get<double>(context, mobile: 18, desktop: 20), // Responsive icon size
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              // Use ResponsivePadding for spacing
              SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, desktop: 40)),
              LayoutBuilder( // Keep LayoutBuilder for direct child width constraints if necessary
                  builder: (context, constraints) {
                    // Determine if we are on a mobile-like layout to stack items
                    bool isMobileLayout = constraints.maxWidth < ResponsiveBreakpoints.smallTablet;

                    return isMobileLayout
                        ? Column( // Stack items vertically on smaller screens
                      children: [
                        _buildPortfolioItem(context, constraints, 200, 250, 0),
                        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, desktop: 0)), // Only vertical spacing on mobile
                        _buildPortfolioItem(context, constraints, 180, 220, 1),
                        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, desktop: 0)),
                        _buildPortfolioItem(context, constraints, 200, 280, 2),
                      ],
                    )
                        : Row( // Keep items in a row on larger screens
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPortfolioItem(context, constraints, 200, 250, 0),
                        _buildPortfolioItem(context, constraints, 180, 220, 1),
                        _buildPortfolioItem(context, constraints, 200, 280, 2),
                      ],
                    );
                  }
              ),
              SizedBox(height: ResponsiveValue.get<double>(context, mobile: 30, desktop: 40)),
              _buildProgressIndicator(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioItem(BuildContext context, BoxConstraints constraints, double desktopWidth, double desktopHeight, int index) {
    final controller = Get.find<HomeController>();

    // Use ResponsiveValue for item width and height, considering LayoutBuilder constraints for smaller screens
    final itemWidth = ResponsiveValue.get<double>(
      context,
      mobile: constraints.maxWidth * 0.85, // Take more width on mobile
      smallTablet: constraints.maxWidth * 0.45,
      tablet: constraints.maxWidth * 0.3,
      desktop: desktopWidth,
    );

    final itemHeight = ResponsiveValue.get<double>(
      context,
      mobile: itemWidth * 1.1, // Adjust aspect ratio for mobile if needed
      smallTablet: itemWidth * 1.0,
      tablet: desktopHeight * 0.9, // Slightly smaller than desktop height
      desktop: desktopHeight,
    );

    return Transform.translate(
      offset: Offset(
        ResponsiveValue.get<double>(context, mobile: 15, desktop: 30) * (1 - rotationValue) * (index % 2 == 0 ? 1 : -1),
        0,
      ),
      child: Transform.scale(
        scale: 0.8 + (0.2 * rotationValue),
        child: MouseRegion(
          onEnter: (_) {}, // Add hover effects if needed
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: itemWidth,
            height: itemHeight,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(ResponsiveValue.get<double>(context, mobile: 8, desktop: 10)), // Responsive border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: ResponsiveValue.get<double>(context, mobile: 10, desktop: 15),
                  offset: Offset(0, ResponsiveValue.get<double>(context, mobile: 6, desktop: 8)),
                ),
              ],
            ),
            child: Center(
              child: AnimatedBuilder(
                animation: controller.floatingAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, controller.floatingAnimation.value * ResponsiveValue.get<double>(context, mobile: 0.15, desktop: 0.2)),
                    child: Icon(
                      Icons.web, // Placeholder icon
                      color: Colors.grey[600],
                      size: ResponsiveValue.get<double>(context, mobile: 30, desktop: 40), // Responsive icon size
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

  Widget _buildProgressIndicator(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          width: ResponsiveValue.get<double>(context, mobile: 40, desktop: 60) * rotationValue, // Responsive width
          height: ResponsiveValue.get<double>(context, mobile: 2.5, desktop: 3), // Responsive height
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(ResponsiveValue.get<double>(context, mobile: 1.5, desktop: 2)), // Responsive radius
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurRadius: ResponsiveValue.get<double>(context, mobile: 7, desktop: 10),
                spreadRadius: ResponsiveValue.get<double>(context, mobile: 1.5, desktop: 2),
              ),
            ],
          ),
        ),
        SizedBox(width: ResponsiveValue.get<double>(context, mobile: 8, desktop: 10)),
        AnimatedBuilder(
          animation: Get.find<HomeController>().pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: Get.find<HomeController>().pulseAnimation.value,
              child: Container(
                width: ResponsiveValue.get<double>(context, mobile: 6, desktop: 8), // Responsive size
                height: ResponsiveValue.get<double>(context, mobile: 6, desktop: 8), // Responsive size
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