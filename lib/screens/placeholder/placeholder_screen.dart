import 'package:flutter/material.dart';
import 'package:sikhay/constants/app_colors.dart';
import 'package:sikhay/constants/app_spacing.dart';
import 'package:sikhay/constants/app_typography.dart';
import 'package:sikhay/widgets/widgets.dart';

/// Explore screen - placeholder for exploring topics and categories.
/// 
/// This is a placeholder screen that can be extended with more functionality.
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold for basic Material app structure
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Explore',
      ),
      body: Center(
        // Center for centered placeholder content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.explore,
              color: AppColors.primary,
              size: 64,
            ),
            const SizedBox(height: AppSpacing.marginLarge),
            Text(
              'Explore Topics',
              style: AppTypography.headingMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.marginSmall),
            Text(
              'Coming soon...',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Constellation screen - placeholder for viewing learning constellations.
/// 
/// This is a placeholder screen that can be extended with more functionality.
class ConstellationScreen extends StatelessWidget {
  const ConstellationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold for basic Material app structure
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Constellation',
      ),
      body: Center(
        // Center for centered placeholder content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              color: AppColors.primary,
              size: 64,
            ),
            const SizedBox(height: AppSpacing.marginLarge),
            Text(
              'Learning Constellations',
              style: AppTypography.headingMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.marginSmall),
            Text(
              'Coming soon...',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Profile screen - placeholder for user profile and settings.
/// 
/// This is a placeholder screen that can be extended with more functionality.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold for basic Material app structure
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Profile',
      ),
      body: Center(
        // Center for centered placeholder content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: AppColors.primary,
              size: 64,
            ),
            const SizedBox(height: AppSpacing.marginLarge),
            Text(
              'User Profile',
              style: AppTypography.headingMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.marginSmall),
            Text(
              'Coming soon...',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}