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
        ...['Home', 'Services', 'Projects', 'About'].asMap().entries.map(
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
      _MobileMenuSheet(controller: controller),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );
  }
}

/// Modern mobile menu bottom sheet with animations
class _MobileMenuSheet extends StatefulWidget {
  final HomeController controller;

  const _MobileMenuSheet({required this.controller});

  @override
  State<_MobileMenuSheet> createState() => _MobileMenuSheetState();
}

class _MobileMenuSheetState extends State<_MobileMenuSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late List<Animation<double>> _itemAnimations;

  static const _menuItems = [
    {'text': 'Home', 'key': 'home', 'icon': Icons.home_rounded, 'isPage': false},
    {'text': 'Services', 'key': 'services', 'icon': Icons.design_services_rounded, 'isPage': false},
    {'text': 'Projects', 'key': 'portfolio', 'icon': Icons.work_rounded, 'isPage': false},
    {'text': 'About', 'key': 'about', 'icon': Icons.person_rounded, 'isPage': true},
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _itemAnimations = List.generate(_menuItems.length, (index) {
      final start = index * 0.1;
      final end = start + 0.6;
      return CurvedAnimation(
        parent: _animController,
        curve: Interval(start.clamp(0.0, 1.0), end.clamp(0.0, 1.0), curve: Curves.easeOutCubic),
      );
    });

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleNavTap(String sectionKey, bool isPage) {
    Get.back();
    if (isPage) {
      if (sectionKey == 'contact') {
        widget.controller.goToContactPage();
      } else if (sectionKey == 'about') {
        widget.controller.goToAboutPage();
      }
    } else {
      widget.controller.scrollToSection(sectionKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF1A1A2E).withOpacity(0.95),
                const Color(0xFF0F0F1A).withOpacity(0.98),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag handle
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  // Menu items
                  ...List.generate(_menuItems.length, (index) {
                    final item = _menuItems[index];
                    return AnimatedBuilder(
                      animation: _itemAnimations[index],
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 20 * (1 - _itemAnimations[index].value)),
                          child: Opacity(
                            opacity: _itemAnimations[index].value,
                            child: _buildMenuItem(
                              text: item['text'] as String,
                              icon: item['icon'] as IconData,
                              onTap: () => _handleNavTap(
                                item['key'] as String,
                                item['isPage'] as bool,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),

                  const SizedBox(height: 16),

                  // CTA Button
                  AnimatedBuilder(
                    animation: _animController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animController.value,
                        child: Opacity(
                          opacity: _animController.value,
                          child: _buildContactCTA(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: AppColors.primary.withOpacity(0.1),
          highlightColor: AppColors.primary.withOpacity(0.05),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.15),
                        AppColors.accentPurple.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primaryLight,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white.withOpacity(0.3),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCTA() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.back();
          widget.controller.goToContactPage();
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get In Touch',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
