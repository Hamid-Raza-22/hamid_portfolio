import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/portfolio_repository.dart';
import '../../../data/models/project_model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  // Repository
  final PortfolioRepository _repository = Get.find<PortfolioRepository>();

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

  // Track scroll offset for animations
  double _lastScrollOffset = 0.0;

  // Observables
  final isServicesVisible = false.obs;
  final isPortfolioVisible = false.obs;
  final hoveredPortfolioIndex = (-1).obs;
  final isLoading = false.obs;
  final featuredProjects = <ProjectModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initAnimations();
    _startAnimations();
    _loadFeaturedProjects();
  }

  void _initAnimations() {
    // Hero animations (1000ms for better performance)
    heroAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    heroFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: heroAnimationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
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
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    servicesScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: servicesAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Portfolio animations
    portfolioAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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

    // Geometric shapes animations (optimized for 60fps)
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
      duration: const Duration(milliseconds: 20000),
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
      duration: const Duration(milliseconds: 3000), // Reduced for performance
      vsync: this,
    );

    floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(
        parent: floatingAnimationController,
        curve: Curves.easeInOutSine,
      ),
    );

    pulseAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
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
    Future.delayed(const Duration(milliseconds: 100), () {
      heroAnimationController.forward();
    });

    geometricAnimationController.repeat();
    galaxyAnimationController.repeat();
    floatingAnimationController.repeat(reverse: true);
    backgroundAnimationController.repeat(reverse: true);
  }

  // Handle scroll updates from NotificationListener
  void onScrollUpdate(double offset) {
    _lastScrollOffset = offset;
    
    final renderBox = Get.context?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final size = renderBox.size;

      if (offset > size.height * 0.3 && !isServicesVisible.value) {
        isServicesVisible.value = true;
        servicesAnimationController.forward();
      }

      if (offset > size.height * 0.8 && !isPortfolioVisible.value) {
        isPortfolioVisible.value = true;
        portfolioAnimationController.forward();
      }
    }
  }

  // Load featured projects from repository
  Future<void> _loadFeaturedProjects() async {
    try {
      isLoading.value = true;
      final projects = await _repository.getFeaturedProjects();
      featuredProjects.value = projects;
    } catch (e) {
      debugPrint('Error loading featured projects: $e');
    } finally {
      isLoading.value = false;
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

  // Navigation methods
  void navigateToAbout() => Get.toNamed('/about');
  void navigateToSkills() => Get.toNamed('/skills');
  void navigateToProjects() => Get.toNamed('/projects');
  void navigateToContact() => Get.toNamed('/contact');

  @override
  void onClose() {
    // Dispose all animation controllers
    heroAnimationController.dispose();
    servicesAnimationController.dispose();
    portfolioAnimationController.dispose();
    geometricAnimationController.dispose();
    galaxyAnimationController.dispose();
    floatingAnimationController.dispose();
    backgroundAnimationController.dispose();
    portfolioHoverController.dispose();
    
    super.onClose();
  }
}
