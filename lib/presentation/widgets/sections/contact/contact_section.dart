import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../controllers/home/home_controller.dart';
import '../../common/common_widgets.dart';

/// Contact section with call-to-action.
class ContactSection extends GetView<HomeController> {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.portfolioRotationAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - controller.portfolioRotationAnimation.value)),
          child: Opacity(
            opacity: controller.portfolioRotationAnimation.value,
            child: Container(
              padding: ResponsivePadding.all(context, multiplier: 1.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveValue.get<double>(context, mobile: 24, desktop: 60),
                      vertical: ResponsiveValue.get<double>(context, mobile: 40, desktop: 60),
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withOpacity(0.15),
                          AppColors.accentPurple.withOpacity(0.1),
                          AppColors.cardBg.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 40,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: _buildContent(context),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        SectionBadge(
          text: 'GET IN TOUCH',
          color: AppColors.accent,
          leadingWidget: AnimatedBuilder(
            animation: controller.pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: controller.pulseAnimation.value,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 24, desktop: 32)),
        GradientText(
          text: "Let's Build Something\nAmazing Together",
          colors: const [Colors.white, AppColors.primaryLight],
          style: TextStyle(
            fontSize: ResponsiveValue.get<double>(context, mobile: 28, smallTablet: 34, tablet: 40, desktop: 46),
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -1,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 16, desktop: 20)),
        SizedBox(
          width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 500),
          child: Text(
            'Have a project in mind? I\'d love to hear about it. Let\'s discuss how we can work together to bring your vision to life.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveValue.get<double>(context, mobile: 15, desktop: 16),
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 32, desktop: 40)),
        const Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 12,
          children: [
            AnimatedButton(
              text: 'Start a Project',
              icon: Icons.rocket_launch_rounded,
              isPrimary: true,
              iconLeading: true,
            ),
            AnimatedButton(
              text: 'Send Email',
              icon: Icons.mail_outline_rounded,
              isPrimary: false,
              iconLeading: true,
            ),
          ],
        ),
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 32, desktop: 40)),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: controller.socialLinks.take(3).map((social) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SocialIconLarge(
                icon: social.icon,
                label: social.name,
              ),
            );
          }).toList(),
        )),
      ],
    );
  }
}
