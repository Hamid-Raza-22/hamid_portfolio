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
  late AnimationController galaxyAnimationController; // New galaxy controller
  late AnimationController portfolioHoverController; // New hover controller

  // Animations
  late Animation<double> heroFadeAnimation;
  late Animation<Offset> heroSlideAnimation;
  late Animation<double> servicesScaleAnimation;
  late Animation<double> portfolioRotationAnimation;
  late Animation<double> geometricRotationAnimation;
  late Animation<double> floatingAnimation;
  late Animation<double> pulseAnimation;
  late Animation<double> backgroundAnimation;
  late Animation<double> galaxyRotationAnimation; // New galaxy animation
  late Animation<double> portfolioHoverAnimation; // New hover animation

  // Scroll Controller
  final ScrollController scrollController = ScrollController();

  // Observables
  final isServicesVisible = false.obs;
  final isPortfolioVisible = false.obs;
  final hoveredPortfolioIndex = (-1).obs; // Track which portfolio item is hovered

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

    // Portfolio hover animations
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

    // Galaxy animation controller
    galaxyAnimationController = AnimationController(
      duration: const Duration(milliseconds: 20000), // Slow rotation for galaxy
      vsync: this,
    );

    galaxyRotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: galaxyAnimationController,
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
    galaxyAnimationController.repeat(); // Start galaxy animation
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

  // Portfolio hover methods
  void setPortfolioHover(int index, bool isHovered) {
    hoveredPortfolioIndex.value = isHovered ? index : -1;
    if (isHovered) {
      portfolioHoverController.forward();
    } else {
      portfolioHoverController.reverse();
    }
  }

  bool isPortfolioItemHovered(int index) {
    return hoveredPortfolioIndex.value == index;
  }

  @override
  void onClose() {
    heroAnimationController.dispose();
    servicesAnimationController.dispose();
    portfolioAnimationController.dispose();
    geometricAnimationController.dispose();
    galaxyAnimationController.dispose(); // Dispose galaxy controller
    floatingAnimationController.dispose();
    backgroundAnimationController.dispose();
    portfolioHoverController.dispose(); // Dispose hover controller
    scrollController.dispose();
    super.onClose();
  }
}