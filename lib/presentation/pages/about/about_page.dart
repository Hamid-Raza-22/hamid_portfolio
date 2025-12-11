import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/responsive_constants.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../domain/entities/entities.dart';
import '../../controllers/about/about_controller.dart';
import '../../widgets/common/common_widgets.dart';

/// About page - dedicated page for about information.
/// UI remains unchanged, logic moved to AboutController.
class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const GradientText(
          text: 'About Me',
          colors: [Colors.white, AppColors.primaryLight],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.8,
            colors: [
              Color(0xFF0F172A),
              Color(0xFF0C4A6E),
              AppColors.scaffoldBg,
            ],
            stops: [0.0, 0.35, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          padding: ResponsivePadding.all(context, multiplier: 1.5),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, tablet: 30, desktop: 40)),
                  _buildHeader(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, tablet: 50, desktop: 60)),
                  _buildAboutContent(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, tablet: 50, desktop: 60)),
                  _buildTechExpertise(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, tablet: 50, desktop: 60)),
                  _buildExperience(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, tablet: 50, desktop: 60)),
                  _buildEducation(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, tablet: 50, desktop: 60)),
                  _buildAchievements(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, tablet: 50, desktop: 60)),
                  _buildCertifications(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, tablet: 30, desktop: 40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Obx(() {
      final profile = controller.profile.value;
      return Column(
        children: [
          SectionBadge(
            text: 'ABOUT ME',
            color: AppColors.accent,
            leadingWidget: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 24),
          GradientText(
            text: profile?.name ?? 'HAMID RAZA',
            colors: const [Colors.white, AppColors.primaryLight, AppColors.accent],
            style: TextStyle(
              fontSize: ResponsiveValue.get<double>(context, mobile: 36, desktop: 52),
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            profile?.title ?? '',
            style: TextStyle(
              fontSize: ResponsiveValue.get<double>(context, mobile: 14, desktop: 18),
              color: AppColors.primaryLight,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.accent.withOpacity(0.3)),
            ),
            child: Text(
              profile?.experience ?? '',
              style: const TextStyle(
                color: AppColors.accent,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAboutContent(BuildContext context) {
    return Obx(() {
      final profile = controller.profile.value;
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 900),
            padding: EdgeInsets.all(ResponsiveValue.get<double>(context, mobile: 24, desktop: 40)),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 24),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Professional Summary',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  profile?.summary ?? '',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: ResponsiveValue.get<double>(context, mobile: 15, desktop: 16),
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoRow(Icons.work_outline_rounded, 'Work Preferences', profile?.workPreferences ?? ''),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.location_on_outlined, 'Location', profile?.location ?? ''),
                const SizedBox(height: 12),
                _buildInfoRow(Icons.language_rounded, 'Languages', profile?.languages ?? ''),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryLight, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTechExpertise(BuildContext context) {
    return Obx(() => Column(
      children: [
        const Text(
          'Technical Expertise',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: controller.expertise.map((exp) => _buildExpertiseCard(
            context,
            title: exp.title,
            icon: exp.icon,
            color: exp.color,
            skills: exp.skills,
          )).toList(),
        ),
      ],
    ));
  }

  Widget _buildExpertiseCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<String> skills,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: ResponsiveValue.get<double>(
            context, 
            smallMobile: double.infinity,
            mobile: double.infinity, 
            smallTablet: 340,
            tablet: 300,
            desktop: 280,
          ),
          padding: EdgeInsets.all(ResponsiveValue.get<double>(context, mobile: 16, tablet: 20, desktop: 24)),
          decoration: BoxDecoration(
            color: AppColors.cardBg.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...skills.map((skill) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        skill,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperience(BuildContext context) {
    return Obx(() => Column(
      children: [
        const Text(
          'Work Experience',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 32),
        ...controller.experiences.map((exp) => _buildExperienceCard(
          context,
          title: exp.title,
          company: exp.company,
          location: exp.location,
          duration: exp.duration,
          highlights: exp.highlights,
        )),
      ],
    ));
  }

  Widget _buildExperienceCard(
    BuildContext context, {
    required String title,
    required String company,
    required String location,
    required String duration,
    required List<String> highlights,
  }) {
    return Container(
      width: ResponsiveValue.get<double>(
        context, 
        mobile: double.infinity, 
        smallTablet: double.infinity,
        tablet: 700,
        desktop: 800,
      ),
      margin: EdgeInsets.only(bottom: ResponsiveValue.get<double>(context, mobile: 16, desktop: 20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ResponsiveValue.get<double>(context, mobile: 16, desktop: 20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(ResponsiveValue.get<double>(context, mobile: 16, tablet: 20, desktop: 24)),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            company,
                            style: const TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            location,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        duration,
                        style: const TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...highlights.map((highlight) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          highlight,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEducation(BuildContext context) {
    return Obx(() {
      final edu = controller.education.isNotEmpty ? controller.education.first : null;
      return Column(
        children: [
          const Text(
            'Education',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 32),
          ClipRRect(
            borderRadius: BorderRadius.circular(ResponsiveValue.get<double>(context, mobile: 16, desktop: 20)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: ResponsiveValue.get<double>(context, mobile: double.infinity, smallTablet: 400, tablet: 500, desktop: 600),
                padding: EdgeInsets.all(ResponsiveValue.get<double>(context, mobile: 16, tablet: 20, desktop: 24)),
                decoration: BoxDecoration(
                  color: AppColors.cardBg.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.glassBorder),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.school_rounded, color: AppColors.primary, size: 32),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      edu?.degree ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      edu?.institution ?? '',
                      style: const TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      edu?.duration ?? '',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (edu?.cgpa != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'CGPA: ${edu!.cgpa}',
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (edu?.specialization != null)
                      Text(
                        'Specialization: ${edu!.specialization}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 4),
                    if (edu?.project != null)
                      Text(
                        'FYP: ${edu!.project}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAchievements(BuildContext context) {
    return Obx(() => Column(
      children: [
        const Text(
          'Achievements',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: controller.achievements.map((achievement) => ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 350),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBg.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(achievement.icon, color: AppColors.accent, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        achievement.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )).toList(),
        ),
      ],
    ));
  }

  Widget _buildCertifications(BuildContext context) {
    return Obx(() => Column(
      children: [
        const Text(
          'Certifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: controller.certifications.map((cert) => ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 280),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBg.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.workspace_premium_rounded, color: AppColors.primary, size: 28),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      cert.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${cert.issuer} • ${cert.year}',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )).toList(),
        ),
      ],
    ));
  }
}
