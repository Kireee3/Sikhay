import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Toggle widget to switch between Textual Based and Contextual Based content.
/// 
/// Displays two buttons:
/// - Textual Based: Standard lesson content
/// - Contextual Based: Context-based explanation
/// 
/// Uses Row layout for horizontal arrangement of toggle buttons.
class ContentToggle extends StatelessWidget {
  /// Currently selected content type
  final String selectedContentType;

  /// Callback when content type is changed
  final Function(String) onContentTypeChanged;

  const ContentToggle({
    super.key,
    required this.selectedContentType,
    required this.onContentTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container with background styling for toggle
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        color: AppColors.surfaceLight,
      ),
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: Row(
        // Row for horizontal arrangement of toggle buttons
        children: [
          // Textual Based Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                onContentTypeChanged('textual');
              },
              child: Container(
                // Container for textual button with conditional styling
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  color: selectedContentType == 'textual'
                      ? AppColors.primary
                      : Colors.transparent,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.paddingMedium,
                  horizontal: AppSpacing.paddingSmall,
                ),
                child: Center(
                  child: Text(
                    'Textual Based',
                    style: AppTypography.labelMedium.copyWith(
                      color: selectedContentType == 'textual'
                          ? AppColors.secondary
                          : AppColors.textSecondary,
                      fontWeight: selectedContentType == 'textual'
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.marginSmall),

          // Contextual Based Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                onContentTypeChanged('contextual');
              },
              child: Container(
                // Container for contextual button with conditional styling
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  color: selectedContentType == 'contextual'
                      ? AppColors.primary
                      : Colors.transparent,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.paddingMedium,
                  horizontal: AppSpacing.paddingSmall,
                ),
                child: Center(
                  child: Text(
                    'Contextual Based',
                    style: AppTypography.labelMedium.copyWith(
                      color: selectedContentType == 'contextual'
                          ? AppColors.secondary
                          : AppColors.textSecondary,
                      fontWeight: selectedContentType == 'contextual'
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
