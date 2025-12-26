import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/responsive_constants.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../domain/entities/entities.dart';
import '../../controllers/about/about_controller.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/common/shimmer_widgets.dart';

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
        child: Obx(() {
          // Show skeleton while data is loading
          if (controller.isLoading.value && controller.profile.value == null) {
            return const AboutPageSkeleton();
          }
          return SingleChildScrollView(
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
          );
        }),
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
    final isMobile = ResponsiveValue.get<bool>(context, mobile: true, tablet: false, desktop: false);
    
    return Obx(() {
      final profile = controller.profile.value;
      return ClipRRect(
        borderRadius: BorderRadius.circular(ResponsiveValue.get<double>(context, mobile: 16, desktop: 24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 900),
            padding: EdgeInsets.all(ResponsiveValue.get<double>(context, mobile: 16, tablet: 28, desktop: 40)),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(ResponsiveValue.get<double>(context, mobile: 16, desktop: 24)),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header - responsive layout
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 20),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Professional Summary',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    : Row(
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
                SizedBox(height: ResponsiveValue.get<double>(context, mobile: 16, desktop: 20)),
                Text(
                  profile?.summary ?? '',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: ResponsiveValue.get<double>(context, mobile: 14, tablet: 15, desktop: 16),
                    height: 1.7,
                  ),
                ),
                SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, desktop: 24)),
                _buildInfoRow(Icons.work_outline_rounded, 'Work Preferences', profile?.workPreferences ?? '', isMobile: isMobile),
                SizedBox(height: ResponsiveValue.get<double>(context, mobile: 10, desktop: 12)),
                _buildInfoRow(Icons.location_on_outlined, 'Location', profile?.location ?? '', isMobile: isMobile),
                SizedBox(height: ResponsiveValue.get<double>(context, mobile: 10, desktop: 12)),
                _buildInfoRow(Icons.language_rounded, 'Languages', profile?.languages ?? '', isMobile: isMobile),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {bool isMobile = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryLight, size: isMobile ? 18 : 20),
        SizedBox(width: isMobile ? 10 : 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontSize: isMobile ? 13 : 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: isMobile ? 2 : 4),
              Text(
                value,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: isMobile ? 13 : 14,
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
            customIconUrl: exp.customIconUrl,
            useCustomImage: exp.useCustomImage,
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
    String? customIconUrl,
    bool useCustomImage = false,
  }) {
    final shouldShowCustomImage = useCustomImage && customIconUrl != null && customIconUrl.isNotEmpty;
    
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
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: shouldShowCustomImage
                        ? Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                customIconUrl!,
                                width: 28,
                                height: 28,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Icon(icon, color: color, size: 24),
                              ),
                            ),
                          )
                        : Center(child: Icon(icon, color: color, size: 24)),
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
              ...skills.asMap().entries.map((entry) {
                final index = entry.key;
                final skillName = entry.value;
                // Check if there's a corresponding skillEntity with icon
                SkillEntity? skillEntity;
                if (controller.expertise.isNotEmpty) {
                  final exp = controller.expertise.firstWhereOrNull((e) => e.skills.contains(skillName));
                  if (exp != null && exp.skillEntities.length > index) {
                    skillEntity = exp.skillEntities.firstWhereOrNull((s) => s.name == skillName);
                  }
                }
                final hasCustomIcon = skillEntity?.useCustomImage == true && skillEntity?.customIconUrl != null;
                final hasIcon = skillEntity?.icon != null || hasCustomIcon;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasCustomIcon)
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          width: 20,
                          height: 20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              skillEntity!.customIconUrl!,
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Icon(
                                skillEntity?.icon ?? Icons.code,
                                color: color,
                                size: 16,
                              ),
                            ),
                          ),
                        )
                      else if (hasIcon)
                        Container(
                          margin: const EdgeInsets.only(top: 2),
                          child: Icon(
                            skillEntity!.icon!,
                            color: color,
                            size: 16,
                          ),
                        )
                      else
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
                          skillName,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperience(BuildContext context) {
    return Obx(() {
      // Sort experiences by order
      final sortedExperiences = List<ExperienceEntity>.from(controller.experiences)
        ..sort((a, b) => a.order.compareTo(b.order));
      
      return Column(
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
          ...sortedExperiences.map((exp) => _buildExperienceCard(
            context,
            experience: exp,
          )),
        ],
      );
    });
  }

  Widget _buildExperienceCard(
    BuildContext context, {
    required ExperienceEntity experience,
  }) {
    final shouldShowCustomImage = experience.useCustomImage && 
        experience.customIconUrl != null && 
        experience.customIconUrl!.isNotEmpty;
    final iconColor = experience.color ?? AppColors.primary;
    final isMobile = ResponsiveValue.get<bool>(context, mobile: true, smallTablet: true, tablet: false, desktop: false);
    final iconSize = isMobile ? 40.0 : 48.0;
    final iconImageSize = isMobile ? 26.0 : 32.0;
    final iconInnerSize = isMobile ? 20.0 : 24.0;
    
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
            padding: EdgeInsets.all(ResponsiveValue.get<double>(context, mobile: 14, tablet: 20, desktop: 24)),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mobile-optimized header layout
                if (isMobile) ...[
                  // Duration badge at top on mobile
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        experience.duration,
                        style: const TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Icon and title row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: shouldShowCustomImage
                            ? Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    experience.customIconUrl!,
                                    width: iconImageSize,
                                    height: iconImageSize,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => Icon(
                                      experience.icon ?? Icons.work_rounded,
                                      color: iconColor,
                                      size: iconInnerSize,
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Icon(
                                  experience.icon ?? Icons.work_rounded,
                                  color: iconColor,
                                  size: iconInnerSize,
                                ),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              experience.company,
                              style: const TextStyle(
                                color: AppColors.primaryLight,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              experience.location,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  // Desktop/Tablet layout - original row with duration badge inline
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          color: iconColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: shouldShowCustomImage
                            ? Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    experience.customIconUrl!,
                                    width: iconImageSize,
                                    height: iconImageSize,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => Icon(
                                      experience.icon ?? Icons.work_rounded,
                                      color: iconColor,
                                      size: iconInnerSize,
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Icon(
                                  experience.icon ?? Icons.work_rounded,
                                  color: iconColor,
                                  size: iconInnerSize,
                                ),
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              experience.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              experience.company,
                              style: const TextStyle(
                                color: AppColors.primaryLight,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              experience.location,
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
                          experience.duration,
                          style: const TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: isMobile ? 12 : 16),
                ...experience.highlights.map((highlight) => Padding(
                  padding: EdgeInsets.only(bottom: isMobile ? 6 : 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: isMobile ? 5 : 6),
                        width: isMobile ? 5 : 6,
                        height: isMobile ? 5 : 6,
                        decoration: BoxDecoration(
                          color: iconColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: isMobile ? 8 : 10),
                      Expanded(
                        child: Text(
                          highlight,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: isMobile ? 13 : 14,
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
      // Sort education by order
      final sortedEducation = List<EducationEntity>.from(controller.education)
        ..sort((a, b) => a.order.compareTo(b.order));
      
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
          ...sortedEducation.map((edu) => _buildEducationCard(context, education: edu)),
        ],
      );
    });
  }

  Widget _buildEducationCard(BuildContext context, {required EducationEntity education}) {
    final shouldShowCustomImage = education.useCustomImage && 
        education.customIconUrl != null && 
        education.customIconUrl!.isNotEmpty;
    final iconColor = education.color ?? AppColors.primary;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: ClipRRect(
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
                // Custom icon/image support
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: shouldShowCustomImage
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            education.customIconUrl!,
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => Icon(
                              education.icon ?? Icons.school_rounded,
                              color: iconColor,
                              size: 32,
                            ),
                          ),
                        )
                      : Icon(
                          education.icon ?? Icons.school_rounded, 
                          color: iconColor, 
                          size: 32,
                        ),
                ),
                const SizedBox(height: 16),
                Text(
                  education.degree,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  education.institution,
                  style: const TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  education.duration,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                if (education.cgpa != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'CGPA: ${education.cgpa}',
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                if (education.specialization != null)
                  Text(
                    'Specialization: ${education.specialization}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 4),
                if (education.project != null)
                  Text(
                    'FYP: ${education.project}',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
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
          children: controller.achievements.map((achievement) {
            final shouldShowCustomImage = achievement.useCustomImage && 
                achievement.customIconUrl != null && 
                achievement.customIconUrl!.isNotEmpty;
            
            return ClipRRect(
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
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: shouldShowCustomImage
                            ? Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(
                                    achievement.customIconUrl!,
                                    width: 28,
                                    height: 28,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => Icon(achievement.icon, color: AppColors.accent, size: 24),
                                  ),
                                ),
                              )
                            : Center(child: Icon(achievement.icon, color: AppColors.accent, size: 24)),
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
            );
          }).toList(),
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
