import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../models/onboarding_model.dart';

/// Reusable button widget for subject selection in onboarding.
/// 
/// Displays a subject option as a toggle button.
/// Can be selected/deselected with visual feedback.
/// Uses proper spacing and typography for consistency.
class SubjectButton extends StatelessWidget {
  /// The subject data to display
  final Subject subject;

  /// Whether this subject is currently selected
  final bool isSelected;

  /// Callback triggered when the button is tapped
  final VoidCallback onTap;

  const SubjectButton({
    super.key,
    required this.subject,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Container with conditional styling based on selection state
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            // Cyan border when selected, dark border when not
            color: isSelected ? AppColors.primary : AppColors.borderMedium,
            width: isSelected ? 2.0 : 1.5,
          ),
          // Primary color background when selected, dark surface when not
          color: isSelected ? AppColors.primary.withValues(alpha: 0.15) : AppColors.surfaceLight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMedium,
          vertical: AppSpacing.paddingSmall,
        ),
        child: Row(
          // Row layout for horizontal arrangement of icon and text
          mainAxisSize: MainAxisSize.min,
          children: [
            // Subject icon/emoji
            Text(
              subject.icon,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: AppSpacing.marginSmall),
            // Subject name
            Text(
              subject.name,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//bagong lagay