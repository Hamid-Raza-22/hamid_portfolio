import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/responsive_constants.dart'; // Ensure this path is correct
import '../../controllers/home_controller.dart';

class ContactSection extends GetView<HomeController> {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine if the layout should be stacked (column) or side-by-side (row)
    // For this section, stacking might be better on smaller screens if the text is long.
    bool useColumnLayout = ResponsiveValue.get<bool>(
      context,
      mobile: true, // Use Column layout for mobile
      smallTablet: false, // Use Row layout for small tablets and up
      tablet: false,
      desktop: false,
    );

    // Responsive text alignment
    final TextAlign textAlign = useColumnLayout ? TextAlign.center : TextAlign.left;

    return AnimatedBuilder(
      animation: controller.portfolioRotationAnimation, // Assuming this is the desired animation
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - controller.portfolioRotationAnimation.value)),
          child: Opacity(
            opacity: controller.portfolioRotationAnimation.value,
            child: Container(
              // Use ResponsivePadding for the main container
              padding: ResponsivePadding.all(context, multiplier: 1.0), // e.g., mobile: 16, desktop: 40
              child: useColumnLayout
                  ? _buildColumnLayout(context, textAlign)
                  : _buildRowLayout(context, textAlign),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextContent(BuildContext context, TextAlign textAlign) {
    return Text(
      'Contact us for the service\nyou want to use',
      // Use ResponsiveTextStyle for the headline
      style: ResponsiveTextStyle.headline(context).copyWith(
        fontSize: ResponsiveValue.get<double>(context, mobile: 26, smallTablet: 28, tablet: 30, desktop: 32),
        fontWeight: FontWeight.bold,
        color: Colors.white, // Ensure color is set if not default in ResponsiveTextStyle.headline
        height: 1.2,
      ),
      textAlign: textAlign,
    );
  }

  Widget _buildContactButton(BuildContext context) {
    final double buttonHorizontalPadding = ResponsiveValue.get<double>(context, mobile: 20, desktop: 25);
    final double buttonVerticalPadding = ResponsiveValue.get<double>(context, mobile: 10, desktop: 12);
    final double buttonFontSize = ResponsiveValue.get<double>(context, mobile: 15, desktop: 16);
    final double buttonBorderRadius = ResponsiveValue.get<double>(context, mobile: 4, desktop: 5);
    final double buttonBlurRadius = ResponsiveValue.get<double>(context, mobile: 12, desktop: 15);
    final double buttonShadowOffsetY = ResponsiveValue.get<double>(context, mobile: 6, desktop: 8);

    return AnimatedBuilder(
      animation: controller.pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: controller.pulseAnimation.value,
          child: MouseRegion(
            onEnter: (_) {
              // Optionally trigger animation or visual change
              // For example, you might want to start the pulse animation here
              // if it's not already running continuously.
              // controller.startPulse();
            },
            onExit: (_) {
              // controller.stopPulse();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal: buttonHorizontalPadding,
                vertical: buttonVerticalPadding,
              ),
              decoration: BoxDecoration(
                color: Colors.blue, // Consider making this a theme color
                borderRadius: BorderRadius.circular(buttonBorderRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    blurRadius: buttonBlurRadius,
                    offset: Offset(0, buttonShadowOffsetY),
                  ),
                ],
              ),
              child: Text(
                'Contact us',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.w600, // Added for slight emphasis
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Layout for mobile (stacked)
  Widget _buildColumnLayout(BuildContext context, TextAlign textAlign) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center, // Center items in column
      children: [
        _buildTextContent(context, textAlign),
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 25, desktop: 30)), // Responsive spacing
        _buildContactButton(context),
      ],
    );
  }

  // Layout for tablets and desktops (side-by-side)
  Widget _buildRowLayout(BuildContext context, TextAlign textAlign) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space
      crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
      children: [
        Expanded( // Allow text to take available space and wrap if necessary
          flex: 3, // Give more space to text if needed
          child: _buildTextContent(context, textAlign),
        ),
        // Optional: Add responsive spacing for row layout if needed when not using spaceBetween
        // SizedBox(width: ResponsiveValue.get<double>(context, mobile: 0, desktop: 20)),
        Expanded( // Ensure button doesn't overflow and has its own space
          flex: 2, // Give space to button, adjust flex as needed
          child: Align( // Align button to the right in its expanded space
            alignment: Alignment.centerRight,
            child: _buildContactButton(context),
          ),
        ),
      ],
    );
  }
}