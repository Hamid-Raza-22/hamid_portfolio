import 'package:flutter/material.dart';

// Create a responsive_constants.dart file
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}

// Create a responsive_layout.dart file
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= ResponsiveBreakpoints.desktop) {
      return desktop;
    }
    else if (width >= ResponsiveBreakpoints.tablet && tablet != null) {
      return tablet!;
    }
    else {
      return mobile;
    }
  }
}