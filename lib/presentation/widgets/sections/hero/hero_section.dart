import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../controllers/home/home_controller.dart';
import '../../common/common_widgets.dart';
import 'hero_image.dart';

/// Hero section with animated content.
class HeroSection extends StatelessWidget {
  final double fadeAnimationValue;
  final Offset slideAnimationValue;

  const HeroSection({
    super.key,
    required this.fadeAnimationValue,
    required this.slideAnimationValue,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: _MobileHero(
        fadeAnimationValue: fadeAnimationValue,
        slideAnimationValue: slideAnimationValue,
      ),
      desktop: _DesktopHero(
        fadeAnimationValue: fadeAnimationValue,
        slideAnimationValue: slideAnimationValue,
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  final double fadeAnimationValue;
  final Offset slideAnimationValue;

  const _DesktopHero({
    required this.fadeAnimationValue,
    required this.slideAnimationValue,
  });

  @override
  Widget build(BuildContext context) {
    final verticalSpaceSmall = ResponsiveValue.get<double>(
      context,
      mobile: 20,
      desktop: 25,
    );
    final verticalSpaceMedium = ResponsiveValue.get<double>(
      context,
      mobile: 30,
      desktop: 40,
    );

    return Transform.translate(
      offset: slideAnimationValue,
      child: Opacity(
        opacity: fadeAnimationValue,
        child: Container(
          padding: ResponsivePadding.all(context, multiplier: 1.25),
          child: Row(
            children: [
              Expanded(
                flex: ResponsiveValue.get<int>(
                  context,
                  mobile: 1,
                  tablet: 2,
                  desktop: 2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _HeroTextContent(isMobile: false),
                    SizedBox(height: verticalSpaceSmall),
                    const _HeroDescription(textAlign: TextAlign.left),
                    SizedBox(height: verticalSpaceMedium),
                    const _HeroButtons(isMobile: false),
                  ],
                ),
              ),
              SizedBox(
                width: ResponsiveValue.get<double>(
                  context,
                  mobile: 0,
                  desktop: 5,
                ),
              ),
              Expanded(
                flex: ResponsiveValue.get<int>(
                  context,
                  mobile: 1,
                  tablet: 1,
                  desktop: 1,
                ),
                child: Transform.translate(
                  offset: const Offset(-50, -80),
                  child: const HeroImage(isMobileLayout: false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileHero extends StatelessWidget {
  final double fadeAnimationValue;
  final Offset slideAnimationValue;

  const _MobileHero({
    required this.fadeAnimationValue,
    required this.slideAnimationValue,
  });

  @override
  Widget build(BuildContext context) {
    final verticalSpaceSmall = ResponsiveValue.get<double>(
      context,
      mobile: 15,
      smallTablet: 20,
      tablet: 20,
      desktop: 20,
    );
    final verticalSpaceMedium = ResponsiveValue.get<double>(
      context,
      mobile: 12,
      smallTablet: 15,
      tablet: 15,
      desktop: 15,
    );

    return Container(
      padding: ResponsivePadding.all(context, multiplier: 1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const _HeroTextContent(isMobile: true),
          SizedBox(height: verticalSpaceMedium),
          const HeroImage(isMobileLayout: true),
          SizedBox(height: verticalSpaceMedium),
          const _HeroDescription(textAlign: TextAlign.center),
          SizedBox(height: verticalSpaceSmall),
          const _HeroButtons(isMobile: true),
        ],
      ),
    );
  }
}

class _HeroTextContent extends GetView<HomeController> {
  final bool isMobile;

  const _HeroTextContent({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hero = controller.heroSection.value;
      debugPrint('📝 HeroTextContent Obx: hero=${hero?.name}, title=${hero?.title}');
      final subtitle = hero?.subtitle ?? 'Flutter Developer & UI/UX Designer';
      final title = hero?.title ?? 'Crafting Digital\nExperiences That\nInspire';
      
      return Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary.withOpacity(0.2), AppColors.accentPurple.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: ResponsiveValue.get<double>(context, mobile: 12, desktop: 30),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, desktop: 28)),
          GradientText(
            text: title,
            colors: const [Colors.white, AppColors.primaryLight, AppColors.accent],
            stops: const [0.0, 0.5, 1.0],
            style: ResponsiveTextStyle.headline(context).copyWith(
              fontSize: ResponsiveValue.get<double>(
                context,
                mobile: 38,
                smallTablet: 46,
                tablet: 54,
                desktop: 62,
              ),
              fontWeight: FontWeight.w800,
              height: 1.05,
              letterSpacing: -1.5,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ],
      );
    });
  }
}

class _HeroDescription extends GetView<HomeController> {
  final TextAlign textAlign;

  const _HeroDescription({required this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hero = controller.heroSection.value;
      final description = hero?.description ?? 
        'Passionate about building beautiful, performant mobile and web applications.\nTransforming ideas into elegant solutions with Flutter and modern technologies.';
      
      return Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: Text(
          description,
          style: ResponsiveTextStyle.body(context).copyWith(
            fontSize: ResponsiveValue.get<double>(
              context,
              mobile: 15,
              smallTablet: 16,
              tablet: 17,
              desktop: 25,
            ),
            height: 1.7,
            color: AppColors.textSecondary,
            letterSpacing: 0.2,
            wordSpacing: 0.5,
          ),
          textAlign: textAlign,
        ),
      );
    });
  }
}

class _HeroButtons extends GetView<HomeController> {
  final bool isMobile;

  const _HeroButtons({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final cv = controller.currentCv.value;
      final hasCv = cv != null && cv.url.isNotEmpty;
      
      return Wrap(
        alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
        spacing: 16,
        runSpacing: 12,
        children: [
          AnimatedButton(
            text: 'View My Work',
            icon: Icons.arrow_forward_rounded,
            isPrimary: true,
            onTap: () => controller.scrollToSection('portfolio'),
          ),
          if (hasCv)
            AnimatedButton(
              text: 'Download CV',
              icon: Icons.download_rounded,
              isPrimary: false,
              onTap: () => _downloadCv(cv.url),
            ),
        ],
      );
    });
  }

  void _downloadCv(String url) {
    launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}

