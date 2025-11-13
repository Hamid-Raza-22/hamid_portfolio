import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Reusable Lottie animation widget with error handling and loading states
class LottieAnimationWidget extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final bool repeat;
  final bool reverse;
  final AnimationController? controller;
  final void Function(LottieComposition)? onLoaded;

  const LottieAnimationWidget({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit,
    this.repeat = true,
    this.reverse = false,
    this.controller,
    this.onLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      repeat: repeat,
      reverse: reverse,
      controller: controller,
      onLoaded: onLoaded,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Icon(
              Icons.animation,
              color: Colors.grey,
              size: 48,
            ),
          ),
        );
      },
    );
  }
}

/// Common Lottie animation paths
class LottieAssets {
  static const String aiBackground = 'assets/lottie/ai_background.json';
  static const String coding = 'assets/lottie/coding.json';
  static const String dataVisualization = 'assets/lottie/data_visualization.json';
  static const String loading = 'assets/lottie/loading.json';
  static const String success = 'assets/lottie/success.json';
  static const String particleNetwork = 'assets/lottie/particle_network.json';
  static const String circuitBoard = 'assets/lottie/circuit_board.json';
  static const String skillProgress = 'assets/lottie/skill_progress.json';
}

/// Preset Lottie animations for common use cases
class LottiePresets {
  /// AI/Tech background animation
  static Widget aiBackground({double? width, double? height}) {
    return LottieAnimationWidget(
      assetPath: LottieAssets.aiBackground,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  /// Coding animation for skills section
  static Widget coding({double? width, double? height}) {
    return LottieAnimationWidget(
      assetPath: LottieAssets.coding,
      width: width ?? 300,
      height: height ?? 300,
    );
  }

  /// Loading animation
  static Widget loading({double size = 100}) {
    return LottieAnimationWidget(
      assetPath: LottieAssets.loading,
      width: size,
      height: size,
    );
  }

  /// Success animation
  static Widget success({
    double size = 120,
    bool repeat = false,
    VoidCallback? onComplete,
  }) {
    return LottieAnimationWidget(
      assetPath: LottieAssets.success,
      width: size,
      height: size,
      repeat: repeat,
      onLoaded: (composition) {
        if (onComplete != null && !repeat) {
          Future.delayed(composition.duration, onComplete);
        }
      },
    );
  }

  /// Particle network animation
  static Widget particleNetwork({double? width, double? height}) {
    return LottieAnimationWidget(
      assetPath: LottieAssets.particleNetwork,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
