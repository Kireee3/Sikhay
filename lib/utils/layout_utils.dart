import 'dart:math';
import 'package:flutter/material.dart';

/// Utility functions for layout calculations in the constellation map.

/// Calculate positions for satellite nodes arranged in a circle around a center point.
/// 
/// This function distributes [count] nodes evenly around a circle with the given [radius]
/// centered at [center]. Each node is positioned at equal angular intervals.
/// 
/// Parameters:
/// - [count]: Number of satellite nodes to position
/// - [center]: The center point around which nodes are arranged
/// - [radius]: The distance from center to each satellite node
/// 
/// Returns: List of Offset positions for each satellite node
List<Offset> calculateSatellitePositions({
  required int count,
  required Offset center,
  required double radius,
}) {
  // List to store calculated positions
  final positions = <Offset>[];

  // Handle edge case: no satellites
  if (count == 0) return positions;

  // Calculate angle between each satellite (360 degrees / number of satellites)
  final angleStep = (2 * pi) / count;

  // Generate position for each satellite
  for (int i = 0; i < count; i++) {
    // Calculate angle for this satellite (starting from top, going clockwise)
    // Subtract pi/2 to start from top (12 o'clock position)
    final angle = (i * angleStep) - (pi / 2);

    // Calculate x and y coordinates using trigonometry
    final x = center.dx + radius * cos(angle);
    final y = center.dy + radius * sin(angle);

    // Add calculated position to list
    positions.add(Offset(x, y));
  }

  return positions;
}

/// Calculate the distance between two Offset points.
/// 
/// Uses the Euclidean distance formula: sqrt((x2-x1)² + (y2-y1)²)
/// 
/// Parameters:
/// - [point1]: First point
/// - [point2]: Second point
/// 
/// Returns: Distance between the two points
double calculateDistance(Offset point1, Offset point2) {
  final dx = point2.dx - point1.dx;
  final dy = point2.dy - point1.dy;
  return sqrt(dx * dx + dy * dy);
}

/// Check if a point is within a circular hit area.
/// 
/// Used for detecting tap interactions on nodes.
/// 
/// Parameters:
/// - [tapPoint]: The point where user tapped
/// - [nodeCenter]: The center of the node
/// - [nodeRadius]: The radius of the node's hit area
/// 
/// Returns: true if tap is within the node's hit area
bool isPointInCircle(
  Offset tapPoint,
  Offset nodeCenter,
  double nodeRadius,
) {
  return calculateDistance(tapPoint, nodeCenter) <= nodeRadius;
}

/// Interpolate between two Offset values with easing.
/// 
/// Parameters:
/// - [begin]: Starting offset
/// - [end]: Ending offset
/// - [progress]: Animation progress (0.0 to 1.0)
/// - [curve]: Animation curve to apply (default: linear)
/// 
/// Returns: Interpolated offset at the given progress
Offset offsetLerpWithCurve({
  required Offset begin,
  required Offset end,
  required double progress,
  Curve curve = Curves.linear,
}) {
  // Apply curve to progress value
  final curvedProgress = curve.transform(progress);
  
  // Use Flutter's built-in Offset.lerp for interpolation
  return Offset.lerp(begin, end, curvedProgress) ?? begin;
}