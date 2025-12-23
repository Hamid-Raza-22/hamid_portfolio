import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

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

/// Hero section skeleton placeholder.
class HeroSkeleton extends StatelessWidget {
  final bool isMobile;

  const HeroSkeleton({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 24 : 48),
        child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SkeletonBox(width: 120, height: 28, borderRadius: 20),
              const SizedBox(height: 24),
              const SkeletonText(width: 300, height: 48),
              const SizedBox(height: 12),
              const SkeletonText(width: 250, height: 36),
              const SizedBox(height: 20),
              const SkeletonText(width: 400, height: 16),
              const SizedBox(height: 8),
              const SkeletonText(width: 350, height: 16),
              const SizedBox(height: 32),
              Row(
                children: [
                  SkeletonBox(width: 160, height: 50, borderRadius: 12),
                  const SizedBox(width: 16),
                  SkeletonBox(width: 140, height: 50, borderRadius: 12),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Center(
            child: SkeletonBox(
              width: 350,
              height: 350,
              borderRadius: 175,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SkeletonBox(width: 200, height: 200, borderRadius: 100),
        const SizedBox(height: 32),
        const SkeletonBox(width: 100, height: 24, borderRadius: 16),
        const SizedBox(height: 16),
        const SkeletonText(width: 220, height: 32),
        const SizedBox(height: 12),
        const SkeletonText(width: 180, height: 24),
        const SizedBox(height: 20),
        const SkeletonText(width: 280, height: 14),
        const SizedBox(height: 6),
        const SkeletonText(width: 250, height: 14),
        const SizedBox(height: 28),
        SkeletonBox(width: double.infinity, height: 50, borderRadius: 12),
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

/// Services section skeleton placeholder.
class ServicesSkeleton extends StatelessWidget {
  final int itemCount;

  const ServicesSkeleton({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header skeleton
            const SkeletonBox(width: 100, height: 28, borderRadius: 16),
            const SizedBox(height: 20),
            const SkeletonText(width: 200, height: 40),
            const SizedBox(height: 12),
            const SkeletonText(width: 350, height: 16),
            const SizedBox(height: 40),
            // Grid skeleton
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: List.generate(
                itemCount,
                (_) => const ServiceCardSkeleton(),
              ),
            ),
          ],
        ),
      ),
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

/// Portfolio section skeleton placeholder.
class PortfolioSkeleton extends StatelessWidget {
  final int itemCount;
  final bool isMobile;

  const PortfolioSkeleton({
    super.key,
    this.itemCount = 3,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header skeleton
            const SkeletonBox(width: 100, height: 28, borderRadius: 16),
            const SizedBox(height: 20),
            const SkeletonText(width: 220, height: 40),
            const SizedBox(height: 12),
            const SkeletonText(width: 380, height: 16),
            const SizedBox(height: 40),
            // Cards skeleton
            if (isMobile)
              ...List.generate(
                itemCount,
                (_) => const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: SizedBox(height: 320, child: PortfolioCardSkeleton()),
                ),
              )
            else
              SizedBox(
                height: 400,
                child: Row(
                  children: List.generate(
                    itemCount,
                    (_) => const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
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
  }
}
