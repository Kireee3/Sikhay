import 'package:flutter/material.dart';

class ConstellationPainter extends CustomPainter {
  final Offset center;
  final List<Offset> satellitePositions;
  final double animationProgress; // 0.0 → 1.0, drives line draw-on effect

  const ConstellationPainter({
    required this.center,
    required this.satellitePositions,
    this.animationProgress = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Outer glow pass — wider, more transparent
    final glowPaint = Paint()
      ..color = Colors.tealAccent.withValues(alpha: 0.15 * animationProgress)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // Core line pass — thin, more opaque
    final linePaint = Paint()
      ..color = Colors.teal.withValues(alpha: 0.5 * animationProgress)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    for (final Offset satellitePos in satellitePositions) {
      // Animate the line from center outward by interpolating the endpoint
      final Offset animatedEnd = Offset.lerp(center, satellitePos, animationProgress)!;
      canvas.drawLine(center, animatedEnd, glowPaint);
      canvas.drawLine(center, animatedEnd, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ConstellationPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
           oldDelegate.center != center ||
           oldDelegate.satellitePositions != satellitePositions;
  }
}