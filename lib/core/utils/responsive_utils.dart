import 'package:flutter/material.dart';

/// Enhanced responsive utilities for all screen sizes
class ResponsiveUtils {
  // Screen breakpoints
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 900;
  static const double desktopMaxWidth = 1200;
  static const double ultraWideMinWidth = 1920;

  // Get screen type
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width >= ultraWideMinWidth) {
      return ScreenType.ultraWide;
    } else if (width >= desktopMaxWidth) {
      return ScreenType.desktop;
    } else if (width >= tabletMaxWidth) {
      return ScreenType.tablet;
    } else if (width >= mobileMaxWidth) {
      return ScreenType.smallTablet;
    } else {
      return ScreenType.mobile;
    }
  }

  // Check screen type
  static bool isMobile(BuildContext context) => 
      MediaQuery.of(context).size.width < mobileMaxWidth;
  
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileMaxWidth && width < desktopMaxWidth;
  }
  
  static bool isDesktop(BuildContext context) => 
      MediaQuery.of(context).size.width >= desktopMaxWidth;
  
  static bool isUltraWide(BuildContext context) => 
      MediaQuery.of(context).size.width >= ultraWideMinWidth;

  // Get responsive value based on screen size
  static T responsive<T>({
    required BuildContext context,
    required T mobile,
    T? smallTablet,
    T? tablet,
    T? desktop,
    T? ultraWide,
  }) {
    final screenType = getScreenType(context);
    
    switch (screenType) {
      case ScreenType.ultraWide:
        return ultraWide ?? desktop ?? tablet ?? smallTablet ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? smallTablet ?? mobile;
      case ScreenType.tablet:
        return tablet ?? smallTablet ?? mobile;
      case ScreenType.smallTablet:
        return smallTablet ?? mobile;
      case ScreenType.mobile:
        return mobile;
    }
  }

  // Get responsive padding
  static EdgeInsets responsivePadding(BuildContext context, {
    double mobileMultiplier = 1.0,
    double tabletMultiplier = 1.5,
    double desktopMultiplier = 2.0,
  }) {
    final baseSize = responsive<double>(
      context: context,
      mobile: 16.0 * mobileMultiplier,
      tablet: 24.0 * tabletMultiplier,
      desktop: 32.0 * desktopMultiplier,
      ultraWide: 40.0 * desktopMultiplier,
    );
    
    return EdgeInsets.all(baseSize);
  }

  // Get responsive font size
  static double responsiveFontSize(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    double? ultraWide,
  }) {
    return responsive<double>(
      context: context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      desktop: desktop ?? mobile * 1.4,
      ultraWide: ultraWide ?? mobile * 1.6,
    );
  }

  // Get max content width for centered layouts
  static double getMaxContentWidth(BuildContext context) {
    return responsive<double>(
      context: context,
      mobile: double.infinity,
      tablet: 800,
      desktop: 1200,
      ultraWide: 1600,
    );
  }

  // Get grid column count
  static int getGridColumnCount(BuildContext context, {
    int mobile = 1,
    int? tablet,
    int? desktop,
    int? ultraWide,
  }) {
    return responsive<int>(
      context: context,
      mobile: mobile,
      tablet: tablet ?? 2,
      desktop: desktop ?? 3,
      ultraWide: ultraWide ?? 4,
    );
  }

  // Get spacing
  static double getSpacing(BuildContext context, {
    double multiplier = 1.0,
  }) {
    return responsive<double>(
      context: context,
      mobile: 16.0 * multiplier,
      tablet: 24.0 * multiplier,
      desktop: 32.0 * multiplier,
      ultraWide: 40.0 * multiplier,
    );
  }

  // Get icon size
  static double getIconSize(BuildContext context, {
    double baseSize = 24.0,
  }) {
    return responsive<double>(
      context: context,
      mobile: baseSize,
      tablet: baseSize * 1.2,
      desktop: baseSize * 1.4,
      ultraWide: baseSize * 1.6,
    );
  }
}

enum ScreenType {
  mobile,
  smallTablet,
  tablet,
  desktop,
  ultraWide,
}

/// Responsive builder widget
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenType screenType) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = ResponsiveUtils.getScreenType(context);
    return builder(context, screenType);
  }
}

/// Layout builder for different screen configurations
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? smallTablet;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? ultraWide;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.smallTablet,
    this.tablet,
    this.desktop,
    this.ultraWide,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenType) {
        switch (screenType) {
          case ScreenType.ultraWide:
            return ultraWide ?? desktop ?? tablet ?? smallTablet ?? mobile;
          case ScreenType.desktop:
            return desktop ?? tablet ?? smallTablet ?? mobile;
          case ScreenType.tablet:
            return tablet ?? smallTablet ?? mobile;
          case ScreenType.smallTablet:
            return smallTablet ?? mobile;
          case ScreenType.mobile:
            return mobile;
        }
      },
    );
  }
}
