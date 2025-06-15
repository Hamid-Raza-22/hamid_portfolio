import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetTickerProviderStateMixin {
  // Animation Controllers
  late AnimationController heroAnimationController;
  late AnimationController servicesAnimationController;
  late AnimationController portfolioAnimationController;
  late AnimationController geometricAnimationController;
  late AnimationController floatingAnimationController;
  late AnimationController backgroundAnimationController;

  // Animations
  late Animation<double> heroFadeAnimation;
  late Animation<Offset> heroSlideAnimation;
  late Animation<double> servicesScaleAnimation;
  late Animation<double> portfolioRotationAnimation;
  late Animation<double> geometricRotationAnimation;
  late Animation<double> floatingAnimation;
  late Animation<double> pulseAnimation;
  late Animation<double> backgroundAnimation;

  // Scroll Controller
  final ScrollController scrollController = ScrollController();

  // Observables
  final isServicesVisible = false.obs;
  final isPortfolioVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initAnimations();
    _startAnimations();
    scrollController.addListener(_onScroll);
  }

  void _initAnimations() {
    // Hero animations
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

    // Services animations
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

    // Portfolio animations
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

    // Geometric shapes animations
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

    // Floating animations
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

    // Background animation
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

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      heroAnimationController.forward();
    });

    geometricAnimationController.repeat();
    floatingAnimationController.repeat(reverse: true);
    backgroundAnimationController.repeat(reverse: true);
  }

  void _onScroll() {
    final renderBox = Get.context?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final size = renderBox.size;
      final offset = scrollController.offset;

      if (offset > size.height * 0.4 && !isServicesVisible.value) {
        isServicesVisible.value = true;
        servicesAnimationController.forward();
      }

      if (offset > size.height * 1.0 && !isPortfolioVisible.value) {
        isPortfolioVisible.value = true;
        portfolioAnimationController.forward();
      }
    }
  }

  @override
  void onClose() {
    heroAnimationController.dispose();
    servicesAnimationController.dispose();
    portfolioAnimationController.dispose();
    geometricAnimationController.dispose();
    floatingAnimationController.dispose();
    backgroundAnimationController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}