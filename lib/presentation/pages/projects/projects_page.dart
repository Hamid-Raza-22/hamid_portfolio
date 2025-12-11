import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/responsive_constants.dart';
import '../../controllers/projects/projects_controller.dart';
import '../../widgets/common/common_widgets.dart';

/// Projects page - displays all projects from CV.
/// UI remains unchanged, logic moved to ProjectsController.
class ProjectsPage extends GetView<ProjectsController> {
  const ProjectsPage({super.key});

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
          text: 'All Projects',
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
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                children: [
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 16, tablet: 20, desktop: 20)),
                  _buildHeader(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 28, tablet: 36, desktop: 40)),
                  _buildProjectsList(context),
                  SizedBox(height: ResponsiveValue.get<double>(context, mobile: 28, tablet: 36, desktop: 40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        SectionBadge(
          text: 'MY WORK',
          color: AppColors.accentPink,
          leadingWidget: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.accentPink,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(height: 24),
        GradientText(
          text: 'All Projects',
          colors: const [Colors.white, AppColors.primaryLight, AppColors.accentPink],
          style: TextStyle(
            fontSize: ResponsiveValue.get<double>(context, mobile: 32, desktop: 44),
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -1,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 600),
          child: Text(
            'A comprehensive showcase of my work including enterprise applications, mobile apps, and innovative solutions.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveValue.get<double>(context, mobile: 15, desktop: 16),
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsList(BuildContext context) {
    return Obx(() => Column(
      children: controller.projects.map((project) => _buildProjectCard(
        context,
        title: project.title,
        category: project.category,
        year: project.year,
        color: project.color,
        icon: project.icon,
        description: project.description,
        highlights: project.highlights,
        tags: project.tags,
      )).toList(),
    ));
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String title,
    required String category,
    required String year,
    required Color color,
    required IconData icon,
    required String description,
    required List<String> highlights,
    required List<String> tags,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: ResponsiveValue.get<double>(context, mobile: 16, tablet: 20, desktop: 24)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ResponsiveValue.get<double>(context, mobile: 16, tablet: 20, desktop: 24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: EdgeInsets.all(ResponsiveValue.get<double>(context, mobile: 16, tablet: 24, desktop: 32)),
            decoration: BoxDecoration(
              color: AppColors.cardBg.withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(icon, color: color, size: 32),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ResponsiveValue.get<double>(context, mobile: 20, desktop: 24),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            category,
                            style: TextStyle(
                              color: color,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        year,
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Key Highlights',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...highlights.map((highlight) => Padding(
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
                      const SizedBox(width: 12),
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
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: color.withOpacity(0.3)),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
