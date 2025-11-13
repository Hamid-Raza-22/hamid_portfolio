import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Neural Grid Painter for AI-inspired background effect
class NeuralGridPainter extends CustomPainter {
  final double animationValue;

  NeuralGridPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.1)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = AppColors.glowBlue.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    // Draw neural network grid
    final gridSize = 150.0;
    final cols = (size.width / gridSize).ceil();
    final rows = (size.height / gridSize).ceil();

    // Draw connections between nodes
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        final x1 = i * gridSize;
        final y1 = j * gridSize;

        // Add wave effect to nodes
        final waveOffset = math.sin((animationValue * 2 * math.pi) + (i + j) * 0.5) * 10;

        // Connect to right neighbor
        if (i < cols - 1) {
          final x2 = (i + 1) * gridSize;
          final y2 = j * gridSize;
          final shouldGlow = ((animationValue * 10 + i + j) % 3).floor() == 0;
          
          canvas.drawLine(
            Offset(x1, y1 + waveOffset),
            Offset(x2, y2 + waveOffset),
            shouldGlow ? glowPaint : paint,
          );
        }

        // Connect to bottom neighbor
        if (j < rows - 1) {
          final x2 = i * gridSize;
          final y2 = (j + 1) * gridSize;
          final shouldGlow = ((animationValue * 10 + i + j) % 3).floor() == 1;
          
          canvas.drawLine(
            Offset(x1, y1 + waveOffset),
            Offset(x2, y2 + waveOffset),
            shouldGlow ? glowPaint : paint,
          );
        }

        // Draw node
        final nodePaint = Paint()
          ..color = AppColors.neonBlue.withOpacity(0.3 + (math.sin((animationValue * 4 * math.pi) + (i + j)) * 0.2))
          ..style = PaintingStyle.fill;

        canvas.drawCircle(
          Offset(x1, y1 + waveOffset),
          2,
          nodePaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant NeuralGridPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

/// Flowing Waves Painter for dynamic background effect
class FlowingWavesPainter extends CustomPainter {
  final double animationValue;

  FlowingWavesPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    // Draw multiple flowing waves with different speeds and colors
    _drawWave(
      canvas,
      size,
      paint..color = AppColors.primary.withOpacity(0.15),
      animationValue,
      50.0,
      30.0,
      0.0,
    );

    _drawWave(
      canvas,
      size,
      paint..color = AppColors.neonBlue.withOpacity(0.12),
      animationValue,
      70.0,
      40.0,
      0.3,
    );

    _drawWave(
      canvas,
      size,
      paint..color = AppColors.primaryLight.withOpacity(0.10),
      animationValue,
      90.0,
      25.0,
      0.6,
    );
  }

  void _drawWave(
    Canvas canvas,
    Size size,
    Paint paint,
    double progress,
    double amplitude,
    double frequency,
    double phaseShift,
  ) {
    final path = Path();
    final waveCount = 3;

    for (int wave = 0; wave < waveCount; wave++) {
      final yOffset = size.height * (0.3 + (wave * 0.2));
      path.moveTo(0, yOffset);

      for (double x = 0; x <= size.width; x += 5) {
        final y = yOffset +
            math.sin(
                  (x / frequency) + (progress * 2 * math.pi) + phaseShift + (wave * 0.5),
                ) *
                amplitude;
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
      path.reset();
    }
  }

  @override
  bool shouldRepaint(covariant FlowingWavesPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

/// Hexagon Grid Painter for tech-inspired background
class HexagonGridPainter extends CustomPainter {
  final double animationValue;

  HexagonGridPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.borderPrimary.withOpacity(0.1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final hexSize = 60.0;
    final hexHeight = hexSize * math.sqrt(3);
    final cols = (size.width / (hexSize * 1.5)).ceil() + 1;
    final rows = (size.height / hexHeight).ceil() + 1;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final xOffset = col * hexSize * 1.5;
        final yOffset = row * hexHeight + (col.isOdd ? hexHeight / 2 : 0);

        final glowIntensity = math.sin(
          (animationValue * 2 * math.pi) + (row + col) * 0.3,
        ).abs();

        if (glowIntensity > 0.7) {
          paint.color = AppColors.neonBlue.withOpacity(0.3);
          paint.strokeWidth = 2.0;
        } else {
          paint.color = AppColors.borderPrimary.withOpacity(0.1);
          paint.strokeWidth = 1.0;
        }

        _drawHexagon(canvas, Offset(xOffset, yOffset), hexSize, paint);
      }
    }
  }

  void _drawHexagon(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i;
      final x = center.dx + size * math.cos(angle);
      final y = center.dy + size * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant HexagonGridPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

/// Circuit Board Pattern Painter
class CircuitBoardPainter extends CustomPainter {
  final double animationValue;

  CircuitBoardPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = AppColors.primary.withOpacity(0.15)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = AppColors.neonBlue
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = AppColors.glowBlue.withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    // Draw circuit paths
    final random = math.Random(42); // Fixed seed for consistent pattern
    for (int i = 0; i < 30; i++) {
      final x1 = random.nextDouble() * size.width;
      final y1 = random.nextDouble() * size.height;
      final x2 = x1 + (random.nextDouble() * 200 - 100);
      final y2 = y1 + (random.nextDouble() * 200 - 100);

      // Animate some paths
      final pulseProgress = ((animationValue * 3 + i * 0.1) % 1.0);
      if (pulseProgress > 0.5) {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), glowPaint);
      } else {
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
      }

      // Draw nodes
      canvas.drawCircle(Offset(x1, y1), 3, nodePaint);
      canvas.drawCircle(Offset(x2, y2), 3, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CircuitBoardPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
