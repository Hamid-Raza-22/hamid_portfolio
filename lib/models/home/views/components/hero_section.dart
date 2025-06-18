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

    // Define the gap you want
    const double imageGap = 2.0;

    // Responsive dimensions for the image itself, considering the gap
    final double imageWidth = ResponsiveValue.get<double>(
      context,
      mobile: 180 - (2 * imageGap),
      smallTablet: 210 - (2 * imageGap),
      tablet: 225 - (2 * imageGap),
      desktop: 240 - (2 * imageGap),
    );
    final double imageHeight = ResponsiveValue.get<double>(
      context,
      mobile: 240 - (2 * imageGap),
      smallTablet: 260 - (2 * imageGap),
      tablet: 270 - (2 * imageGap),
      desktop: 300 - (2 * imageGap),
    );

    final double borderRadius = ResponsiveValue.get<double>(
      context,
      mobile: 20,
      desktop: 25,
    );

    return AnimatedBuilder(
      animation: controller.floatingAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            controller.floatingAnimation.value * (isMobileLayout ? 0.7 : 1.0),
          ),
          child: SizedBox(
            width: containerBaseWidth * 2.2, // Increased for better spacing
            height: containerBaseHeight * 2.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background decorative elements positioned more accurately
                _buildBackgroundDecorations(
                  context,
                  containerBaseWidth,
                  containerBaseHeight,
                ),

                // Main image container - positioned slightly forward
                AnimatedBuilder(
                  animation: controller.heroFadeAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: isMobileLayout
                          ? 1.0
                          : controller.heroFadeAnimation.value,
                      child: Container(
                        width: containerBaseWidth,
                        height: containerBaseHeight,
                        decoration: BoxDecoration(
                          // gradient: const LinearGradient(
                          //   colors: [
                          //     Color(0xFFFF8A00), // More vibrant orange
                          //     Color(0xFFFF6B00),
                          //   ],
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.bottomRight,
                          // ),
                          borderRadius: BorderRadius.circular(borderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 25,
                              offset: const Offset(0, 15),
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 40,
                              offset: const Offset(0, 20),
                              spreadRadius: -5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: AnimatedBuilder(
                            animation: controller.pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: controller.pulseAnimation.value,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    borderRadius - 4,

                                  ),
                                  child: Image.asset(
                                    AppAssets.anotherImage,
                                    width: imageWidth,
                                    height: imageHeight,
                                    fit: BoxFit.cover,
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
          ),
        );
      },
    );
  }

  // More accurate background decorations matching the reference
  Widget _buildBackgroundDecorations(
    BuildContext context,
    double containerWidth,
    double containerHeight,
  ) {
    return Stack(
      children: [
        // Large blue background card - positioned behind and to the right
        Positioned(
          top: containerHeight * 0.4,
          left: containerWidth * 0.1, // More to the right
          child: Transform.rotate(
            angle: 0.15, // Slight tilt
            child: Container(
              width: containerWidth * 1.4,
              height: containerHeight * 1.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF1E3A8A).withOpacity(0.8), // Dark blue
                    const Color(0xFF3B82F6).withOpacity(0.2), // Lighter blue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 30,
                    offset: const Offset(10, 15),
                    spreadRadius: -5,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Scattered dots around the design
        ...List.generate(12, (index) {
          final positions = [
            {'top': 0.05, 'left': 0.1},
            {'top': 0.15, 'right': 0.05},
            {'top': 0.25, 'left': 0.02},
            {'top': 0.35, 'right': 0.15},
            {'top': 0.45, 'left': 0.08},
            {'top': 0.55, 'right': 0.03},
            {'bottom': 0.35, 'left': 0.05},
            {'bottom': 0.25, 'right': 0.12},
            {'bottom': 0.15, 'left': 0.15},
            {'bottom': 0.05, 'right': 0.08},
            {'top': 0.08, 'left': 0.8},
            {'bottom': 0.4, 'right': 0.7},
          ];

          final pos = positions[index];
          return Positioned(
            top: pos['top'] != null ? containerHeight * pos['top']! : null,
            bottom: pos['bottom'] != null
                ? containerHeight * pos['bottom']!
                : null,
            left: pos['left'] != null ? containerWidth * pos['left']! : null,
            right: pos['right'] != null ? containerWidth * pos['right']! : null,
            child: Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            ),
          );
        }),

        // Triangle outline - top left area
        Positioned(
          top: containerHeight * 0.15,
          left: containerWidth * 0.2,
          child: CustomPaint(
            size: const Size(35, 35),
            painter: TrianglePainter(color: Colors.white.withOpacity(0.8)),
          ),
        ),

        // Zigzag/Mountain peaks - top center
        Positioned(
          top: containerHeight * 0.08,
          left: containerWidth * 0.55,
          child: CustomPaint(
            size: const Size(45, 25),
            painter: MountainPeaksPainter(color: Colors.white.withOpacity(0.7)),
          ),
        ),

        // Circle outline - top right
        Positioned(
          top: containerHeight * 0.12,
          right: containerWidth * 0.15,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 2.5,
              ),
            ),
          ),
        ),

        // Play button - bottom left
        Positioned(
          bottom: containerHeight * 0.25,
          left: containerWidth * 0.15,
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white.withOpacity(0.8),
              size: 22,
            ),
          ),
        ),

        // Plus sign - bottom right area
        Positioned(
          bottom: containerHeight * 0.15,
          right: containerWidth * 0.1,
          child: CustomPaint(
            size: const Size(25, 25),
            painter: PlusPainter(color: Colors.white.withOpacity(0.7)),
          ),
        ),
      ],
    );
  }
}

// Updated custom painters
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path();
    path.moveTo(size.width / 2, 5);
    path.lineTo(5, size.height - 5);
    path.lineTo(size.width - 5, size.height - 5);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MountainPeaksPainter extends CustomPainter {
  final Color color;

  MountainPeaksPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width * 0.25, size.height * 0.3);
    path.lineTo(size.width * 0.5, size.height * 0.7);
    path.lineTo(size.width * 0.75, size.height * 0.2);
    path.lineTo(size.width, size.height * 0.6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PlusPainter extends CustomPainter {
  final Color color;

  PlusPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Horizontal line
    canvas.drawLine(
      Offset(5, size.height / 2),
      Offset(size.width - 5, size.height / 2),
      paint,
    );

    // Vertical line
    canvas.drawLine(
      Offset(size.width / 2, 5),
      Offset(size.width / 2, size.height - 5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
