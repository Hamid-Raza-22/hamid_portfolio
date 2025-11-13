import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../widgets/app_navbar.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topRight,
                radius: 1.5,
                colors: [
                  AppColors.surfaceDark,
                  AppColors.scaffoldBg,
                  Colors.black,
                ],
              ),
            ),
          ),
          
          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                const AppNavbar(),
                SizedBox(height: ResponsiveUtils.getSpacing(context)),
                
                FadeTransition(
                  opacity: controller.fadeAnimation,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: ResponsiveUtils.getMaxContentWidth(context),
                    ),
                    padding: ResponsiveUtils.responsivePadding(context),
                    child: ResponsiveLayout(
                      mobile: _buildMobileLayout(context),
                      desktop: _buildDesktopLayout(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        SizedBox(height: ResponsiveUtils.getSpacing(context, multiplier: 2)),
        _buildContent(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildHeader(context)),
        SizedBox(width: ResponsiveUtils.getSpacing(context, multiplier: 3)),
        Expanded(flex: 3, child: _buildContent(context)),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.textPrimary,
              AppColors.primary,
              AppColors.neonBlue,
            ],
          ).createShader(bounds),
          child: Text(
            'About Me',
            style: TextStyle(
              fontSize: ResponsiveUtils.responsiveFontSize(
                context,
                mobile: 32,
                tablet: 40,
                desktop: 48,
              ),
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: ResponsiveUtils.getSpacing(context)),
        Text(
          'Passionate Flutter Developer with a love for creating beautiful and functional mobile experiences.',
          style: TextStyle(
            fontSize: ResponsiveUtils.responsiveFontSize(
              context,
              mobile: 16,
              desktop: 18,
            ),
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabBar(context),
        SizedBox(height: ResponsiveUtils.getSpacing(context, multiplier: 2)),
        Obx(() => _buildTabContent(context)),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Obx(() => Row(
      children: List.generate(
        controller.tabs.length,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () => controller.changeTab(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: controller.currentTab.value == index
                    ? AppColors.primary.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: controller.currentTab.value == index
                      ? AppColors.primary
                      : AppColors.borderSecondary,
                  width: 1.5,
                ),
              ),
              child: Text(
                controller.tabs[index],
                style: TextStyle(
                  color: controller.currentTab.value == index
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget _buildTabContent(BuildContext context) {
    switch (controller.currentTab.value) {
      case 1:
        return _buildEducation(context);
      case 2:
        return _buildExperience(context);
      default:
        return _buildStory(context);
    }
  }

  Widget _buildStory(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.borderSecondary.withOpacity(0.3),
        ),
      ),
      child: Text(
        'Senior Flutter Developer with 3 years of experience architecting cross-platform solutions. '
        'Specialized in performance optimization, CI/CD automation (60% faster deployments), and OWASP-compliant security. '
        'Led teams delivering enterprise applications serving 300+ users with consistent 60 FPS performance.\n\n'
        'Currently leading Flutter development at Octa Logicx Pvt. Ltd., where I established Clean Architecture frameworks '
        'that reduced code complexity by 40% and implemented CI/CD pipelines that cut deployment time from 4 hours to 30 minutes. '
        'Passionate about technical leadership, mentoring junior developers, and contributing to the Flutter community.\n\n'
        'Open to remote, hybrid, or on-site opportunities. Willing to relocate for the right position.',
        style: TextStyle(
          fontSize: ResponsiveUtils.responsiveFontSize(context, mobile: 15, desktop: 16),
          color: AppColors.textSecondary,
          height: 1.8,
        ),
      ),
    );
  }

  Widget _buildEducation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.borderSecondary.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEducationItem(
            'BS in Software Engineering',
            'University of Sialkot',
            '2019 - 2023',
            'CGPA: 3.2/4.0 • Specialization: Mobile Development • FYP: "Polio Vaccination Management Systems"',
          ),
          const SizedBox(height: 24),
          Text(
            'Certifications',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          _buildEducationItem(
            'Foundation of Project Management',
            'Google',
            '2023',
            'Project management fundamentals and best practices',
          ),
          const SizedBox(height: 16),
          _buildEducationItem(
            'SQL for Data Science',
            'UC Davis',
            '2023',
            'Database design and query optimization',
          ),
          const SizedBox(height: 16),
          _buildEducationItem(
            'Flutter Dart Programming',
            'MetaXperts',
            '2024',
            'Advanced Flutter development and architecture',
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(String degree, String institution, String year, [String? description]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          degree,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          institution,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          year,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildExperience(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.borderSecondary.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExperienceItem(
            'Lead Flutter Department',
            'Octa Logicx Pvt. Ltd.',
            'Jul 2025 - Present',
            'Spearheaded development of enterprise-scale Flutter applications serving 300+ users with 60 FPS performance. '
            'Established Clean Architecture framework reducing code complexity by 40%. '
            'Implemented CI/CD pipelines with GitHub Actions, automating releases and reducing deployment cycles by 50%. '
            'Mentored and guided a team of 3 junior developers through structured code reviews and technical workshops.',
          ),
          const SizedBox(height: 24),
          _buildExperienceItem(
            'Senior Flutter Developer',
            'MetaXperts Pvt. Ltd.',
            'Aug 2023 - Jul 2025',
            'Led design and delivery of cross-platform applications for enterprise clients. '
            'Optimized Firebase integrations reducing backend costs by 30%. '
            'Enhanced application performance through advanced caching and memory management techniques. '
            'Supported organizational growth by mentoring junior developers and introducing modern state management practices.',
          ),
          const SizedBox(height: 24),
          _buildExperienceItem(
            'Junior Flutter Developer',
            'Leopard Express',
            'Jul 2022 - May 2023',
            'Developed internal business tools in Flutter automating workflows, saving 20+ hours of manual work weekly. '
            'Maintained SQL databases with 99.9% uptime ensuring smooth business operations. '
            'Collaborated with Agile cross-functional teams to deliver software solutions aligned with organizational goals.',
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(String title, String company, String period, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          company,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          period,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}
