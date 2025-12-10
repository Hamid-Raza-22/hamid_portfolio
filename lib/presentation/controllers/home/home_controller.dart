import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import 'home_animation_mixin.dart';

/// HomeController following MVVM pattern.
/// Manages UI state and coordinates between View and Use Cases.
class HomeController extends GetxController
    with GetTickerProviderStateMixin, HomeAnimationMixin {
  // Use Cases (injected dependencies)
  final GetServicesUseCase _getServicesUseCase;
  final GetPortfolioItemsUseCase _getPortfolioItemsUseCase;
  final GetSocialLinksUseCase _getSocialLinksUseCase;
  final GetStatsUseCase _getStatsUseCase;
  final GetNavItemsUseCase _getNavItemsUseCase;

  HomeController({
    required GetServicesUseCase getServicesUseCase,
    required GetPortfolioItemsUseCase getPortfolioItemsUseCase,
    required GetSocialLinksUseCase getSocialLinksUseCase,
    required GetStatsUseCase getStatsUseCase,
    required GetNavItemsUseCase getNavItemsUseCase,
  })  : _getServicesUseCase = getServicesUseCase,
        _getPortfolioItemsUseCase = getPortfolioItemsUseCase,
        _getSocialLinksUseCase = getSocialLinksUseCase,
        _getStatsUseCase = getStatsUseCase,
        _getNavItemsUseCase = getNavItemsUseCase;

  // Scroll Controller
  final ScrollController scrollController = ScrollController();

  // Observable State
  final isLoading = true.obs;
  final isServicesVisible = false.obs;
  final isPortfolioVisible = false.obs;
  final hoveredPortfolioIndex = (-1).obs;

  // Data State
  final services = <ServiceEntity>[].obs;
  final portfolioItems = <PortfolioEntity>[].obs;
  final socialLinks = <SocialLinkEntity>[].obs;
  final stats = <StatEntity>[].obs;
  final navItems = <NavItemEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    initAnimations();
    startAnimations();
    scrollController.addListener(_onScroll);
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      isLoading.value = true;

      // Load all data in parallel
      final results = await Future.wait([
        _getServicesUseCase(),
        _getPortfolioItemsUseCase(),
        _getSocialLinksUseCase(),
        _getStatsUseCase(),
        _getNavItemsUseCase(),
      ]);

      services.value = results[0] as List<ServiceEntity>;
      portfolioItems.value = results[1] as List<PortfolioEntity>;
      socialLinks.value = results[2] as List<SocialLinkEntity>;
      stats.value = results[3] as List<StatEntity>;
      navItems.value = results[4] as List<NavItemEntity>;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      debugPrint('Error loading data: $e');
    }
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

  // Navigation methods
  void scrollToSection(String sectionKey) {
    // Implementation for section navigation
    // Can be extended to use GlobalKeys for each section
  }

  @override
  void onClose() {
    disposeAnimations();
    scrollController.dispose();
    super.onClose();
  }
}
