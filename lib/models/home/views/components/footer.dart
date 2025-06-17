import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../controllers/home_controller.dart'; // Assuming HomeController
// Import your responsive constants

class Footer extends GetView<HomeController> {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine the current layout based on screen width
    // This is a simplified way to categorize. You might want more granular control.
    final bool isMobileLayout = MediaQuery.of(context).size.width < ResponsiveBreakpoints.smallTablet;
    final bool isTabletLayout = MediaQuery.of(context).size.width >= ResponsiveBreakpoints.smallTablet &&
        MediaQuery.of(context).size.width < ResponsiveBreakpoints.desktop;
    // Desktop layout is the default if not mobile or tablet

    return AnimatedBuilder(
      animation: controller.portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - controller.portfolioRotationAnimation.value)),
          child: Opacity(
            opacity: controller.portfolioRotationAnimation.value,
            child: Container(
              // Use ResponsivePadding for consistent spacing
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveValue.get<double>(
                  context,
                  mobile: 16, // Base horizontal padding for mobile
                  smallTablet: 24, // etc.
                  tablet: 32,
                  desktop: 40,
                ),
                vertical: ResponsiveValue.get<double>(
                  context,
                  mobile: 32, // Base vertical padding for mobile (double the horizontal in this example)
                  smallTablet: 40, // etc.
                  tablet: 48,
                  desktop: 60,
                ),
              ),
              child: Column(
                children: [
                  // Conditional layout for top section (logo/name and links)
                  if (isMobileLayout) ...[
                    _buildLogoAndName(context),
                    const SizedBox(height: 20), // Consistent spacing
                    _buildFooterLinksSection(context),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: _buildLogoAndName(context)),
                        Flexible(child: _buildFooterLinksSection(context)),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    height: 1,
                    color: Colors.grey[800],
                    margin: EdgeInsets.symmetric(
                      // Responsive horizontal margin for the divider
                      horizontal: ResponsiveValue.get<double>(
                        context,
                        mobile: 20,
                        smallTablet: 40,
                        tablet: 60,
                        desktop: 100 * (1 - controller.portfolioRotationAnimation.value), // Keep your dynamic desktop margin
                      ),
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
                          textAlign: isMobileLayout ? TextAlign.center : TextAlign.left,
                          // Use ResponsiveTextStyle for copyright
                          style: ResponsiveTextStyle.body(context).copyWith(
                              color: Colors.grey[600],
                              fontSize: ResponsiveValue.get<double>( // More specific control if needed
                                context,
                                mobile: 12,
                                smallTablet: 13,
                                tablet: 14,
                                desktop: 14,
                              )
                          ),
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

  Widget _buildLogoAndName(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < ResponsiveBreakpoints.mobile;

    return Row(
      // Center on very small screens, otherwise start
      mainAxisAlignment: isSmallScreen ? MainAxisAlignment.center : MainAxisAlignment.start,
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
        Text(
          'Hamid Raza',
          // Use ResponsiveTextStyle for name
          style: ResponsiveTextStyle.headline(context).copyWith(
            fontSize: ResponsiveValue.get<double>(
              context,
              mobile: 20, // Specific size for mobile
              smallTablet: 22,
              tablet: 24,
              desktop: 24,    // Same as tablet or slightly larger
            ),
            color: Colors.white, // Keep original color
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinksSection(BuildContext context) {
    final bool isMobileOrSmallTablet = MediaQuery.of(context).size.width < ResponsiveBreakpoints.tablet;

    return Wrap(
      spacing: ResponsiveValue.get<double>( // Responsive spacing
        context,
        mobile: 15,
        smallTablet: 20,
        tablet: 25,
        desktop: 30,
      ),
      runSpacing: 10, // Vertical spacing between lines
      // Align links based on screen size
      alignment: ResponsiveValue.get<WrapAlignment>(
        context,
        mobile: WrapAlignment.center,
        smallTablet: WrapAlignment.center,
        tablet: WrapAlignment.end,
        desktop: WrapAlignment.end,
      ),
      children: [
        _buildFooterLink(context, 'Support', 0),
        _buildFooterLink(context, 'Privacy Policy', 1),
        _buildFooterLink(context, 'Terms and Conditions', 2),
      ],
    );
  }

  Widget _buildFooterLink(BuildContext context, String text, int index) {
    return AnimatedBuilder(
      animation: controller.portfolioRotationAnimation,
      builder: (context, child) {
        // Optional: Make animation translation responsive too
        final double translationX = ResponsiveValue.get<double>(
          context,
          mobile: 10,
          smallTablet: 15,
          tablet: 20,
          desktop: 20,
        );

        return Transform.translate(
          offset: Offset(
            translationX * (1 - controller.portfolioRotationAnimation.value) * (index % 2 == 0 ? 1 : -1),
            0,
          ),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Padding( // Add some padding around text for easier tapping
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Text(
                    text,
                    // Use ResponsiveTextStyle for links
                    style: ResponsiveTextStyle.body(context).copyWith(
                      fontSize: ResponsiveValue.get<double>( // More specific control if needed
                        context,
                        mobile: 13,
                        smallTablet: 13,
                        tablet: 14,
                        desktop: 14,
                      ),
                      color: Colors.grey[400], // Keep original color
                    )
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}