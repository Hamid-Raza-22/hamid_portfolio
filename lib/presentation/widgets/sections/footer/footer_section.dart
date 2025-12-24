import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../controllers/home/home_controller.dart';
import '../../../routes/app_routes.dart';
import '../../common/common_widgets.dart';

/// Footer section with links and social icons.
class FooterSection extends GetView<HomeController> {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobileLayout = MediaQuery.of(context).size.width < ResponsiveBreakpoints.smallTablet;

    return AnimatedBuilder(
      animation: controller.portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - controller.portfolioRotationAnimation.value)),
          child: Opacity(
            opacity: controller.portfolioRotationAnimation.value,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveValue.get<double>(context, mobile: 24, desktop: 60),
                vertical: ResponsiveValue.get<double>(context, mobile: 40, desktop: 60),
              ),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.glassBorder,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  if (isMobileLayout) ...[
                    _buildLogoAndName(context),
                    const SizedBox(height: 32),
                    _buildFooterLinksSection(context),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildLogoAndName(context)),
                        _buildFooterLinksSection(context),
                      ],
                    ),
                  ],
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 32, desktop: 40)),
                  _buildDivider(),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 24, desktop: 32)),
                  _buildBottomSection(context, isMobileLayout),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLogoAndName(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < ResponsiveBreakpoints.smallTablet;

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.primaryGradient,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'H',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            GradientText(
              text: 'Hamid Raza',
              colors: const [Colors.white, AppColors.primaryLight],
              style: TextStyle(
                fontSize: ResponsiveValue.get<double>(context, mobile: 20, desktop: 22),
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: isMobile ? double.infinity : 280,
          child: Text(
            'Crafting beautiful digital experiences with Flutter and modern technologies.',
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinksSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < ResponsiveBreakpoints.smallTablet;

    return Obx(() => Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.end,
      spacing: ResponsiveValue.get<double>(context, mobile: 24, desktop: 40),
      runSpacing: 16,
      children: controller.navItems.map((item) {
        return FooterNavItem(
          text: item.title,
          onTap: () => _handleNavigation(item.sectionKey ?? item.title.toLowerCase()),
        );
      }).toList(),
    ));
  }

  void _handleNavigation(String sectionKey) {
    switch (sectionKey.toLowerCase()) {
      case 'home':
        controller.scrollToSection('home');
        break;
      case 'about':
        Get.toNamed(AppRoutes.about);
        break;
      case 'services':
        controller.scrollToSection('services');
        break;
      case 'portfolio':
      case 'projects':
        Get.toNamed(AppRoutes.projects);
        break;
      case 'contact':
        Get.toNamed(AppRoutes.contact);
        break;
      default:
        controller.scrollToSection(sectionKey);
    }
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.glassBorder,
            AppColors.primary.withOpacity(0.3),
            AppColors.glassBorder,
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, bool isMobile) {
    return isMobile
        ? Column(
            children: [
              _buildSocialLinks(),
              const SizedBox(height: 20),
              _buildCopyright(),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCopyright(),
              _buildSocialLinks(),
            ],
          );
  }

  Widget _buildCopyright() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 400;
        
        if (isNarrow) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '© 2023 Hamid Raza.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.favorite,
                    size: 12,
                    color: AppColors.accentPink,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Flutter',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildAdminButton(),
            ],
          );
        }
        
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '© 2023 Hamid Raza. Made with ',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
              ),
            ),
            const Icon(
              Icons.favorite,
              size: 14,
              color: AppColors.accentPink,
            ),
            const Text(
              ' using Flutter',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(width: 16),
            _buildAdminButton(),
          ],
        );
      },
    );
  }

  Widget _buildAdminButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.adminLogin),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.2),
                AppColors.accentPurple.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.4),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.admin_panel_settings,
                size: 16,
                color: AppColors.primaryLight,
              ),
              SizedBox(width: 8),
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Obx(() => Row(
      mainAxisSize: MainAxisSize.min,
      children: controller.socialLinks.map((social) {
        return Padding(
          padding: const EdgeInsets.only(left: 12),
          child: SocialIconButton(
            icon: social.icon,
            label: social.name,
            onTap: () => controller.launchSocialUrl(social.url),
          ),
        );
      }).toList(),
    ));
  }
}
