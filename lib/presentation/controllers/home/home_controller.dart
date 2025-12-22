import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/stream/stream_usecases.dart';
import '../../routes/app_routes.dart';
import 'home_animation_mixin.dart';

/// HomeController following MVVM pattern.
/// Manages UI state and coordinates between View and Use Cases.
/// Now uses Firebase real-time streams for live updates.
class HomeController extends GetxController
    with GetTickerProviderStateMixin, HomeAnimationMixin {
  // Stream Use Cases (injected dependencies)
  final WatchServicesUseCase _watchServicesUseCase;
  final WatchPortfolioItemsUseCase _watchPortfolioItemsUseCase;
  final WatchSocialLinksUseCase _watchSocialLinksUseCase;
  final WatchStatsUseCase _watchStatsUseCase;
  final WatchNavItemsUseCase _watchNavItemsUseCase;
  final WatchHeroSectionUseCase _watchHeroSectionUseCase;

  HomeController({
    required WatchServicesUseCase watchServicesUseCase,
    required WatchPortfolioItemsUseCase watchPortfolioItemsUseCase,
    required WatchSocialLinksUseCase watchSocialLinksUseCase,
    required WatchStatsUseCase watchStatsUseCase,
    required WatchNavItemsUseCase watchNavItemsUseCase,
    required WatchHeroSectionUseCase watchHeroSectionUseCase,
  })  : _watchServicesUseCase = watchServicesUseCase,
        _watchPortfolioItemsUseCase = watchPortfolioItemsUseCase,
        _watchSocialLinksUseCase = watchSocialLinksUseCase,
        _watchStatsUseCase = watchStatsUseCase,
        _watchNavItemsUseCase = watchNavItemsUseCase,
        _watchHeroSectionUseCase = watchHeroSectionUseCase;

  // Stream subscriptions
  final List<StreamSubscription> _subscriptions = [];

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
  final heroSection = Rxn<HeroSectionEntity>();

  @override
  void onInit() {
    super.onInit();
    initAnimations();
    startAnimations();
    scrollController.addListener(_onScroll);
    _subscribeToStreams();
  }

  void _subscribeToStreams() {
    isLoading.value = true;

    _subscriptions.addAll([
      _watchServicesUseCase().listen(
        (data) {
          services.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching services: $e'),
      ),
      _watchPortfolioItemsUseCase().listen(
        (data) {
          portfolioItems.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching portfolio: $e'),
      ),
      _watchSocialLinksUseCase().listen(
        (data) {
          socialLinks.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching social links: $e'),
      ),
      _watchStatsUseCase().listen(
        (data) {
          stats.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching stats: $e'),
      ),
      _watchNavItemsUseCase().listen(
        (data) {
          navItems.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching nav items: $e'),
      ),
      _watchHeroSectionUseCase().listen(
        (data) {
          debugPrint('🔥 Hero Section Stream received: ${data.name}, imageUrl: ${data.profileImageUrl}');
          heroSection.value = data;
          _checkLoadingComplete();
        },
        onError: (e) => debugPrint('Error watching hero section: $e'),
      ),
    ]);
  }

  void _checkLoadingComplete() {
    if (isLoading.value) {
      isLoading.value = false;
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
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    disposeAnimations();
    scrollController.dispose();
    super.onClose();
  }
}
