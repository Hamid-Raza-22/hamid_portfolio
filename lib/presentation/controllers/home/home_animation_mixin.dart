import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Mixin containing all animation-related logic for HomeController.
/// Follows Single Responsibility Principle by separating animation concerns.
mixin HomeAnimationMixin on GetxController, GetTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController heroAnimationController;
  late AnimationController servicesAnimationController;
  late AnimationController portfolioAnimationController;
  late AnimationController geometricAnimationController;
  late AnimationController floatingAnimationController;
  late AnimationController backgroundAnimationController;
  late AnimationController galaxyAnimationController;
  late AnimationController portfolioHoverController;

  // Animations
  late Animation<double> heroFadeAnimation;
  late Animation<Offset> heroSlideAnimation;
  late Animation<double> servicesScaleAnimation;
  late Animation<double> portfolioRotationAnimation;
  late Animation<double> geometricRotationAnimation;
  late Animation<double> floatingAnimation;
  late Animation<double> pulseAnimation;
  late Animation<double> backgroundAnimation;
  late Animation<double> galaxyRotationAnimation;
  late Animation<double> portfolioHoverAnimation;

  void initAnimations() {
    _initHeroAnimations();
    _initServicesAnimations();
    _initPortfolioAnimations();
    _initGeometricAnimations();
    _initGalaxyAnimations();
    _initFloatingAnimations();
    _initBackgroundAnimations();
  }

  void _initHeroAnimations() {
    heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    heroFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: heroAnimationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutExpo),
      ),
    );

    heroSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: heroAnimationController,
      curve: Curves.easeOutCubic,
    ));
  }

  void _initServicesAnimations() {
    servicesAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    servicesScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: servicesAnimationController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  void _initPortfolioAnimations() {
    portfolioAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    portfolioRotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: portfolioAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    portfolioHoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    portfolioHoverAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: portfolioHoverController,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  void _initGeometricAnimations() {
    geometricAnimationController = AnimationController(
      duration: const Duration(milliseconds: 8000),
      vsync: this,
    );

    geometricRotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: geometricAnimationController,
        curve: Curves.linear,
      ),
    );
  }

  void _initGalaxyAnimations() {
    galaxyAnimationController = AnimationController(
      duration: const Duration(milliseconds: 20000),
      vsync: this,
    );

    galaxyRotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: galaxyAnimationController,
        curve: Curves.linear,
      ),
    );
  }

  void _initFloatingAnimations() {
    floatingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    );

    floatingAnimation = Tween<double>(begin: -15.0, end: 15.0).animate(
      CurvedAnimation(
        parent: floatingAnimationController,
        curve: Curves.easeInOutSine,
      ),
    );

    pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
        parent: floatingAnimationController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  void _initBackgroundAnimations() {
    backgroundAnimationController = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    );

    backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: backgroundAnimationController,
        curve: Curves.linear,
      ),
    );
  }

  void startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      heroAnimationController.forward();
    });

    geometricAnimationController.repeat();
    galaxyAnimationController.repeat();
    floatingAnimationController.repeat(reverse: true);
    backgroundAnimationController.repeat(reverse: true);
  }

  void disposeAnimations() {
    heroAnimationController.dispose();
    servicesAnimationController.dispose();
    portfolioAnimationController.dispose();
    geometricAnimationController.dispose();
    galaxyAnimationController.dispose();
    floatingAnimationController.dispose();
    backgroundAnimationController.dispose();
    portfolioHoverController.dispose();
  }
}
