//home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // <--- ADDED
import 'package:sikhay/constants/app_colors.dart';
import 'package:sikhay/constants/app_spacing.dart';
import 'package:sikhay/constants/app_typography.dart';
import 'package:sikhay/widgets/widgets.dart';
import 'package:sikhay/providers/auth_provider.dart';   // <--- ADDED
import 'package:sikhay/theme/app_locales.dart';         // <--- ADDED

class HomeDashboardScreen extends ConsumerWidget { // <--- CHANGED TO CONSUMER WIDGET
  final VoidCallback onResumePressed;
  final VoidCallback onViewMapPressed;

  const HomeDashboardScreen({
    super.key,
    // Removed userName here, Riverpod handles it!
    required this.onResumePressed,
    required this.onViewMapPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the user profile from the database
    final userProfileAsync = ref.watch(userProfileProvider);

    return userProfileAsync.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ),
      error: (error, stack) => Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: Text('Error: $error', style: TextStyle(color: Colors.white))),
      ),
      data: (user) {
        // Extract language and name (with safe fallbacks)
        final lang = user?.preferredLanguage ?? 'English';
        final name = user?.displayName.split(' ').first ?? 'Learner';

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppHeader(title: 'Sikhay'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.paddingLarge,
              vertical: AppSpacing.paddingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreetingSection(name, lang), // Passed to the greeting
                const SizedBox(height: AppSpacing.marginLarge),

                VoyageCard(
                  title: 'Nitrogen Cycle',
                  description: AppLocales.get(lang, 'nitrogen_desc'),
                  progressPercentage: 0, // This should come from the user's progress data
                  onResumePressed: onResumePressed,
                  onViewMapPressed: onViewMapPressed,
                  lang: lang,
                ),
                const SizedBox(height: AppSpacing.marginLarge),

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

                _buildTopicCardsGrid(lang),
                const SizedBox(height: AppSpacing.marginLarge),
              ],
            ),
          ),
        );
      },
    );
  }

  // Update the greeting section to accept the name and language strings
  Widget _buildGreetingSection(String name, String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [

                const SizedBox(width: AppSpacing.marginSmall),

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
                text: '$name!', // DYNAMIC DATABASE NAME!
                style: AppTypography.headingLarge.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
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
  Widget _buildTopicCardsGrid(String lang) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TopicCard(
                title: 'English',
                description: 'Passive and Active Voice',
                lessonCount: '8 ${AppLocales.get(lang, 'lessons')}', 
                statusText: AppLocales.get(lang, 'soon'),
                backgroundColor: AppColors.surfaceLight,
                onTap: () {},
              ),
            ),
            const SizedBox(width: AppSpacing.marginMedium),
            Expanded(
              child: TopicCard(
                title: 'Chemistry',
                description: 'Organic Chemistry',
                lessonCount: '12 ${AppLocales.get(lang, 'lessons')}',
                statusText: AppLocales.get(lang, 'soon'),
                backgroundColor: AppColors.surfaceLight,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.marginMedium),
        Row(
          children: [
            Expanded(
              child: TopicCard(
                title: 'Mathematics',
                description: 'Algrebraic Expressions',
                lessonCount: '10 ${AppLocales.get(lang, 'lessons')}',
                statusText: AppLocales.get(lang, 'soon'),
                backgroundColor: AppColors.surfaceLight,
                onTap: () {},
              ),
            ),
            const SizedBox(width: AppSpacing.marginMedium),
            Expanded(
              child: TopicCard(
                title: 'Physics',
                description: 'Newton''s Law',
                lessonCount: '15 ${AppLocales.get(lang, 'lessons')}',
                statusText: AppLocales.get(lang, 'soon'),
                backgroundColor: AppColors.surfaceLight,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
//bagong lagay