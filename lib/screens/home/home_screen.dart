//home_screen.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_locales.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../widgets/widgets.dart';

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
    final userProfileAsync = ref.watch(userProfileProvider);

    return userProfileAsync.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Error loading profile: $error')),
      ),
      data: (user) {
        final lang = user?.preferredLanguage ?? 'English';
        final name = user?.displayName.split(' ').first ?? 'Learner';

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppHeader(title: 'Sikhay'),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGreetingSection(name, lang),
                const SizedBox(height: AppSpacing.marginXLarge),

                VoyageCard(
                  title: 'Nitrogen Cycle',
                  description: AppLocales.get(lang, 'nitrogen_desc'),
                  progressPercentage: 0, // Back to 0
                   lang: lang, // ADD THIS
                  onResumePressed: onResumePressed,
                  onViewMapPressed: onViewMapPressed,
            ),
                const SizedBox(height: AppSpacing.marginXLarge),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocales.get(lang, 'explore_topics'),
                      style: AppTypography.headingMedium.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        AppLocales.get(lang, 'see_all'),
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.marginLarge),

                _buildTopicCardsGrid(lang), // Pass lang here
                const SizedBox(height: AppSpacing.marginLarge),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGreetingSection(String name, String lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.local_fire_department,
                    color: AppColors.secondary, size: AppSpacing.iconMedium),
                const SizedBox(width: AppSpacing.marginSmall),
                Text('Day 7',
                    style: AppTypography.bodyMedium
                        .copyWith(color: AppColors.textPrimary)),
              ],
            ),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.surfaceLight),
              child: const Icon(Icons.person, color: AppColors.textSecondary),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.marginLarge),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '${AppLocales.get(lang, 'good_morning')},\n',
                style: AppTypography.headingLarge
                    .copyWith(color: AppColors.textPrimary),
              ),
              TextSpan(
                text: '$name!',
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
          AppLocales.get(lang, 'ready_explore'),
          style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildTopicCardsGrid(String lang) {
    return Column(
      // Column for vertical arrangement of topic cards
      children: [
        // First row of topic cards
        Row(
          // Row for side-by-side arrangement of cards
          children: [
            Expanded(
              child: TopicCard(
                title: 'Kleb Cycle',              // FIXED title
                description: AppLocales.get(lang, 'coming_soon'),
                lessonCount: 0,
                statusText: AppLocales.get(lang, 'new_content_badge'), // TRANSLATED
                backgroundColor: AppColors.surfaceLight,
                lang: lang,
                onTap: () {
                  // Navigate to topic
                },
              ),
            ),
            const SizedBox(width: AppSpacing.marginMedium),
            Expanded(
              child: TopicCard(
                title: 'Photosynthesis',
                description: AppLocales.get(lang, 'coming_soon'), // TRANSLATED
                lessonCount: 0,
                statusText: AppLocales.get(lang, 'soon_badge'),   // TRANSLATED
                backgroundColor: AppColors.surfaceLight,
                lang: lang,
                onTap: () {
                  // Do nothing, coming soon
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
                title: 'Cell Biology',
                description: AppLocales.get(lang, 'coming_soon'), // TRANSLATED
                lessonCount: 0,
                statusText: AppLocales.get(lang, 'soon_badge'),   // TRANSLATED
                backgroundColor: AppColors.surfaceLight,
                lang: lang,
                onTap: () {
                  // Do nothing, coming soon
                },
              ),
            ),
            const SizedBox(width: AppSpacing.marginMedium),
            Expanded(
              child: TopicCard(
                title: 'Quantum Mechanics',
                description: AppLocales.get(lang, 'coming_soon'), // TRANSLATED
                lessonCount: 0,
                statusText: AppLocales.get(lang, 'soon_badge'),   // TRANSLATED
                backgroundColor: AppColors.surfaceLight,
                lang: lang,
                onTap: () {
                  // Do nothing, coming soon
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}