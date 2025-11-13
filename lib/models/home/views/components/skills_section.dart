import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../../presentation/home/controllers/home_controller.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      padding: ResponsivePadding.all(context, multiplier: 1.25),
      child: Column(
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.2),
                      AppColors.neonBlue.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.code,
                      color: AppColors.primary,
                      size: ResponsiveValue.get<double>(context, mobile: 18, desktop: 20),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Technical Skills',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: ResponsiveValue.get<double>(context, mobile: 14, desktop: 16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveValue.get<double>(context, mobile: 30, desktop: 50)),
          
          // Skills Grid
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < ResponsiveBreakpoints.tablet;
              
              return isMobile 
                  ? Column(
                      children: _buildSkillItems(context, controller, isMobile),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _buildSkillItems(context, controller, isMobile)[0],
                              const SizedBox(height: 30),
                              _buildSkillItems(context, controller, isMobile)[1],
                              const SizedBox(height: 30),
                              _buildSkillItems(context, controller, isMobile)[2],
                            ],
                          ),
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          child: Column(
                            children: [
                              _buildSkillItems(context, controller, isMobile)[3],
                              const SizedBox(height: 30),
                              _buildSkillItems(context, controller, isMobile)[4],
                              const SizedBox(height: 30),
                              _buildSkillItems(context, controller, isMobile)[5],
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSkillItems(BuildContext context, HomeController controller, bool isMobile) {
    final skills = [
      {'name': 'Flutter & Dart', 'level': 0.95, 'icon': Icons.flutter_dash},
      {'name': 'UI/UX Design', 'level': 0.90, 'icon': Icons.design_services},
      {'name': 'Firebase & Backend', 'level': 0.85, 'icon': Icons.cloud_outlined},
      {'name': 'State Management', 'level': 0.92, 'icon': Icons.layers_outlined},
      {'name': 'API Integration', 'level': 0.88, 'icon': Icons.api},
      {'name': 'Responsive Design', 'level': 0.93, 'icon': Icons.devices},
    ];

    return skills.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> skill = entry.value;
      
      return Padding(
        padding: EdgeInsets.only(bottom: isMobile ? 30 : 0),
        child: AnimatedSkillBar(
          name: skill['name'] as String,
          level: skill['level'] as double,
          icon: skill['icon'] as IconData,
          delay: Duration(milliseconds: 200 * index),
          controller: controller,
        ),
      );
    }).toList();
  }
}

class AnimatedSkillBar extends StatefulWidget {
  final String name;
  final double level;
  final IconData icon;
  final Duration delay;
  final HomeController controller;

  const AnimatedSkillBar({
    super.key,
    required this.name,
    required this.level,
    required this.icon,
    required this.delay,
    required this.controller,
  });

  @override
  State<AnimatedSkillBar> createState() => _AnimatedSkillBarState();
}

class _AnimatedSkillBarState extends State<AnimatedSkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: widget.level).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Start animation after delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _isVisible = true);
        _progressController.forward();
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedBuilder(
        animation: Listenable.merge([_progressController, widget.controller.pulseAnimation]),
        builder: (context, child) {
          return _HoverableSkillCard(
            name: widget.name,
            icon: widget.icon,
            progressAnimation: _progressAnimation,
            pulseAnimation: widget.controller.pulseAnimation,
          );
        },
      ),
    );
  }
}

class _HoverableSkillCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final Animation<double> progressAnimation;
  final Animation<double> pulseAnimation;

  const _HoverableSkillCard({
    required this.name,
    required this.icon,
    required this.progressAnimation,
    required this.pulseAnimation,
  });

  @override
  State<_HoverableSkillCard> createState() => _HoverableSkillCardState();
}

class _HoverableSkillCardState extends State<_HoverableSkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered
              ? AppColors.cardBgLight.withOpacity(0.6)
              : AppColors.cardBg.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withOpacity(0.5)
                : AppColors.borderSecondary.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.glowBlue.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.2),
                            AppColors.neonBlue.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        widget.icon,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: ResponsiveValue.get<double>(
                          context,
                          mobile: 16,
                          desktop: 18,
                        ),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${(widget.progressAnimation.value * 100).toInt()}%',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress bar background
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  // Animated progress fill
                  FractionallySizedBox(
                    widthFactor: widget.progressAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.neonBlue,
                            AppColors.primaryLight,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.glowBlue.withOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Animated shimmer effect
                  if (_isHovered)
                    AnimatedBuilder(
                      animation: widget.pulseAnimation,
                      builder: (context, child) {
                        return Positioned(
                          left: (widget.progressAnimation.value * 
                              MediaQuery.of(context).size.width * 0.8 *
                              widget.pulseAnimation.value).clamp(0.0, double.infinity),
                          child: Container(
                            width: 30,
                            height: 8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  AppColors.primaryLight.withOpacity(0.6),
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
