import 'dart:ui';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  // Static registry to track registered view types (prevents duplicate registration)
  static final Set<String> _registeredViewTypes = {};
  
  String? _currentVideoUrl;
  String? _iframeViewType;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Delay initialization to avoid issues during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeVideoFromController();
    });
  }

  void _initializeVideoFromController() {
    final hero = widget.controller.heroSection.value;
    final videoUrl = hero?.videoUrl;
    if (videoUrl != null && videoUrl.isNotEmpty) {
      _initializeVideo(videoUrl);
    }
  }

  void _initializeVideo(String videoUrl) {
    if (_currentVideoUrl == videoUrl && _isInitialized) return;
    
    _currentVideoUrl = videoUrl;
    
    // Create stable view type based on URL hash
    final viewType = 'video-embed-${videoUrl.hashCode.abs()}';
    
    // Only register if not already registered
    if (!_registeredViewTypes.contains(viewType)) {
      final embedUrl = _getEmbedUrl(videoUrl);
      if (embedUrl == null) return;
      
      _registeredViewTypes.add(viewType);
      
      // Check if it's a direct video file
      if (videoUrl.contains('.mp4') || videoUrl.contains('.webm') || videoUrl.contains('.ogg')) {
        ui_web.platformViewRegistry.registerViewFactory(
          viewType,
          (int viewId) => html.VideoElement()
            ..src = videoUrl
            ..autoplay = true
            ..muted = true
            ..loop = true
            ..controls = true
            ..style.width = '100%'
            ..style.height = '100%'
            ..style.objectFit = 'cover'
            ..style.borderRadius = '24px',
        );
      } else {
        // YouTube/Vimeo iframe
        ui_web.platformViewRegistry.registerViewFactory(
          viewType,
          (int viewId) => html.IFrameElement()
            ..src = embedUrl
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%'
            ..allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share'
            ..allowFullscreen = true,
        );
      }
    }
    
    _iframeViewType = viewType;
    
    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  String? _getEmbedUrl(String url) {
    // YouTube URL patterns
    final youtubeRegex = RegExp(
      r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
    );
    final youtubeMatch = youtubeRegex.firstMatch(url);
    if (youtubeMatch != null) {
      final videoId = youtubeMatch.group(1);
      // Autoplay, muted, loop, and controls
      return 'https://www.youtube.com/embed/$videoId?autoplay=1&mute=1&loop=1&playlist=$videoId&controls=1&rel=0&modestbranding=1';
    }

    // Vimeo URL patterns
    final vimeoRegex = RegExp(r'vimeo\.com\/(\d+)');
    final vimeoMatch = vimeoRegex.firstMatch(url);
    if (vimeoMatch != null) {
      final videoId = vimeoMatch.group(1);
      return 'https://player.vimeo.com/video/$videoId?autoplay=1&muted=1&loop=1&background=0';
    }

    // Direct video URL (MP4, WebM) - return as-is
    if (url.contains('.mp4') || url.contains('.webm') || url.contains('.ogg')) {
      return url;
    }

    // Try as YouTube video ID directly
    if (url.length == 11 && !url.contains('/') && !url.contains('.')) {
      return 'https://www.youtube.com/embed/$url?autoplay=1&mute=1&loop=1&playlist=$url&controls=1&rel=0&modestbranding=1';
    }

    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

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

      // Initialize video if URL changed
      if (hasVideo && videoUrl != _currentVideoUrl) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _initializeVideo(videoUrl);
        });
      }

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
            child: _buildVideoContent(hasVideo, videoContainerHeight),
          ),
        ),
      );
    });
  }

  Widget _buildVideoContent(bool hasVideo, double height) {
    if (!hasVideo) {
      return _buildPlaceholder(height, 'Video Coming Soon');
    }

    if (!_isInitialized || _iframeViewType == null) {
      return _buildLoadingState(height);
    }

    return _buildVideoPlayer(height);
  }

  Widget _buildLoadingState(double height) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _GridPatternPainter(),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primary.withOpacity(0.8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Loading video...',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVideoPlayer(double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: HtmlElementView(viewType: _iframeViewType!),
      ),
    );
  }

  Widget _buildPlaceholder(double height, String message) {
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
        AnimatedBuilder(
          animation: widget.controller.pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: widget.controller.pulseAnimation.value,
              child: Container(
                width: playButtonSize,
                height: playButtonSize,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.grey, Colors.grey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
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
              message,
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
