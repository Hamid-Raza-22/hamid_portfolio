import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/responsive_constants.dart'; // Ensure this path is correct
import '../../controllers/home_controller.dart';

class WhySection extends GetView<HomeController> {
  const WhySection({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the layout should be stacked (column) or side-by-side (row)
    bool useColumnLayout = ResponsiveValue.get<bool>(
      context,
      mobile: true, // Use Column layout for mobile
      smallTablet: true, // Use Column layout for small tablets
      tablet: false, // Use Row layout for tablets
      desktop: false, // Use Row layout for desktop
    );

    return AnimatedBuilder(
      animation: controller.heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 60 * (1 - controller.heroFadeAnimation.value)),
          child: Opacity(
            opacity: controller.heroFadeAnimation.value,
            child: Container(
              // Use ResponsivePadding for the main container
              padding: ResponsivePadding.all(context, multiplier: 1.25), // e.g., mobile: 20, desktop: 50
              child: useColumnLayout
                  ? _buildColumnLayout(context)
                  : _buildRowLayout(context),
            ),
          ),
        );
      },
    );
  }

  // Layout for mobile and small tablets (stacked)
  Widget _buildColumnLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center, // Center items in column
      children: [
        _buildTextContent(context, textAlign: TextAlign.center),
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 30, desktop: 40)), // Responsive spacing
        _buildAnimatedVideoSection(context, isColumnLayout: true),
      ],
    );
  }

  // Layout for tablets and desktops (side-by-side)
  Widget _buildRowLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2, // Give more space to text content
          child: _buildTextContent(context, textAlign: TextAlign.left),
        ),
        SizedBox(width: ResponsiveValue.get<double>(context, mobile: 0, desktop: 40)), // Only horizontal spacing in row
        Expanded(
          flex: 3, // Give more space to video section
          child: _buildAnimatedVideoSection(context, isColumnLayout: false),
        ),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, {required TextAlign textAlign}) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.left ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center, // Center text vertically if in a row
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Colors.blue],
          ).createShader(bounds),
          child: Text(
            'Why Hamid Raza Is The\nBest Choice?',
            // Use ResponsiveTextStyle for the headline
            style: ResponsiveTextStyle.headline(context).copyWith(
              fontSize: ResponsiveValue.get<double>(context, mobile: 28, smallTablet: 32, tablet: 34, desktop: 38),
              fontWeight: FontWeight.w700,
              color: Colors.white, // Already in ResponsiveTextStyle.headline, but can be overridden
              height: 1.2,
            ),
            textAlign: textAlign,
          ),
        ),
        // Use ResponsivePadding for spacing
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, desktop: 25)),
        Text(
          'Watch this one minute video so you understand why you should\nuse our services!',
          // Use ResponsiveTextStyle for the body text
          style: ResponsiveTextStyle.body(context).copyWith(
            fontSize: ResponsiveValue.get<double>(context, mobile: 15, smallTablet: 16, tablet: 16, desktop: 17),
            height: 1.6,
            color: Colors.grey[300], // Already in ResponsiveTextStyle.body, but can be overridden
          ),
          textAlign: textAlign,
        ),
      ],
    );
  }

  Widget _buildAnimatedVideoSection(BuildContext context, {required bool isColumnLayout}) {
    final double videoContainerHeight = ResponsiveValue.get<double>(
      context,
      mobile: 280, // Adjust height for mobile
      smallTablet: 300,
      tablet: 320,
      desktop: 320,
    );

    // Make the video section take full width in column layout, or a good proportion in row
    final double videoContainerWidth = isColumnLayout
        ? MediaQuery.of(context).size.width * 0.85 // 85% of screen width for column
        : double.infinity; // Takes available space in Expanded widget for row

    final double playButtonSize = ResponsiveValue.get<double>(context, mobile: 70, desktop: 80);
    final double playIconSize = ResponsiveValue.get<double>(context, mobile: 35, desktop: 40);

    return MouseRegion(
      onEnter: (_) {
        // controller.playPulseAnimation(); // Example: Start pulse on hover
      },
      onExit: (_) {
        // controller.stopPulseAnimation(); // Example: Stop pulse on exit
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: videoContainerWidth,
            height: videoContainerHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[800]!, Colors.grey[900]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(ResponsiveValue.get<double>(context, mobile: 15, desktop: 20)), // Responsive border radius
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: ResponsiveValue.get<double>(context, mobile: 20, desktop: 30), // Responsive blur
                  offset: Offset(0, ResponsiveValue.get<double>(context, mobile: 10, desktop: 15)), // Responsive offset
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ResponsiveValue.get<double>(context, mobile: 15, desktop: 20)), // Match container
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey[700]!, Colors.grey[800]!],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.groups, // Placeholder if no video thumbnail
                    size: ResponsiveValue.get<double>(context, mobile: 80, desktop: 100), // Responsive icon size
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: controller.pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: controller.pulseAnimation.value,
                child: Container(
                  width: playButtonSize,
                  height: playButtonSize,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.indigo],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.6),
                        blurRadius: ResponsiveValue.get<double>(context, mobile: 20, desktop: 30),
                        spreadRadius: ResponsiveValue.get<double>(context, mobile: 6, desktop: 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: playIconSize,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}