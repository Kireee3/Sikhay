import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Enhanced header widget for lesson view with centered Sikhay title.
/// 
/// Displays:
/// - Centered logo and app name (Sikhay)
/// - No language selector
/// - No profile image
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
  @override
  Widget build(BuildContext context) {
    return Container(
      // Container with background color and padding
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingSmall,
        vertical: AppSpacing.paddingMedium,
      ),
      child: SafeArea(
        // SafeArea ensures content is not obscured by system UI
        child: Center(
          // Centered Sikhay title
          child: Row(
            mainAxisSize: MainAxisSize.min,
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