import 'package:flutter/material.dart';

/// Reusable gradient text widget applying DRY principle.
class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<Color> colors;
  final List<double>? stops;
  final TextAlign? textAlign;

  const GradientText({
    super.key,
    required this.text,
    this.style,
    required this.colors,
    this.stops,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        stops: stops,
      ).createShader(bounds),
      child: Text(
        text,
        style: style?.copyWith(color: Colors.white) ??
            const TextStyle(color: Colors.white),
        textAlign: textAlign,
      ),
    );
  }
}
