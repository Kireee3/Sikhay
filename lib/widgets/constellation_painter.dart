import 'package:flutter/material.dart';

/// Custom painter for drawing animated connecting lines between constellation nodes.
/// 
/// This painter draws lines from the center node to each satellite node.
/// The lines animate in along with the node expansion animation.
/// 
/// Uses CustomPaint to draw lines with gradient colors matching the app theme.
class ConstellationPainter extends CustomPainter {
  /// The center point of the constellation
  final Offset center;

  /// List of satellite node positions
  final List<Offset> satellitePositions;

  /// Animation progress (0.0 to 1.0)
  /// Used to animate line drawing from center outward
  final double animationProgress;

  const ConstellationPainter({
    required this.center,
    required this.satellitePositions,
    required this.animationProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Create paint for drawing lines
    final linePaint = Paint()
      // Use primary color (teal) for lines
      ..color = const Color(0xFF131415).withValues(alpha: 0.6)
      // Set line width
      ..strokeWidth = 1.0
      // Use round line caps for smoother appearance
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw lines from center to each satellite
    for (final satellitePos in satellitePositions) {
      // Calculate the animated endpoint
      // Lines start at center and extend outward based on animation progress
      final animatedEndpoint = Offset.lerp(
        center,
        satellitePos,
        animationProgress,
      )!;

      // Draw line from center to animated endpoint
      canvas.drawLine(center, animatedEndpoint, linePaint);
    }

    // Optional: Draw small circle at center node
    _drawCenterCircle(canvas);
  }

  /// Draw a small decorative circle at the center node
  void _drawCenterCircle(Canvas canvas) {
    final circlePaint = Paint()
      ..color = const Color(0xFF131415).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw circle with radius 60 (center node is 120 diameter)
    canvas.drawCircle(center, 60, circlePaint);
  }

  @override
  bool shouldRepaint(ConstellationPainter oldDelegate) {
    // Repaint if any of these values change
    return oldDelegate.center != center ||
        oldDelegate.satellitePositions != satellitePositions ||
        oldDelegate.animationProgress != animationProgress;
  }

  @override
  bool shouldRebuildSemantics(ConstellationPainter oldDelegate) {
    return false;
  }
}
//bagong lagay