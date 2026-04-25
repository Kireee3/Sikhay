import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Reusable header widget that implements PreferredSizeWidget.
/// Displays the app name "Sikhay" with a logo and optional back button.
/// 
/// This widget is used as the appBar in Scaffold widgets throughout the app.
/// It provides a consistent header experience with proper spacing and typography.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  /// Callback triggered when the back button is pressed.
  /// If null, the back button is not displayed.
  final VoidCallback? onBackPressed;

  /// Optional title to display in the header.
  /// If null, displays the default app name "Sikhay".
  final String? title;

  /// Whether to show the back button. Defaults to false.
  final bool showBackButton;

  const AppHeader({
    Key? key,
    this.onBackPressed,
    this.title,
    this.showBackButton = false,
  }) : super(key: key);

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
            // Left section: Back button (if enabled)
            if (showBackButton)
              GestureDetector(
                onTap: onBackPressed,
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                  size: AppSpacing.iconMedium,
                ),
              )
            else
              const SizedBox(width: AppSpacing.iconMedium),

            // Center section: Logo and App Name
            Expanded(
              // Expanded allows the center section to take available space
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo placeholder (light bulb icon)
                  const Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.primary,
                    size: AppSpacing.iconLarge,
                  ),
                  const SizedBox(width: AppSpacing.marginSmall),
                  // App name text
                  Text(
                    title ?? 'Sikhay',
                    style: AppTypography.headingSmall.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // Right section: Placeholder for future actions
            const SizedBox(width: AppSpacing.iconMedium),
          ],
        ),
      ),
    );
  }

  /// PreferredSizeWidget implementation - defines the height of the header.
  /// The height includes the status bar and header content.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);
}
//bagong lagay