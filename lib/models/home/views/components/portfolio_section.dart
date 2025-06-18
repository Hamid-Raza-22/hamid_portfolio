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
        child: _PortfolioItemWithHover(
          itemWidth: itemWidth,
          itemHeight: itemHeight,
          controller: controller,
          context: context,
          index: index,
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

class _PortfolioItemWithHover extends StatefulWidget {
  final double itemWidth;
  final double itemHeight;
  final HomeController controller;
  final BuildContext context;
  final int index;

  const _PortfolioItemWithHover({
    Key? key,
    required this.itemWidth,
    required this.itemHeight,
    required this.controller,
    required this.context,
    required this.index,
  }) : super(key: key);

  @override
  State<_PortfolioItemWithHover> createState() => _PortfolioItemWithHoverState();
}

class _PortfolioItemWithHoverState extends State<_PortfolioItemWithHover>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationXAnimation;
  late Animation<double> _rotationYAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _rotationXAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _rotationYAnimation = Tween<double>(
      begin: 0.0,
      end: 0.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.1,
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    setState(() {
      isHovered = hovering;
    });

    if (hovering) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _hoverController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Perspective
                ..rotateX(_rotationXAnimation.value)
                ..rotateY(_rotationYAnimation.value * (widget.index % 2 == 0 ? 1 : -1)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: widget.itemWidth,
                height: widget.itemHeight,
                decoration: BoxDecoration(
                  color: isHovered
                      ? Colors.grey[750]
                      : Colors.grey[800],
                  borderRadius: BorderRadius.circular(
                      ResponsiveValue.get<double>(context, mobile: 8, desktop: 10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(_glowAnimation.value),
                      blurRadius: ResponsiveValue.get<double>(context, mobile: 15, desktop: 25) * _glowAnimation.value * 2,
                      offset: Offset(0, ResponsiveValue.get<double>(context, mobile: 8, desktop: 12) * _glowAnimation.value),
                      spreadRadius: ResponsiveValue.get<double>(context, mobile: 2, desktop: 4) * _glowAnimation.value,
                    ),
                    if (isHovered)
                      BoxShadow(
                        color: Colors.cyan.withOpacity(0.2),
                        blurRadius: ResponsiveValue.get<double>(context, mobile: 20, desktop: 30),
                        offset: Offset(0, ResponsiveValue.get<double>(context, mobile: 10, desktop: 15)),
                        spreadRadius: ResponsiveValue.get<double>(context, mobile: 1, desktop: 2),
                      ),
                  ],
                  border: isHovered
                      ? Border.all(
                    color: Colors.blue.withOpacity(0.5),
                    width: 2,
                  )
                      : null,
                ),
                child: Stack(
                  children: [
                    // Gradient overlay for 3D effect
                    if (isHovered)
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ResponsiveValue.get<double>(context, mobile: 8, desktop: 10)
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue.withOpacity(0.1),
                              Colors.transparent,
                              Colors.cyan.withOpacity(0.05),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    Center(
                      child: AnimatedBuilder(
                        animation: widget.controller.floatingAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                0,
                                widget.controller.floatingAnimation.value *
                                    ResponsiveValue.get<double>(context, mobile: 0.15, desktop: 0.2)
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                Icons.web, // Placeholder icon
                                color: isHovered
                                    ? Colors.blue[300]
                                    : Colors.grey[600],
                                size: ResponsiveValue.get<double>(
                                    context,
                                    mobile: isHovered ? 35 : 30,
                                    desktop: isHovered ? 45 : 40
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Shimmer effect for hovered state
                    if (isHovered)
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: widget.controller.geometricRotationAnimation,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ResponsiveValue.get<double>(context, mobile: 8, desktop: 10)
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment(-1.0 + (widget.controller.geometricRotationAnimation.value * 4) % 2, 0),
                                  end: Alignment(1.0 + (widget.controller.geometricRotationAnimation.value * 4) % 2, 0),
                                  colors: [
                                    Colors.transparent,
                                    Colors.white.withOpacity(0.1),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}