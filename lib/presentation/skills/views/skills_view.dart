import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../widgets/app_navbar.dart';
import '../controllers/skills_controller.dart';

class SkillsView extends GetView<SkillsController> {
  const SkillsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.5,
                colors: [
                  AppColors.surfaceDark,
                  AppColors.scaffoldBg,
                  Colors.black,
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const AppNavbar(),
                SizedBox(height: ResponsiveUtils.getSpacing(context, multiplier: 2)),
                
                Container(
                  constraints: BoxConstraints(
                    maxWidth: ResponsiveUtils.getMaxContentWidth(context),
                  ),
                  padding: ResponsiveUtils.responsivePadding(context),
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [AppColors.textPrimary, AppColors.primary, AppColors.neonBlue],
                        ).createShader(bounds),
                        child: Text(
                          'Technical Skills',
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
                          : _buildSkillsGrid(context)),
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

  Widget _buildSkillsGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveUtils.getGridColumnCount(context, mobile: 1, tablet: 2, desktop: 2),
        childAspectRatio: 4,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: controller.filteredSkills.length,
      itemBuilder: (context, index) {
        final skill = controller.filteredSkills[index];
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBg.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderSecondary.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(skill.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  Text('${(skill.level * 100).toInt()}%', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: skill.level,
                  minHeight: 8,
                  backgroundColor: AppColors.surfaceDark,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
