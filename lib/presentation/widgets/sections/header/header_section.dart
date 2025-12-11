import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../controllers/home/home_controller.dart';
import '../../common/common_widgets.dart';

/// Header section with responsive desktop/mobile layouts.
class HeaderSection extends GetView<HomeController> {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _MobileHeader(controller: controller),
      desktop: _DesktopHeader(controller: controller),
    );
  }
}

class _DesktopHeader extends StatelessWidget {
  final HomeController controller;

  const _DesktopHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -30 * (1 - controller.heroFadeAnimation.value)),
          child: Opacity(
            opacity: controller.heroFadeAnimation.value,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: GlassContainer(
                borderRadius: 20,
                blurSigma: 20,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.1),
                    blurRadius: 40,
                    spreadRadius: -10,
                  ),
                ],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLogo(),
                    _buildNavigation(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        AnimatedBuilder(
          animation: controller.pulseAnimation,
          builder: (context, child) {
            return Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.5),
                    blurRadius: 15 * controller.pulseAnimation.value,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'H',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 14),
        const GradientText(
          text: 'Hamid Raza',
          colors: [Colors.white, AppColors.primaryLight],
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  void _handleNavTap(String navItem) {
    switch (navItem) {
      case 'About':
        controller.goToAboutPage();
        break;
      case 'Contact':
        controller.goToContactPage();
        break;
      default:
        controller.scrollToSection(navItem.toLowerCase());
    }
  }

  Widget _buildNavigation() {
    return Row(
      children: [
        ...['Home', 'Services', 'Projects', 'About', 'Contact'].asMap().entries.map(
          (entry) => AnimatedBuilder(
            animation: controller.heroFadeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, -40 * (1 - controller.heroFadeAnimation.value)),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 400 + (entry.key * 150)),
                  opacity: controller.heroFadeAnimation.value,
                  child: NavItem(
                    text: entry.value,
                    onTap: () => _handleNavTap(entry.value),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 20),
        AnimatedBuilder(
          animation: controller.heroFadeAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: controller.heroFadeAnimation.value,
              child: const _ContactButton(),
            );
          },
        ),
      ],
    );
  }
}

class _ContactButton extends GetView<HomeController> {
  const _ContactButton();

  @override
  Widget build(BuildContext context) {
    return HoverContainer(
      onTap: () => controller.goToContactPage(),
      builder: (isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isHovered
                  ? AppColors.primaryGradient
                  : [AppColors.primary.withOpacity(0.2), AppColors.accentPurple.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isHovered ? Colors.transparent : AppColors.primary.withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      spreadRadius: 0,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Contact',
                style: TextStyle(
                  color: isHovered ? Colors.white : AppColors.primaryLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(isHovered ? 4 : 0, 0, 0),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: isHovered ? Colors.white : AppColors.primaryLight,
                  size: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MobileHeader extends StatelessWidget {
  final HomeController controller;

  const _MobileHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          AnimatedBuilder(
            animation: controller.pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: controller.pulseAnimation.value,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    gradient: const RadialGradient(
                      colors: [Colors.blue, Colors.cyan],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.6),
                        blurRadius: 15 * controller.pulseAnimation.value,
                        spreadRadius: 3 * controller.pulseAnimation.value,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          const Text('Hamid Raza'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _showMobileMenu(),
        ),
      ],
    );
  }

  void _showMobileMenu() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileNavItem('Home', 'home', isPage: false),
            _buildMobileNavItem('Services', 'services', isPage: false),
            _buildMobileNavItem('Projects', 'portfolio', isPage: false),
            _buildMobileNavItem('About', 'about', isPage: true),
            _buildMobileNavItem('Contact', 'contact', isPage: true),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String text, String sectionKey, {bool isPage = false}) {
    return ListTile(
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Get.back();
        if (isPage) {
          if (sectionKey == 'contact') {
            controller.goToContactPage();
          } else if (sectionKey == 'about') {
            controller.goToAboutPage();
          }
        } else {
          controller.scrollToSection(sectionKey);
        }
      },
    );
  }
}
