import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../widgets/widgets.dart';

/// Home Dashboard screen displaying the main learning interface.
/// 
/// Shows:
/// - Greeting message with user name
/// - Current voyage/topic card with progress
/// - Explore Topics section with topic cards
/// 
/// Uses a Column with SingleChildScrollView for scrollable content.
/// Implements null-safe code with proper widget hierarchy.
class HomeDashboardScreen extends StatelessWidget {
  /// User's name for personalized greeting
  final String userName;

  /// Callback triggered when "Resume Study" is pressed
  final VoidCallback onResumePressed;

  /// Callback triggered when "View Map" is pressed
  final VoidCallback onViewMapPressed;

  const HomeDashboardScreen({
    super.key,
    required this.userName,
    required this.onResumePressed,
    required this.onViewMapPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold for basic Material app structure
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Sikhay',
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView for scrollable content
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingLarge,
          vertical: AppSpacing.paddingLarge,
        ),
        child: Column(
          // Column for vertical arrangement of dashboard content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting section
            _buildGreetingSection(),
            const SizedBox(height: AppSpacing.marginXLarge),

            // Current Voyage Card
            VoyageCard(
              title: 'Photosynthesis',
              description: 'The process of light-to-energy conversion in botanical systems.',
              progressPercentage: 60,
              onResumePressed: onResumePressed,
              onViewMapPressed: onViewMapPressed,
            ),
            const SizedBox(height: AppSpacing.marginXLarge),

            // Explore Topics section header
            Row(
              // Row for side-by-side arrangement of title and link
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Explore Topics',
                  style: AppTypography.headingMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to explore topics
                  },
                  child: Text(
                    'See all categories →',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.marginLarge),

            // Topic cards grid
            _buildTopicCardsGrid(),
            const SizedBox(height: AppSpacing.marginLarge),
          ],
        ),
      ),
    );
  }

  /// Build the greeting section with personalized message
  Widget _buildGreetingSection() {
    return Column(
      // Column for vertical arrangement of greeting elements
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User info row with day counter and avatar
        Row(
          // Row for horizontal arrangement of day counter and avatar
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Day counter with flame emoji
            Row(
              children: [
                const Icon(
                  Icons.local_fire_department,
                  color: AppColors.secondary,
                  size: AppSpacing.iconMedium,
                ),
                const SizedBox(width: AppSpacing.marginSmall),
                Text(
                  'Day 7',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            // User avatar placeholder
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceLight,
              ),
              child: const Icon(
                Icons.person,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.marginLarge),

        // Greeting message
        RichText(
          // RichText for mixed text styling
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Good morning,\n',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              TextSpan(
                text: '$userName!',
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.marginSmall),

        // Subheading
        Text(
          'Ready to explore the constellations of knowledge?',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  /// Build the grid of topic cards
  Widget _buildTopicCardsGrid() {
    return Column(
      // Column for vertical arrangement of topic cards
      children: [
        // First row of topic cards
        Row(
          // Row for side-by-side arrangement of cards
          children: [
            Expanded(
              child: TopicCard(
                title: 'Astrophysics',
                description: 'Orbital Mechanics',
                lessonCount: 12,
                statusText: 'New Content',
                backgroundColor: AppColors.surfaceLight,
                onTap: () {
                  // Navigate to topic
                },
              ),
            ),
            const SizedBox(width: AppSpacing.marginMedium),
            Expanded(
              child: TopicCard(
                title: 'Chemistry',
                description: 'Organic Chemistry',
                lessonCount: 8,
                backgroundColor: AppColors.surfaceLight,
                onTap: () {
                  // Navigate to topic
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.marginMedium),

        // Second row of topic cards (optional)
        Row(
          // Row for side-by-side arrangement of cards
          children: [
            Expanded(
              child: TopicCard(
                title: 'Biology',
                description: 'Cell Biology',
                lessonCount: 15,
                backgroundColor: AppColors.surfaceLight,
                onTap: () {
                  // Navigate to topic
                },
              ),
            ),
            const SizedBox(width: AppSpacing.marginMedium),
            Expanded(
              child: TopicCard(
                title: 'Physics',
                description: 'Quantum Mechanics',
                lessonCount: 10,
                backgroundColor: AppColors.surfaceLight,
                onTap: () {
                  // Navigate to topic
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}