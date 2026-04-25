import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Reusable card widget for displaying the current learning voyage.
/// 
/// Shows the topic title, description, progress percentage with circular indicator,
/// and action buttons (Resume Study, View Map).
/// Uses a Column layout with nested Row for proper widget hierarchy.
class VoyageCard extends StatelessWidget {
  /// The title of the current voyage/topic
  final String title;

  /// The description of the current voyage/topic
  final String description;

  /// The progress percentage (0-100)
  final int progressPercentage;

  /// Callback triggered when "Resume Study" button is pressed
  final VoidCallback onResumePressed;

  /// Callback triggered when "View Map" button is pressed
  final VoidCallback onViewMapPressed;

  const VoyageCard({
    super.key,
    required this.title,
    required this.description,
    required this.progressPercentage,
    required this.onResumePressed,
    required this.onViewMapPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container with border and background styling
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(
          color: AppColors.borderMedium,
          width: 1.5,
        ),
        color: AppColors.surfaceLight,
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      child: Column(
        // Column for vertical arrangement of card content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section with label
          Text(
            'CURRENT VOYAGE',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textTertiary,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: AppSpacing.marginMedium),

          // Title
          Text(
            title,
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.marginSmall),

          // Description
          Text(
            description,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Progress section with circular indicator
          Row(
            // Row layout for side-by-side arrangement of progress and buttons
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Circular progress indicator
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Stack(
                      // Stack for layering circular progress indicator
                      alignment: Alignment.center,
                      children: [
                        // Background circle
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.borderMedium,
                              width: 3,
                            ),
                          ),
                        ),
                        // Progress circle (simplified with custom paint)
                        CustomPaint(
                          painter: CircularProgressPainter(
                            progress: progressPercentage / 100,
                            color: AppColors.primary,
                          ),
                          size: const Size(100, 100),
                        ),
                        // Progress text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$progressPercentage%',
                              style: AppTypography.headingSmall.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              'Mastery',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.marginLarge),

              // Action buttons
              Expanded(
                child: Column(
                  // Column for vertical arrangement of buttons
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Resume Study button
                    ElevatedButton(
                      onPressed: onResumePressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.neutral,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.paddingMedium,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
                        ),
                      ),
                      child: Text(
                        progressPercentage == 0 ? 'Explore the Lesson' : 'Resume Study',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.neutral,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.marginSmall),

                    // View Map button
                    OutlinedButton(
                      onPressed: onViewMapPressed,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(
                          color: AppColors.borderMedium,
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.paddingMedium,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
                        ),
                      ),
                      child: Text(
                        'View Map',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom painter for drawing circular progress indicator.
/// Draws an arc representing the progress percentage.
class CircularProgressPainter extends CustomPainter {
  /// Progress value between 0 and 1
  final double progress;

  /// Color of the progress arc
  final Color color;

  CircularProgressPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 5;

    // Draw progress arc
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * 3.14159 / 180, // Start from top
      progress * 360 * 3.14159 / 180, // Sweep angle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
