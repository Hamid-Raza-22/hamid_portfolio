import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../routes/app_routes.dart';
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
    double targetOffset = 0;
    final screenHeight = Get.height;
    
    switch (sectionKey) {
      case 'home':
        targetOffset = 0;
        break;
      case 'services':
        targetOffset = screenHeight * 0.9;
        break;
      case 'portfolio':
      case 'projects':
        targetOffset = screenHeight * 1.8;
        break;
      case 'contact':
        targetOffset = scrollController.position.maxScrollExtent;
        break;
    }
    
    scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  // Navigate to Contact page
  void goToContactPage() {
    Get.toNamed(AppRoutes.contact);
  }

  // Navigate to About page
  void goToAboutPage() {
    Get.toNamed(AppRoutes.about);
  }

  // Navigate to Projects page
  void goToProjectsPage() {
    Get.toNamed(AppRoutes.projects);
  }

  // Launch email
  Future<void> launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'hamidraza.engr@gmail.com',
      queryParameters: {
        'subject': 'Project Inquiry',
        'body': 'Hi Hamid,\n\nI would like to discuss a project with you.',
      },
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  // Launch URL
  Future<void> launchSocialUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void onClose() {
    disposeAnimations();
    scrollController.dispose();
    super.onClose();
  }
}
