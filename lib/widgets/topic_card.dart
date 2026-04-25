import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Reusable card widget for displaying topic cards in the Explore Topics section.
/// 
/// Shows topic title, description, lesson count, and status badge.
/// Uses a Column layout with proper spacing and styling.
class TopicCard extends StatelessWidget {
  /// The title of the topic
  final String title;

  /// The description of the topic
  final String description;

  /// The number of lessons in this topic
  final int lessonCount;

  /// Optional status text (e.g., "New Content")
  final String? statusText;

  /// Optional background color for the card
  final Color? backgroundColor;

  /// Callback triggered when the card is tapped
  final VoidCallback? onTap;

  const TopicCard({
    super.key,
    required this.title,
    required this.description,
    required this.lessonCount,
    this.statusText,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Container with border and background styling
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            color: AppColors.borderMedium,
            width: 1.5,
          ),
          color: backgroundColor ?? AppColors.surfaceLight,
        ),
        padding: const EdgeInsets.all(AppSpacing.paddingLarge),
        child: Column(
          // Column for vertical arrangement of card content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.marginMedium),

            // Footer with lesson count and status
            Row(
              // Row layout for horizontal arrangement of lesson count and status
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Lesson count
                Text(
                  '$lessonCount Lessons',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),

                // Status badge (if provided)
                if (statusText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.paddingSmall,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                    child: Text(
                      statusText!,
                      style: AppTypography.captionSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
