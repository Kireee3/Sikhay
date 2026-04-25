// lib/utils/layout_utils.dart

import 'dart:math';
import 'package:flutter/material.dart';

/// Distributes [count] points evenly around a circle.
/// Returns a list of [Offset] values representing each satellite's center.
List<Offset> calculateSatellitePositions({
  required int count,
  required Offset center,
  required double radius,
  double startAngleOffset = 0.0,  // Use this to rotate the whole constellation
}) {
  if (count == 0) return [];

  final List<Offset> positions = [];
  final double startAngle = -pi / 2 + startAngleOffset;
  final double angleStep = (2 * pi) / count;

  for (int i = 0; i < count; i++) {
    final double angle = startAngle + (i * angleStep);
    positions.add(Offset(
      center.dx + radius * cos(angle),
      center.dy + radius * sin(angle),
    ));
  }
  return positions;
}