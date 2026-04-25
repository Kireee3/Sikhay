import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart'; 
import '../../theme/app_locales.dart';
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
class HomeDashboardScreen extends ConsumerWidget {
  final VoidCallback onResumePressed;
  final VoidCallback onViewMapPressed;

  const HomeDashboardScreen({
    super.key,
    required this.onResumePressed,
    required this.onViewMapPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. magically watch the user's profile from Firestore!
    final userProfileAsync = ref.watch(userProfileProvider);

    // 2. Handle the loading state beautifully using Riverpod's .when()
    return userProfileAsync.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error loading profile: $error')),
      ),
      data: (user) {
        // 3. Extract the language and name from the database!
        final lang = user?.preferredLanguage ?? 'en';
        final name = user?.displayName.split(' ').first ?? 'Learner'; // Gets first name

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppHeader(title: 'Sikhay'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreetingSection(name, lang), // Pass the variables down
                const SizedBox(height: AppSpacing.marginXLarge),

                VoyageCard(
                  title: 'Photosynthesis',
                  description: 'The process of light-to-energy conversion in botanical systems.',
                  progressPercentage: 60,
                  onResumePressed: onResumePressed,
                  onViewMapPressed: onViewMapPressed,
                ),
                const SizedBox(height: AppSpacing.marginXLarge),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocales.get(lang, 'explore_topics'), // TRANSLATED!
                      style: AppTypography.headingMedium.copyWith(color: AppColors.textPrimary),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocales.get(lang, 'see_all'), // TRANSLATED!
                        style: AppTypography.bodySmall.copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.marginLarge),

                _buildTopicCardsGrid(),
                const SizedBox(height: AppSpacing.marginLarge),
              ],
            ),
          ),
        );
      },
    );
  }

  // Pass name and lang into the greeting section
  Widget _buildGreetingSection(String name, String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.local_fire_department, color: AppColors.secondary, size: AppSpacing.iconMedium),
                const SizedBox(width: AppSpacing.marginSmall),
                Text('Day 7', style: AppTypography.bodyMedium.copyWith(color: AppColors.textPrimary)),
              ],
            ),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.surfaceLight),
              child: const Icon(Icons.person, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.marginLarge),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${AppLocales.get(lang, 'good_morning')},\n', // TRANSLATED!
                style: AppTypography.headingLarge.copyWith(color: AppColors.textPrimary),
              ),
              TextSpan(
                text: '$name!', // DYNAMIC DB NAME!
                style: AppTypography.headingLarge.copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.marginSmall),

        Text(
          AppLocales.get(lang, 'ready_explore'), // TRANSLATED!
          style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
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