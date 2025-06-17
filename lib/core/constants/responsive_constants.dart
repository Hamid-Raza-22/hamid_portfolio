import 'package:flutter/material.dart';

// responsive_constants.dart

class ResponsiveBreakpoints {
  static const double smallMobile = 360;
  static const double mobile = 600;
  static const double smallTablet = 768;
  static const double tablet = 900;
  static const double desktop = 1200;
}

class ResponsiveValue {
  static T get<T>(BuildContext context, {
    required T mobile,
    T? smallTablet,
    T? tablet,
    required T desktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width >= ResponsiveBreakpoints.desktop) {
      return desktop;
    } else if (width >= ResponsiveBreakpoints.tablet && tablet != null) {
      return tablet;
    } else if (width >= ResponsiveBreakpoints.smallTablet && smallTablet != null) {
      return smallTablet;
    } else {
      return mobile;
    }
  }
}

class ResponsivePadding {
  static EdgeInsets all(BuildContext context, {double multiplier = 1.0}) {
    final value = ResponsiveValue.get<double>(
      context, // Ensure context is passed here
      mobile: 16 * multiplier,
      smallTablet: 24 * multiplier,
      tablet: 32 * multiplier,
      desktop: 40 * multiplier,
    );
    return EdgeInsets.all(value);
  }

  static EdgeInsets symmetric({
    required BuildContext context, // Keep context as a required named parameter
    double horizontalMultiplier = 1.0, // Use multipliers for clarity
    double verticalMultiplier = 1.0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: ResponsiveValue.get<double>(
        context,
        mobile: 16 * horizontalMultiplier,
        smallTablet: 24 * horizontalMultiplier,
        tablet: 32 * horizontalMultiplier,
        desktop: 40 * horizontalMultiplier,
      ),
      vertical: ResponsiveValue.get<double>(
        context,
        mobile: 16 * verticalMultiplier,
        smallTablet: 24 * verticalMultiplier,
        tablet: 32 * verticalMultiplier,
        desktop: 40 * verticalMultiplier,
      ),
    );
  }

  // Example for only horizontal or vertical padding
  static EdgeInsets horizontal(BuildContext context, {double multiplier = 1.0}) {
    final value = ResponsiveValue.get<double>(
      context,
      mobile: 16 * multiplier,
      smallTablet: 24 * multiplier,
      tablet: 32 * multiplier,
      desktop: 40 * multiplier,
    );
    return EdgeInsets.symmetric(horizontal: value);
  }

  static EdgeInsets vertical(BuildContext context, {double multiplier = 1.0}) {
    final value = ResponsiveValue.get<double>(
      context,
      mobile: 16 * multiplier,
      smallTablet: 24 * multiplier,
      tablet: 32 * multiplier,
      desktop: 40 * multiplier,
    );
    return EdgeInsets.symmetric(vertical: value);
  }

  // Example for different padding on each side (L, T, R, B)
  static EdgeInsets only(
      BuildContext context, {
        double leftMultiplier = 0,
        double topMultiplier = 0,
        double rightMultiplier = 0,
        double bottomMultiplier = 0,
      }) {
    return EdgeInsets.only(
      left: ResponsiveValue.get<double>(
        context,
        mobile: 16 * leftMultiplier,
        smallTablet: 24 * leftMultiplier,
        tablet: 32 * leftMultiplier,
        desktop: 40 * leftMultiplier,
      ),
      top: ResponsiveValue.get<double>(
        context,
        mobile: 16 * topMultiplier,
        smallTablet: 24 * topMultiplier,
        tablet: 32 * topMultiplier,
        desktop: 40 * topMultiplier,
      ),
      right: ResponsiveValue.get<double>(
        context,
        mobile: 16 * rightMultiplier,
        smallTablet: 24 * rightMultiplier,
        tablet: 32 * rightMultiplier,
        desktop: 40 * rightMultiplier,
      ),
      bottom: ResponsiveValue.get<double>(
        context,
        mobile: 16 * bottomMultiplier,
        smallTablet: 24 * bottomMultiplier,
        tablet: 32 * bottomMultiplier,
        desktop: 40 * bottomMultiplier,
      ),
    );
  }
}

// You can keep ResponsiveTextStyle and ResponsiveLayout as they were
// or adapt them similarly if needed.

class ResponsiveTextStyle {
  static TextStyle headline(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveValue.get<double>(
        context,
        mobile: 24,
        smallTablet: 28,
        tablet: 32,
        desktop: 38,
      ),
      fontWeight: FontWeight.bold,
      color: Colors.white, // Example color
    );
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveValue.get<double>(
        context,
        mobile: 14,
        smallTablet: 15,
        tablet: 16,
        desktop: 17,
      ),
      color: Colors.grey[300], // Example color
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? smallTablet;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.smallTablet,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= ResponsiveBreakpoints.desktop) {
      return desktop;
    } else if (width >= ResponsiveBreakpoints.tablet && tablet != null) {
      return tablet!;
    } else if (width >= ResponsiveBreakpoints.smallTablet && smallTablet != null) {
      return smallTablet!;
    } else {
      return mobile;
    }
  }
}