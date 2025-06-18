import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/responsive_constants.dart'; // Ensure this path is correct
import '../../controllers/home_controller.dart';

class HeroSection extends StatelessWidget {
  final double fadeAnimationValue; // For desktop animation
  final Offset slideAnimationValue; // For desktop animation

  const HeroSection({
    super.key,
    required this.fadeAnimationValue,
    required this.slideAnimationValue,
  });

  @override
  Widget build(BuildContext context) {
    // You can keep ResponsiveLayout if you have distinctly different widget trees
    // or simplify if the structure is similar enough to be handled by responsive values.
    // For this example, we'll keep it to show how to use responsive values within it.
    return ResponsiveLayout(
      mobile: _buildMobileHero(context),
      // If smallTablet/tablet layouts are very similar to mobile or desktop,
      // you can omit them and ResponsiveLayout will fallback appropriately.
      // Or, define them explicitly:
      // smallTablet: _buildMobileHero(context, isSmallTablet: true), // Example
      // tablet: _buildDesktopHero(context), // Example if tablet is closer to desktop
      desktop: _buildDesktopHero(context),
    );
  }

  // --- Mobile Specific Layout ---
  Widget _buildMobileHero(BuildContext context, {bool isSmallTablet = false}) {
    // Responsive spacing values for mobile
    final double verticalSpaceSmall = ResponsiveValue.get<double>(
      context,
      mobile: 15,
      smallTablet: 20,
      tablet: 20,
      desktop: 20,
    );
    final double verticalSpaceMedium = ResponsiveValue.get<double>(
      context,
      mobile: 25,
      smallTablet: 30,
      tablet: 30,
      desktop: 30,
    );

    return Container(
      padding: ResponsivePadding.all(
        context,
        multiplier: 1.0,
      ), // e.g., mobile 16, desktop 40 (won't apply here, but good practice)
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAnimatedText(context),
          SizedBox(height: verticalSpaceMedium),
          _buildAnimatedHeroImage(context, isMobileLayout: true),
          SizedBox(height: verticalSpaceMedium),
          _buildAnimatedDescription(context, textAlign: TextAlign.center),
          SizedBox(height: verticalSpaceSmall),
          _buildAnimatedServiceButton(context),
        ],
      ),
    );
  }

  // --- Desktop Specific Layout ---
  Widget _buildDesktopHero(BuildContext context) {
    // Responsive spacing values for desktop
    final double verticalSpaceSmall = ResponsiveValue.get<double>(
      context,
      mobile: 20,
      desktop: 25,
    );
    final double verticalSpaceMedium = ResponsiveValue.get<double>(
      context,
      mobile: 30,
      desktop: 40,
    );

    return Transform.translate(
      offset: slideAnimationValue,
      child: Opacity(
        opacity: fadeAnimationValue,
        child: Container(
          // Responsive padding for the desktop container
          padding: ResponsivePadding.all(
            context,
            multiplier: 1.25,
          ), // e.g., mobile 20, desktop 50
          child: Row(
            children: [
              Expanded(
                flex: ResponsiveValue.get<int>(
                  context,
                  mobile: 1,
                  tablet: 2,
                  desktop: 2,
                ), // Adjust flex based on screen
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAnimatedText(context),
                    SizedBox(height: verticalSpaceSmall),
                    _buildAnimatedDescription(
                      context,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: verticalSpaceMedium),
                    _buildAnimatedServiceButton(context),
                  ],
                ),
              ),
              SizedBox(
                width: ResponsiveValue.get<double>(
                  context,
                  mobile: 0,
                  desktop: 30,
                ),
              ), // Spacing between text and image on desktop
              Expanded(
                flex: ResponsiveValue.get<int>(
                  context,
                  mobile: 1,
                  tablet: 1,
                  desktop: 1,
                ), // Adjust flex based on screen
                child: _buildAnimatedHeroImage(context, isMobileLayout: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Shared Reusable Widgets (Made Responsive) ---

  Widget _buildAnimatedText(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Colors.white,
          Colors.blue,
        ], // Consider making these theme colors
      ).createShader(bounds),
      child: Text(
        'Build Your\nAwesome\nPlatform', // Consider internationalization for text
        // Use ResponsiveTextStyle for the headline
        style: ResponsiveTextStyle.headline(context).copyWith(
          // More granular control for hero text if needed
          fontSize: ResponsiveValue.get<double>(
            context,
            mobile: 36, // Slightly larger for mobile hero
            smallTablet: 42,
            tablet: 48,
            desktop: 52,
          ),
          fontWeight: FontWeight.w800,
          color: Colors
              .white, // Ensure this matches if not default in ResponsiveTextStyle
          height: 1.1,
          letterSpacing: -0.5,
        ),
        textAlign:
            ResponsiveValue.get<bool>(context, mobile: true, desktop: false)
            ? TextAlign.center
            : TextAlign.left, // Center on mobile, left on desktop
      ),
    );
  }

  Widget _buildAnimatedDescription(
    BuildContext context, {
    required TextAlign textAlign,
  }) {
    return Text(
      'Hamid Raza studio is a digital studio that offers several services\nsuch as UI/UX Design to developers, we will provide the best\nservice for those of you who use our services.',
      // Use ResponsiveTextStyle for body text
      style: ResponsiveTextStyle.body(context).copyWith(
        fontSize: ResponsiveValue.get<double>(
          context,
          mobile: 15,
          smallTablet: 16,
          tablet: 16,
          desktop: 17,
        ),
        height: 1.6,
        color: Colors
            .grey[300], // Ensure this matches if not default in ResponsiveTextStyle
      ),
      textAlign: textAlign,
    );
  }

  Widget _buildAnimatedServiceButton(BuildContext context) {
    // Responsive padding and font size for the button
    final double buttonHorizontalPadding = ResponsiveValue.get<double>(
      context,
      mobile: 28,
      desktop: 32,
    );
    final double buttonVerticalPadding = ResponsiveValue.get<double>(
      context,
      mobile: 14,
      desktop: 16,
    );
    final double buttonFontSize = ResponsiveValue.get<double>(
      context,
      mobile: 15,
      desktop: 16,
    );
    final double buttonBorderRadius = ResponsiveValue.get<double>(
      context,
      mobile: 6,
      desktop: 8,
    );
    final double buttonBlurRadius = ResponsiveValue.get<double>(
      context,
      mobile: 15,
      desktop: 20,
    );
    final double buttonShadowOffsetY = ResponsiveValue.get<double>(
      context,
      mobile: 8,
      desktop: 10,
    );

    return MouseRegion(
      onEnter: (_) {
        // controller.startHoverAnimation(); // Example
      },
      onExit: (_) {
        // controller.stopHoverAnimation(); // Example
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: EdgeInsets.symmetric(
          horizontal: buttonHorizontalPadding,
          vertical: buttonVerticalPadding,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.indigo], // Consider theme colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
          'Our Services',
          style: TextStyle(
            color: Colors.white,
            fontSize: buttonFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

Widget _buildAnimatedHeroImage(
      BuildContext context, {
        required bool isMobileLayout,
      }) {
    final controller = Get.find<HomeController>();

    // Responsive dimensions for the image container
    final double containerBaseWidth = ResponsiveValue.get<double>(
      context,
      mobile: 220,
      smallTablet: 250,
      tablet: 260,
      desktop: 280,
    );
    final double containerBaseHeight = ResponsiveValue.get<double>(
      context,
      mobile: 280,
      smallTablet: 310,
      tablet: 330,
      desktop: 350,
    );

    // --- MODIFICATION START ---
    // Define the gap you want
    const double imageGap = 2.0; // The 2-point gap

    // Responsive dimensions for the image itself, considering the gap
    // The image will be smaller than the container by 2 * imageGap (for both sides)
    final double imageWidth = ResponsiveValue.get<double>(
      context,
      mobile: 180 - (2 * imageGap), // Adjust base size as needed
      smallTablet: 210 - (2 * imageGap),
      tablet: 225 - (2 * imageGap),
      desktop: 240 - (2 * imageGap),
    );
    final double imageHeight = ResponsiveValue.get<double>(
      context,
      mobile: 240 - (2 * imageGap), // Adjust base size as needed
      smallTablet: 260 - (2 * imageGap),
      tablet: 270 - (2 * imageGap),
      desktop: 300 - (2 * imageGap),
    );
    // --- MODIFICATION END ---

    final double borderRadius = ResponsiveValue.get<double>(
      context,
      mobile: 20,
      desktop: 25,
    );
    final double shadowBlurRadius = ResponsiveValue.get<double>(
      context,
      mobile: 30,
      desktop: 40,
    );
    final double shadowOffsetY = ResponsiveValue.get<double>(
      context,
      mobile: 15,
      desktop: 20,
    );
    final double shadowSpreadRadius = ResponsiveValue.get<double>(
      context,
      mobile: 3,
      desktop: 5,
    );

    return AnimatedBuilder(
      animation:
      controller.floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            controller.floatingAnimation.value * (isMobileLayout ? 0.7 : 1.0),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: controller.heroFadeAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: isMobileLayout
                        ? 1.0
                        : controller.heroFadeAnimation.value,
                    child: Container( // This is the outer gradient container
                      width: containerBaseWidth,
                      height: containerBaseHeight,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.deepOrange,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(borderRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: shadowBlurRadius,
                            offset: Offset(0, shadowOffsetY),
                            spreadRadius: shadowSpreadRadius,
                          ),
                        ],
                      ),
                      child: Center( // This Center widget will ensure the gap is visually apparent
                        child: AnimatedBuilder(
                          animation: controller.pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: controller.pulseAnimation.value,
                              child: ClipRRect(
                                // The ClipRRect's radius should be based on the *new* smaller image dimensions
                                borderRadius: BorderRadius.circular(imageWidth / 10), // For circular clip
                                child: Image.asset(
                                  AppAssets.anotherImage,
                                  // AppAssets.heroImagePath,
                                  width: imageWidth,   // Use the new smaller width
                                  height: imageHeight, // Use the new smaller height
                                  fit: BoxFit.cover,
                                  // errorBuilder: (context, error, stackTrace) {
                                  //   return Icon(Icons.error, size: imageWidth, color: Colors.white);
                                  // },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
