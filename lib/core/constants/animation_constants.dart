import 'package:flutter/material.dart';

/// Animation duration constants for consistent timing across the app
class AnimationDurations {
  // Fast animations (interactions)
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 600);
  
  // Page transitions
  static const Duration pageTransition = Duration(milliseconds: 400);
  static const Duration modalTransition = Duration(milliseconds: 300);
  
  // UI element animations
  static const Duration buttonHover = Duration(milliseconds: 200);
  static const Duration cardHover = Duration(milliseconds: 300);
  static const Duration fadeIn = Duration(milliseconds: 600);
  static const Duration slideIn = Duration(milliseconds: 500);
  
  // Background animations (continuous)
  static const Duration backgroundSlow = Duration(milliseconds: 10000);
  static const Duration backgroundMedium = Duration(milliseconds: 8000);
  static const Duration floating = Duration(milliseconds: 3000);
  static const Duration rotation = Duration(milliseconds: 8000);
  
  // Loading states
  static const Duration shimmer = Duration(milliseconds: 1500);
  static const Duration skeleton = Duration(milliseconds: 1200);
}

/// Animation curve constants for consistent easing
class AnimationCurves {
  // Standard curves
  static const Curve standard = Curves.easeInOut;
  static const Curve emphasized = Curves.easeOutCubic;
  static const Curve decelerated = Curves.easeOut;
  static const Curve accelerated = Curves.easeIn;
  
  // Special effects
  static const Curve bounce = Curves.elasticOut;
  static const Curve spring = Curves.easeOutBack;
  static const Curve smooth = Curves.easeInOutCubic;
  
  // Custom curves for specific use cases
  static const Curve cardEntry = Curves.easeOutCubic;
  static const Curve buttonPress = Curves.easeOut;
  static const Curve fadeTransition = Curves.easeOut;
}

/// Animation offset constants
class AnimationOffsets {
  static const double slideDistanceSmall = 30.0;
  static const double slideDistanceMedium = 50.0;
  static const double slideDistanceLarge = 80.0;
  
  static const double scaleMin = 0.8;
  static const double scaleNormal = 1.0;
  static const double scaleHover = 1.05;
  static const double scalePressed = 0.95;
  
  static const double rotationSmall = 0.05; // radians
  static const double rotationMedium = 0.1;
}

/// Stagger delays for list animations
class StaggerDelays {
  static Duration delay(int index, {int baseMilliseconds = 50}) {
    return Duration(milliseconds: baseMilliseconds * index);
  }
  
  static const Duration short = Duration(milliseconds: 50);
  static const Duration medium = Duration(milliseconds: 100);
  static const Duration long = Duration(milliseconds: 150);
}
