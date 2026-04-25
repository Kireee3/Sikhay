import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Widget for comprehension check with emoji reactions.
/// 
/// Displays:
/// - "Did you get it?" heading
/// - Three emoji reaction buttons (😕 🤔 ✅)
/// - Labels for each reaction
/// 
/// Uses Row layout for horizontal arrangement of reaction buttons.
class ComprehensionCheck extends StatefulWidget {
  /// Callback when a reaction is selected
  final Function(String) onReactionSelected;

  /// Currently selected reaction (if any)
  final String? selectedReaction;

  const ComprehensionCheck({
    Key? key,
    required this.onReactionSelected,
    this.selectedReaction,
  }) : super(key: key);

  @override
  State<ComprehensionCheck> createState() => _ComprehensionCheckState();
}

class _ComprehensionCheckState extends State<ComprehensionCheck> {
  /// Reaction options with emoji and label
  final List<ReactionOption> reactions = [
    ReactionOption(
      emoji: '😕',
      label: 'Still Confusing',
      code: 'confusing',
    ),
    ReactionOption(
      emoji: '🤔',
      label: 'Getting There',
      code: 'getting_there',
    ),
    ReactionOption(
      emoji: '✅',
      label: 'Crystal Clear',
      code: 'clear',
    ),
  ];

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
        // Column for vertical arrangement of comprehension check content
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Heading
          Text(
            'Did you get it?',
            style: AppTypography.headingMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Reaction buttons
          Row(
            // Row for horizontal arrangement of reaction buttons
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: reactions.map((reaction) {
              final isSelected = widget.selectedReaction == reaction.code;

              return GestureDetector(
                onTap: () {
                  widget.onReactionSelected(reaction.code);
                },
                child: Column(
                  // Column for vertical arrangement of emoji and label
                  children: [
                    // Emoji button
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.2)
                            : AppColors.background,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.borderMedium,
                          width: isSelected ? 2.0 : 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          reaction.emoji,
                          style: const TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.marginSmall),

                    // Label
                    SizedBox(
                      width: 80,
                      child: Text(
                        reaction.label,
                        textAlign: TextAlign.center,
                        style: AppTypography.caption.copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textTertiary,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// Model for reaction option
class ReactionOption {
  final String emoji;
  final String label;
  final String code;

  ReactionOption({
    required this.emoji,
    required this.label,
    required this.code,
  });
}
