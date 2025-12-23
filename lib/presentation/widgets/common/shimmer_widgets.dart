import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/responsive_constants.dart';

/// Shimmer animation widget for loading placeholders.
class ShimmerWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ShimmerWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [
                Color(0xFF1E293B),
                Color(0xFF334155),
                Color(0xFF1E293B),
              ],
              stops: [
                (_animation.value - 0.3).clamp(0.0, 1.0),
                _animation.value.clamp(0.0, 1.0),
                (_animation.value + 0.3).clamp(0.0, 1.0),
              ],
              transform: _SlidingGradientTransform(_animation.value),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform(this.slidePercent);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

/// Skeleton placeholder box with rounded corners.
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Skeleton for text lines.
class SkeletonText extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonText({
    super.key,
    required this.width,
    this.height = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonBox(
      width: width,
      height: height,
      borderRadius: 4,
    );
  }
}

/// Hero section skeleton placeholder - responsive for all devices.
class HeroSkeleton extends StatelessWidget {
  const HeroSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < ResponsiveBreakpoints.tablet;
        final isSmallTablet = width < ResponsiveBreakpoints.desktop;
        
        final padding = isMobile ? 20.0 : (isSmallTablet ? 32.0 : 48.0);
        final imageSize = isMobile ? 180.0 : (isSmallTablet ? 280.0 : 350.0);
        
        return ShimmerWidget(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: isMobile 
                ? _buildMobileLayout(imageSize)
                : _buildDesktopLayout(imageSize, isSmallTablet),
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout(double imageSize, bool isSmallTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SkeletonBox(width: isSmallTablet ? 100 : 120, height: 28, borderRadius: 20),
              SizedBox(height: isSmallTablet ? 20 : 24),
              SkeletonText(width: isSmallTablet ? 220 : 300, height: isSmallTablet ? 36 : 48),
              const SizedBox(height: 12),
              SkeletonText(width: isSmallTablet ? 180 : 250, height: isSmallTablet ? 28 : 36),
              const SizedBox(height: 20),
              SkeletonText(width: isSmallTablet ? 280 : 400, height: 16),
              const SizedBox(height: 8),
              SkeletonText(width: isSmallTablet ? 240 : 350, height: 16),
              SizedBox(height: isSmallTablet ? 24 : 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SkeletonBox(width: isSmallTablet ? 130 : 160, height: 50, borderRadius: 12),
                  SkeletonBox(width: isSmallTablet ? 110 : 140, height: 50, borderRadius: 12),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: isSmallTablet ? 24 : 40),
        Expanded(
          child: Center(
            child: SkeletonBox(
              width: imageSize,
              height: imageSize,
              borderRadius: imageSize / 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double imageSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SkeletonBox(width: imageSize, height: imageSize, borderRadius: imageSize / 2),
        const SizedBox(height: 28),
        const SkeletonBox(width: 90, height: 22, borderRadius: 14),
        const SizedBox(height: 14),
        const SkeletonText(width: 200, height: 28),
        const SizedBox(height: 10),
        const SkeletonText(width: 160, height: 22),
        const SizedBox(height: 18),
        const SkeletonText(width: 260, height: 13),
        const SizedBox(height: 5),
        const SkeletonText(width: 220, height: 13),
        const SizedBox(height: 24),
        const SkeletonBox(width: double.infinity, height: 48, borderRadius: 12),
      ],
    );
  }
}

/// Service card skeleton placeholder.
class ServiceCardSkeleton extends StatelessWidget {
  const ServiceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(width: 56, height: 56, borderRadius: 16),
          const SizedBox(height: 20),
          const SkeletonText(width: 140, height: 20),
          const SizedBox(height: 12),
          const SkeletonText(width: double.infinity, height: 12),
          const SizedBox(height: 6),
          const SkeletonText(width: 180, height: 12),
          const Spacer(),
          Row(
            children: [
              const SkeletonText(width: 80, height: 14),
              const Spacer(),
              SkeletonBox(width: 24, height: 24, borderRadius: 12),
            ],
          ),
        ],
      ),
    );
  }
}

/// Services section skeleton placeholder - responsive for all devices.
class ServicesSkeleton extends StatelessWidget {
  final int itemCount;

  const ServicesSkeleton({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < ResponsiveBreakpoints.tablet;
        final isSmallTablet = width < ResponsiveBreakpoints.desktop;
        
        final crossAxisCount = isMobile ? 1 : (isSmallTablet ? 2 : 4);
        final aspectRatio = isMobile ? 1.4 : (isSmallTablet ? 1.2 : 1.05);
        final padding = isMobile ? 20.0 : (isSmallTablet ? 28.0 : 40.0);
        
        return ShimmerWidget(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: isMobile ? 80 : 100, height: 26, borderRadius: 16),
                SizedBox(height: isMobile ? 16 : 20),
                SkeletonText(width: isMobile ? 180 : (isSmallTablet ? 200 : 240), height: isMobile ? 32 : 40),
                const SizedBox(height: 12),
                SkeletonText(width: isMobile ? 280 : (isSmallTablet ? 320 : 400), height: 16),
                SizedBox(height: isMobile ? 30 : 40),
                GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: aspectRatio,
                  mainAxisSpacing: isMobile ? 12 : 20,
                  crossAxisSpacing: isMobile ? 12 : 20,
                  children: List.generate(
                    isMobile ? 2 : itemCount,
                    (_) => const ServiceCardSkeleton(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Portfolio card skeleton placeholder.
class PortfolioCardSkeleton extends StatelessWidget {
  const PortfolioCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
          ),
          // Content placeholder
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SkeletonBox(width: 28, height: 28, borderRadius: 8),
                      const SizedBox(width: 12),
                      const SkeletonText(width: 100, height: 18),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const SkeletonText(width: double.infinity, height: 12),
                  const SizedBox(height: 6),
                  const SkeletonText(width: 140, height: 12),
                  const Spacer(),
                  Row(
                    children: List.generate(
                      3,
                      (_) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SkeletonBox(width: 60, height: 24, borderRadius: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Portfolio section skeleton placeholder - responsive for all devices.
class PortfolioSkeleton extends StatelessWidget {
  final int itemCount;

  const PortfolioSkeleton({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < ResponsiveBreakpoints.tablet;
        final isSmallTablet = width < ResponsiveBreakpoints.desktop;
        
        final padding = isMobile ? 20.0 : (isSmallTablet ? 28.0 : 40.0);
        final cardHeight = isMobile ? 300.0 : 400.0;
        final columnsCount = isMobile ? 1 : (isSmallTablet ? 2 : 3);
        
        return ShimmerWidget(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                SkeletonBox(width: isMobile ? 80 : 100, height: 26, borderRadius: 16),
                SizedBox(height: isMobile ? 16 : 20),
                SkeletonText(width: isMobile ? 180 : 220, height: isMobile ? 32 : 40),
                const SizedBox(height: 12),
                SkeletonText(width: isMobile ? 280 : 380, height: 16),
                SizedBox(height: isMobile ? 30 : 40),
                if (isMobile)
                  ...List.generate(
                    2,
                    (_) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(height: cardHeight, child: const PortfolioCardSkeleton()),
                    ),
                  )
                else
                  SizedBox(
                    height: cardHeight,
                    child: Row(
                      children: List.generate(
                        columnsCount,
                        (_) => const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: PortfolioCardSkeleton(),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// About page skeleton placeholder.
class AboutPageSkeleton extends StatelessWidget {
  const AboutPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < ResponsiveBreakpoints.tablet;
        final padding = isMobile ? 20.0 : 40.0;
        
        return ShimmerWidget(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Column(
                    children: [
                      SkeletonBox(width: isMobile ? 120 : 160, height: isMobile ? 120 : 160, borderRadius: isMobile ? 60 : 80),
                      const SizedBox(height: 20),
                      SkeletonText(width: isMobile ? 180 : 240, height: isMobile ? 28 : 36),
                      const SizedBox(height: 10),
                      SkeletonText(width: isMobile ? 140 : 180, height: 18),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 32 : 48),
                
                // Bio section
                const SkeletonBox(width: 80, height: 24, borderRadius: 12),
                const SizedBox(height: 16),
                ...List.generate(4, (_) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SkeletonText(width: double.infinity, height: 14),
                )),
                SizedBox(height: isMobile ? 32 : 40),
                
                // Experience section
                const SkeletonBox(width: 120, height: 24, borderRadius: 12),
                const SizedBox(height: 20),
                ...List.generate(3, (_) => _buildExperienceCardSkeleton(isMobile)),
                
                SizedBox(height: isMobile ? 32 : 40),
                
                // Skills section
                const SkeletonBox(width: 80, height: 24, borderRadius: 12),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(8, (_) => 
                    SkeletonBox(width: isMobile ? 70 : 90, height: 32, borderRadius: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExperienceCardSkeleton(bool isMobile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SkeletonBox(width: 44, height: 44, borderRadius: 12),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonText(width: isMobile ? 140 : 180, height: 18),
                    const SizedBox(height: 6),
                    SkeletonText(width: isMobile ? 100 : 140, height: 14),
                  ],
                ),
              ),
              SkeletonBox(width: 70, height: 24, borderRadius: 12),
            ],
          ),
          const SizedBox(height: 12),
          const SkeletonText(width: double.infinity, height: 12),
          const SizedBox(height: 6),
          SkeletonText(width: isMobile ? 200 : 280, height: 12),
        ],
      ),
    );
  }
}

/// Projects page skeleton placeholder.
class ProjectsPageSkeleton extends StatelessWidget {
  const ProjectsPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < ResponsiveBreakpoints.tablet;
        final isSmallTablet = width < ResponsiveBreakpoints.desktop;
        
        final crossAxisCount = isMobile ? 1 : (isSmallTablet ? 2 : 3);
        final padding = isMobile ? 16.0 : 32.0;
        
        return ShimmerWidget(
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Center(
                  child: Column(
                    children: [
                      SkeletonText(width: isMobile ? 160 : 200, height: isMobile ? 28 : 36),
                      const SizedBox(height: 12),
                      SkeletonText(width: isMobile ? 260 : 360, height: 16),
                    ],
                  ),
                ),
                SizedBox(height: isMobile ? 28 : 40),
                
                // Filter tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(4, (_) => Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SkeletonBox(width: 80, height: 36, borderRadius: 18),
                    )),
                  ),
                ),
                SizedBox(height: isMobile ? 24 : 32),
                
                // Projects grid
                GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: isMobile ? 0.85 : 0.75,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: List.generate(
                    isMobile ? 3 : 6,
                    (_) => const PortfolioCardSkeleton(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Contact page skeleton placeholder.
class ContactPageSkeleton extends StatelessWidget {
  const ContactPageSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isMobile = width < ResponsiveBreakpoints.tablet;
        final padding = isMobile ? 20.0 : 48.0;
        
        return ShimmerWidget(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                SkeletonText(width: isMobile ? 180 : 240, height: isMobile ? 32 : 42),
                const SizedBox(height: 12),
                SkeletonText(width: isMobile ? 280 : 400, height: 16),
                SizedBox(height: isMobile ? 32 : 48),
                
                // Contact info cards
                if (isMobile)
                  Column(
                    children: List.generate(3, (_) => _buildContactCardSkeleton(isMobile)),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (_) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _buildContactCardSkeleton(isMobile),
                      ),
                    )),
                  ),
                
                SizedBox(height: isMobile ? 32 : 48),
                
                // Contact form
                Container(
                  width: isMobile ? double.infinity : 500,
                  padding: EdgeInsets.all(isMobile ? 20 : 32),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildFormFieldSkeleton(),
                      _buildFormFieldSkeleton(),
                      _buildFormFieldSkeleton(height: 100),
                      const SizedBox(height: 20),
                      SkeletonBox(width: double.infinity, height: 50, borderRadius: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactCardSkeleton(bool isMobile) {
    return Container(
      margin: EdgeInsets.only(bottom: isMobile ? 16 : 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SkeletonBox(width: 48, height: 48, borderRadius: 24),
          const SizedBox(height: 16),
          SkeletonText(width: 100, height: 18),
          const SizedBox(height: 8),
          SkeletonText(width: 140, height: 14),
        ],
      ),
    );
  }

  Widget _buildFormFieldSkeleton({double height = 50}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonText(width: 80, height: 14),
          const SizedBox(height: 8),
          SkeletonBox(width: double.infinity, height: height, borderRadius: 10),
        ],
      ),
    );
  }
}
