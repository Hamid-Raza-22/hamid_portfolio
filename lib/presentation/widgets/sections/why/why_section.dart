import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/responsive_constants.dart';
import '../../../controllers/home/home_controller.dart';
import '../../common/common_widgets.dart';

/// Why Choose Me section.
class WhySection extends GetView<HomeController> {
  const WhySection({super.key});

  @override
  Widget build(BuildContext context) {
    final useColumnLayout = ResponsiveValue.get<bool>(
      context,
      mobile: true,
      smallTablet: true,
      tablet: false,
      desktop: false,
    );

    return AnimatedBuilder(
      animation: controller.heroFadeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 60 * (1 - controller.heroFadeAnimation.value)),
          child: Opacity(
            opacity: controller.heroFadeAnimation.value,
            child: Container(
              padding: ResponsivePadding.all(context, multiplier: 1.5),
              child: useColumnLayout
                  ? _buildColumnLayout(context)
                  : _buildRowLayout(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildColumnLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _WhyTextContent(textAlign: TextAlign.center, stats: controller.stats),
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 40, desktop: 50)),
        _VideoSection(controller: controller, isColumnLayout: true),
      ],
    );
  }

  Widget _buildRowLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _WhyTextContent(textAlign: TextAlign.left, stats: controller.stats),
        ),
        SizedBox(width: ResponsiveValue.get<double>(context, mobile: 0, desktop: 60)),
        Expanded(
          flex: 3,
          child: _VideoSection(controller: controller, isColumnLayout: false),
        ),
      ],
    );
  }
}

class _WhyTextContent extends StatelessWidget {
  final TextAlign textAlign;
  final RxList stats;

  const _WhyTextContent({
    required this.textAlign,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    final isCentered = textAlign == TextAlign.center;

    return Column(
      crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SectionBadge(
          text: 'WHY CHOOSE ME',
          color: AppColors.accent,
          icon: Icons.verified_rounded,
        ),
        const SizedBox(height: 24),
        GradientText(
          text: 'Delivering Excellence\nIn Every Project',
          colors: const [Colors.white, AppColors.primaryLight, AppColors.accent],
          stops: const [0.0, 0.5, 1.0],
          style: ResponsiveTextStyle.headline(context).copyWith(
            fontSize: ResponsiveValue.get<double>(context, mobile: 30, smallTablet: 34, tablet: 38, desktop: 42),
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -1,
          ),
          textAlign: textAlign,
        ),
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 20, desktop: 24)),
        SizedBox(
          width: ResponsiveValue.get<double>(context, mobile: double.infinity, desktop: 400),
          child: Text(
            'With years of experience in Flutter development and a passion for creating exceptional digital experiences, I bring dedication and expertise to every project.',
            style: TextStyle(
              fontSize: ResponsiveValue.get<double>(context, mobile: 15, desktop: 16),
              height: 1.7,
              color: AppColors.textSecondary,
            ),
            textAlign: textAlign,
          ),
        ),
        SizedBox(height: ResponsiveValue.get<double>(context, mobile: 28, desktop: 36)),
        _StatsRow(isCentered: isCentered, stats: stats),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  final bool isCentered;
  final RxList stats;

  const _StatsRow({
    required this.isCentered,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Wrap(
      alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
      spacing: ResponsiveValue.get<double>(context, mobile: 24, desktop: 40),
      runSpacing: 16,
      children: stats.map((stat) {
        return _StatItem(value: stat.value, label: stat.label);
      }).toList(),
    ));
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientText(
          text: value,
          colors: AppColors.primaryGradient,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            height: 1.3,
          ),
        ),
      ],
    );
  }
}

class _VideoSection extends StatefulWidget {
  final HomeController controller;
  final bool isColumnLayout;

  const _VideoSection({
    required this.controller,
    required this.isColumnLayout,
  });

  @override
  State<_VideoSection> createState() => _VideoSectionState();
}

class _VideoSectionState extends State<_VideoSection> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final videoContainerHeight = ResponsiveValue.get<double>(
      context,
      mobile: 300,
      smallTablet: 320,
      tablet: 340,
      desktop: 360,
    );

    final videoContainerWidth = widget.isColumnLayout
        ? MediaQuery.of(context).size.width * 0.9
        : double.infinity;

    return Obx(() {
      final hero = widget.controller.heroSection.value;
      final videoUrl = hero?.videoUrl;
      final hasVideo = videoUrl != null && videoUrl.isNotEmpty;

      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: videoContainerWidth,
            height: videoContainerHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.cardBg.withOpacity(0.8),
                  AppColors.cardBgLight.withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColors.glassBorder,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.1),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: hasVideo && _isPlaying
                ? _buildVideoPlayer(videoUrl, videoContainerHeight)
                : _buildVideoPlaceholder(hasVideo, videoContainerHeight),
          ),
        ),
      );
    });
  }

  Widget _buildVideoPlayer(String videoUrl, double height) {
    // Check if it's a YouTube/Vimeo URL and get embed URL
    final embedUrl = _getEmbedUrl(videoUrl);
    
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                embedUrl != null ? Icons.play_circle_fill : Icons.videocam,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              Text(
                embedUrl != null ? 'Video Ready' : 'External Video',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _launchVideoUrl(embedUrl ?? videoUrl),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Watch Video'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: IconButton(
            onPressed: () => setState(() => _isPlaying = false),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPlaceholder(bool hasVideo, double height) {
    final playButtonSize = ResponsiveValue.get<double>(context, mobile: 70, desktop: 80);
    final playIconSize = ResponsiveValue.get<double>(context, mobile: 32, desktop: 36);

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPatternPainter(),
          ),
        ),
        Icon(
          Icons.video_library_rounded,
          size: ResponsiveValue.get<double>(context, mobile: 60, desktop: 80),
          color: AppColors.textMuted.withOpacity(0.3),
        ),
        GestureDetector(
          onTap: hasVideo ? () => setState(() => _isPlaying = true) : null,
          child: AnimatedBuilder(
            animation: widget.controller.pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.controller.pulseAnimation.value,
                child: Container(
                  width: playButtonSize,
                  height: playButtonSize,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: hasVideo
                          ? AppColors.primaryGradient
                          : [Colors.grey.shade600, Colors.grey.shade700],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: hasVideo
                            ? AppColors.primary.withOpacity(0.5)
                            : Colors.grey.withOpacity(0.3),
                        blurRadius: 25,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: playIconSize,
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.glassBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Text(
              hasVideo ? 'Click to Play' : 'Video Coming Soon',
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? _getEmbedUrl(String url) {
    // YouTube URL patterns - detect if it's a YouTube video
    final youtubeRegex = RegExp(
      r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
    );
    if (youtubeRegex.hasMatch(url)) {
      return url; // Return original URL for external launch
    }

    // Vimeo URL patterns
    final vimeoRegex = RegExp(r'vimeo\.com\/(\d+)');
    if (vimeoRegex.hasMatch(url)) {
      return url; // Return original URL for external launch
    }

    return null;
  }

  Future<void> _launchVideoUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Error',
        'Could not open video',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.glassBorder.withOpacity(0.3)
      ..strokeWidth = 0.5;

    const spacing = 30.0;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
