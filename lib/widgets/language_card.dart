import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';
import '../models/onboarding_models.dart';

/// Reusable card widget for language selection in onboarding.
/// 
/// Displays a language option with flag emoji and name.
/// Can be selected/deselected with visual feedback.
/// Uses a Row layout with proper spacing and styling.
class LanguageCard extends StatelessWidget {
  /// The language data to display
  final Language language;

  /// Whether this language is currently selected
  final bool isSelected;

  /// Callback triggered when the card is tapped
  final VoidCallback onTap;

  const LanguageCard({
    Key? key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Container with conditional border styling based on selection state
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          border: Border.all(
            // Cyan border when selected, dark border when not
            color: isSelected ? AppColors.primary : AppColors.borderMedium,
            width: isSelected ? 2.0 : 1.5,
          ),
          // Dark background surface
          color: AppColors.surfaceLight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingLarge,
          vertical: AppSpacing.paddingMedium,
        ),
        child: Row(
          // Row layout for horizontal arrangement of flag and text
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flag emoji
            Text(
              language.flagEmoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: AppSpacing.marginMedium),
            // Language name
            Text(
              language.name,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//bagong lagay