import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../controllers/home/home_controller.dart';
import '../../common/common_widgets.dart';
import 'portfolio_card.dart';

/// Portfolio section displaying featured projects.
class PortfolioSection extends StatelessWidget {
  final double rotationValue;
  final bool isVisible;

  const PortfolioSection({
    super.key,
    required this.rotationValue,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isMobile = ResponsiveValue.get<bool>(context, mobile: true, desktop: false);

    final clampedRotation = rotationValue.clamp(0.0, 1.0);

    return Transform.translate(
      offset: Offset(0, 100 * (1 - clampedRotation)),
      child: Opacity(
        opacity: isVisible ? clampedRotation : 0.0,
        child: Container(
          padding: ResponsivePadding.all(context, multiplier: 1.5),
          child: Column(
            children: [
              _buildSectionHeader(context, controller, isMobile),
              SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, desktop: 60)),
              _buildPortfolioGrid(context, controller),
              SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, desktop: 50)),
              const _ViewAllButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, HomeController controller, bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        SectionBadge(
          text: 'PORTFOLIO',
          color: AppColors.accentPink,
          leadingWidget: AnimatedBuilder(
            animation: controller.geometricRotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: controller.geometricRotationAnimation.value * 0.3,
                child: const Icon(
                  Icons.work_rounded,
                  color: AppColors.accentPink,
                  size: 16,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        GradientText(
          text: 'Featured Projects',
          colors: const [Colors.white, AppColors.primaryLight, AppColors.accentPink],
          stops: const [0.0, 0.5, 1.0],
          style: ResponsiveTextStyle.headline(context).copyWith(
            fontSize: ResponsiveValue.get<double>(context, mobile: 32, smallTablet: 36, tablet: 40, desktop: 44),
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -1,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 500),
          child: Text(
            'A showcase of my recent work, demonstrating expertise in Flutter development and modern UI design.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: ResponsiveValue.get<double>(context, mobile: 15, desktop: 16),
              height: 1.6,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
        ),
      ],
    );
  }

  Widget _buildPortfolioGrid(BuildContext context, HomeController controller) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobileLayout = constraints.maxWidth < ResponsiveBreakpoints.tablet;
        final isSmallTablet = constraints.maxWidth < ResponsiveBreakpoints.desktop;

        return Obx(() {
          if (isMobileLayout) {
            return Column(
              children: controller.portfolioItems.asMap().entries.map((entry) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key < controller.portfolioItems.length - 1 ? 24 : 0,
                  ),
                  child: SizedBox(
                    height: 380,
                    child: PortfolioCard(
                      portfolio: entry.value,
                      index: entry.key,
                      rotationValue: rotationValue,
                    ),
                  ),
                );
              }).toList(),
            );
          }

          // Desktop/Tablet: 3 columns grid
          final itemsPerRow = isSmallTablet ? 2 : 3;
          final rows = <Widget>[];
          
          for (var i = 0; i < controller.portfolioItems.length; i += itemsPerRow) {
            final rowItems = controller.portfolioItems.skip(i).take(itemsPerRow).toList();
            rows.add(
              Padding(
                padding: EdgeInsets.only(bottom: i + itemsPerRow < controller.portfolioItems.length ? 24 : 0),
                child: Row(
                  children: rowItems.asMap().entries.map((entry) {
                    final actualIndex = i + entry.key;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 400,
                          child: PortfolioCard(
                            portfolio: entry.value,
                            index: actualIndex,
                            rotationValue: rotationValue,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          }

          return Column(children: rows);
        });
      },
    );
  }
}

class _ViewAllButton extends GetView<HomeController> {
  const _ViewAllButton();

  @override
  Widget build(BuildContext context) {
    return HoverContainer(
      onTap: () => controller.goToProjectsPage(),
      builder: (isHovered) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: isHovered
                ? AppColors.accentPink.withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isHovered
                  ? AppColors.accentPink.withOpacity(0.5)
                  : AppColors.glassBorder,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All Projects',
                style: TextStyle(
                  color: isHovered ? AppColors.accentPink : AppColors.textSecondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(isHovered ? 4 : 0, 0, 0),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: isHovered ? AppColors.accentPink : AppColors.textSecondary,
                  size: 18,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
