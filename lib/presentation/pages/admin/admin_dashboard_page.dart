import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../controllers/admin/admin_dashboard_controller.dart';
import '../../controllers/admin/auth_controller.dart';
import '../../widgets/admin/admin_widgets.dart';

/// Responsive breakpoints for Admin Portal.
class _Breakpoints {
  static const double tablet = 600;
  static const double desktop = 900;
}

/// Admin Dashboard Page with category-based content management.
class AdminDashboardPage extends GetView<AdminDashboardController> {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isDesktop = width >= _Breakpoints.desktop;
        final isTablet = width >= _Breakpoints.tablet;

        return Scaffold(
          backgroundColor: const Color(0xFF0F172A),
          appBar: _buildAppBar(),
          drawer: isTablet ? null : _buildDrawer(),
          body: Row(
            children: [
              if (isDesktop)
                _buildSidebar()
              else if (isTablet)
                _buildNavigationRail(),
              Expanded(child: _buildContent()),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF1E293B),
      elevation: 0,
      title: const Text(
        'Admin Dashboard',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Obx(() {
          if (controller.isSeedingData.value) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }
          return PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: const Color(0xFF1E293B),
            onSelected: (value) {
              if (value == 'seed') {
                _showSeedConfirmDialog();
              } else if (value == 'logout') {
                Get.find<AuthController>().signOut();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'seed',
                child: Row(
                  children: [
                    Icon(Icons.cloud_upload, color: Colors.white70, size: 20),
                    SizedBox(width: 12),
                    Text('Seed Initial Data', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red, size: 20),
                    SizedBox(width: 12),
                    Text('Logout', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  void _showSeedConfirmDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text(
          'Seed Initial Data?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This will upload all default portfolio data to Firebase. '
          'Existing data with the same IDs will be overwritten.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.seedInitialData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Seed Data'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF1E293B),
      child: _buildCategoryList(closeOnSelect: true),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 240,
      color: const Color(0xFF1E293B),
      child: _buildCategoryList(),
    );
  }

  Widget _buildNavigationRail() {
    return Obx(() {
      final selectedIndex = controller.selectedCategory.value;
      return NavigationRail(
        backgroundColor: const Color(0xFF1E293B),
        selectedIndex: selectedIndex,
        extended: false,
        minWidth: 72,
        labelType: NavigationRailLabelType.selected,
        selectedIconTheme: const IconThemeData(color: AppColors.primary, size: 24),
        unselectedIconTheme: const IconThemeData(color: Colors.white70, size: 22),
        selectedLabelTextStyle: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelTextStyle: const TextStyle(color: Colors.white70, fontSize: 10),
        onDestinationSelected: controller.selectCategory,
        destinations: controller.categories
            .map((cat) => NavigationRailDestination(
                  icon: Icon(cat['icon'] as IconData),
                  label: Text(cat['title'] as String),
                ))
            .toList(growable: false),
      );
    });
  }

  Widget _buildCategoryList({bool closeOnSelect = false}) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'CATEGORIES',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        ...List.generate(
          controller.categories.length,
          (index) => Obx(() => _buildCategoryTile(index, closeOnSelect)),
        ),
      ],
    );
  }

  Widget _buildCategoryTile(int index, bool closeOnSelect) {
    final category = controller.categories[index];
    final isSelected = controller.selectedCategory.value == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isSelected
            ? Border.all(color: AppColors.primary.withOpacity(0.3))
            : null,
      ),
      child: ListTile(
        leading: Icon(
          category['icon'] as IconData,
          color: isSelected ? AppColors.primary : Colors.white70,
          size: 22,
        ),
        title: Text(
          category['title'] as String,
          style: TextStyle(
            color: isSelected ? AppColors.primary : Colors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () {
          controller.selectCategory(index);
          if (closeOnSelect) Get.back();
        },
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Obx(() {
      switch (controller.selectedCategory.value) {
        case 0:
          return HeroSectionManagement(controller: controller);
        case 1:
          return ProfileManagement(controller: controller);
        case 2:
          return ServicesManagement(controller: controller);
        case 3:
          return PortfolioManagement(controller: controller);
        case 4:
          return ProjectsManagement(controller: controller);
        case 5:
          return ExperienceManagement(controller: controller);
        case 6:
          return EducationManagement(controller: controller);
        case 7:
          return CertificationsManagement(controller: controller);
        case 8:
          return ExpertiseManagement(controller: controller);
        case 9:
          return AchievementsManagement(controller: controller);
        case 10:
          return ContactManagement(controller: controller);
        case 11:
          return SocialLinksManagement(controller: controller);
        case 12:
          return StatsManagement(controller: controller);
        default:
          return const Center(
            child: Text(
              'Select a category',
              style: TextStyle(color: Colors.white70),
            ),
          );
      }
    });
  }
}
