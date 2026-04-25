import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../theme/app_locales.dart'; // ADD THIS

class VoyageCard extends StatelessWidget {
  final String title;
  final String description;
  final int progressPercentage;
  final VoidCallback onResumePressed;
  final VoidCallback onViewMapPressed;
  final String lang; // ADD THIS

  const VoyageCard({
    super.key,
    required this.title,
    required this.description,
    required this.progressPercentage,
    required this.onResumePressed,
    required this.onViewMapPressed,
    this.lang = 'English', // ADD THIS
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        border: Border.all(color: AppColors.borderMedium, width: 1.5),
        color: AppColors.surfaceLight,
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      child: Column(
        // Column for vertical arrangement of card content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section with label
          Text(
            AppLocales.get(lang, 'current_voyage'), // TRANSLATED
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
                              AppLocales.get(lang, 'mastery'), // TRANSLATED
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
                    // Explore/Resume button
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
                        progressPercentage == 0
                            ? AppLocales.get(lang, 'explore_lesson') // TRANSLATED
                            : AppLocales.get(lang, 'resume_study'),  // TRANSLATED
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
                        AppLocales.get(lang, 'view_map'), // TRANSLATED
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