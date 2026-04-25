import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Enhanced header widget for lesson view with language selector.
/// 
/// Displays:
/// - Logo and app name (LinguaMap/Sikhay)
/// - Language selector buttons (English, Tagalog, Bisaya)
/// - No profile image (as per requirements)
/// 
/// Implements PreferredSizeWidget for use as appBar.
class LessonHeader extends StatefulWidget implements PreferredSizeWidget {
  /// Currently selected language code
  final String selectedLanguage;

  /// Callback when language is changed
  final Function(String) onLanguageChanged;

  const LessonHeader({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  State<LessonHeader> createState() => _LessonHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _LessonHeaderState extends State<LessonHeader> {
  /// Language options for the lesson view
  final List<LanguageOption> languages = [
    LanguageOption(code: 'en', label: 'EN', flag: '🇬🇧'),
    LanguageOption(code: 'tl', label: 'TL', flag: '🇵🇭'),
    LanguageOption(code: 'ceb', label: 'CEB', flag: '🇵🇭'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container with background color and padding
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingLarge,
        vertical: AppSpacing.paddingMedium,
      ),
      child: SafeArea(
        // SafeArea ensures content is not obscured by system UI
        child: Row(
          // Row layout for horizontal alignment of header elements
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left section: Logo and App Name
            Row(
              children: [
                // Logo icon
                const Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.primary,
                  size: AppSpacing.iconLarge,
                ),
                const SizedBox(width: AppSpacing.marginSmall),
                // App name
                Text(
                  'Sikhay',
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),

            // Center section: Language Selector
            Container(
              // Container with border for language selector
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
                border: Border.all(
                  color: AppColors.borderMedium,
                  width: 1.5,
                ),
                color: AppColors.surfaceLight,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.paddingSmall,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                // Row for horizontal arrangement of language buttons
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  languages.length,
                  (index) {
                    final language = languages[index];
                    final isSelected = widget.selectedLanguage == language.code;

                    return GestureDetector(
                      onTap: () {
                        widget.onLanguageChanged(language.code);
                      },
                      child: Container(
                        // Container for individual language button
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
                          color: isSelected
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingMedium,
                          vertical: AppSpacing.paddingSmall,
                        ),
                        child: Text(
                          language.label,
                          style: AppTypography.labelMedium.copyWith(
                            color: isSelected
                                ? AppColors.neutral
                                : AppColors.textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Right section: Empty space (no profile image)
            const SizedBox(width: AppSpacing.iconMedium),
          ],
        ),
      ),
    );
  }
}

/// Model for language option in the selector
class LanguageOption {
  final String code;
  final String label;
  final String flag;

  LanguageOption({
    required this.code,
    required this.label,
    required this.flag,
  });
}
