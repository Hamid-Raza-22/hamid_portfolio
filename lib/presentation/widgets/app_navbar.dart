import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/responsive_utils.dart';
import '../../app/routes/app_routes.dart';

class AppNavbar extends StatelessWidget {
  const AppNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getSpacing(context, multiplier: 2),
        vertical: ResponsiveUtils.getSpacing(context),
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderSecondary.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: ResponsiveLayout(
        mobile: _buildMobileNavbar(context),
        desktop: _buildDesktopNavbar(context),
      ),
    );
  }

  Widget _buildMobileNavbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        IconButton(
          onPressed: () => _showMobileMenu(context),
          icon: const Icon(Icons.menu, color: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildDesktopNavbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLogo(),
        Row(
          children: [
            _buildNavItem('Home', AppRoutes.HOME),
            _buildNavItem('About', AppRoutes.ABOUT),
            _buildNavItem('Skills', AppRoutes.SKILLS),
            _buildNavItem('Projects', AppRoutes.PROJECTS),
            _buildNavItem('Contact', AppRoutes.CONTACT),
          ],
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.HOME),
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [AppColors.primary, AppColors.neonBlue],
        ).createShader(bounds),
        child: const Text(
          'Portfolio',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, String route) {
    final isActive = Get.currentRoute == route;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => Get.toNamed(route),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isActive ? AppColors.primary : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                fontSize: 15,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildMobileNavItem('Home', AppRoutes.HOME, Icons.home),
            _buildMobileNavItem('About', AppRoutes.ABOUT, Icons.person),
            _buildMobileNavItem('Skills', AppRoutes.SKILLS, Icons.code),
            _buildMobileNavItem('Projects', AppRoutes.PROJECTS, Icons.work),
            _buildMobileNavItem('Contact', AppRoutes.CONTACT, Icons.email),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String label, String route, IconData icon) {
    final isActive = Get.currentRoute == route;
    
    return ListTile(
      leading: Icon(icon, color: isActive ? AppColors.primary : AppColors.textSecondary),
      title: Text(
        label,
        style: TextStyle(
          color: isActive ? AppColors.primary : AppColors.textPrimary,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      onTap: () {
        Get.back();
        Get.toNamed(route);
      },
    );
  }
}
