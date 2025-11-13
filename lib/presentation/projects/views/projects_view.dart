import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../widgets/app_navbar.dart';
import '../controllers/projects_controller.dart';

class ProjectsView extends GetView<ProjectsController> {
  const ProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.bottomRight,
                radius: 1.5,
                colors: [AppColors.surfaceDark, AppColors.scaffoldBg, Colors.black],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const AppNavbar(),
                SizedBox(height: ResponsiveUtils.getSpacing(context, multiplier: 2)),
                Container(
                  constraints: BoxConstraints(maxWidth: ResponsiveUtils.getMaxContentWidth(context)),
                  padding: ResponsiveUtils.responsivePadding(context),
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [AppColors.textPrimary, AppColors.primary, AppColors.neonBlue],
                        ).createShader(bounds),
                        child: Text(
                          'My Projects',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.responsiveFontSize(context, mobile: 32, desktop: 48),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.getSpacing(context, multiplier: 2)),
                      Obx(() => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: ResponsiveUtils.getGridColumnCount(context, mobile: 1, tablet: 2, desktop: 3),
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: controller.filteredProjects.length,
                              itemBuilder: (context, index) {
                                final project = controller.filteredProjects[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.cardBg.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: AppColors.borderSecondary.withOpacity(0.3)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 180,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [AppColors.primary.withOpacity(0.3), AppColors.neonBlue.withOpacity(0.1)],
                                          ),
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                                        ),
                                        child: Center(
                                          child: Icon(Icons.web_rounded, size: 80, color: AppColors.primary),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(project.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                                              const SizedBox(height: 8),
                                              Text(project.description, style: const TextStyle(fontSize: 14, color: AppColors.textSecondary), maxLines: 3, overflow: TextOverflow.ellipsis),
                                              const Spacer(),
                                              Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                children: project.technologies.take(3).map((tech) => Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.primary.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                                                  ),
                                                  child: Text(tech, style: TextStyle(fontSize: 12, color: AppColors.primary)),
                                                )).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
