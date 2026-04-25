import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';

/// Widget for displaying context-based explanation of a lesson topic.
/// 
/// Provides real-world context and practical examples for better understanding.
/// Uses Column layout for vertical arrangement of content.
class ContextualBased extends StatelessWidget {
  /// Topic title
  final String title;

  /// Context-based explanation text
  final String contextExplanation;

  /// Real-world examples
  final List<String> examples;

  /// Practical applications
  final List<String> applications;

  const ContextualBased({
    Key? key,
    required this.title,
    required this.contextExplanation,
    required this.examples,
    required this.applications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // Column for vertical arrangement of contextual content
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Context Explanation Section
        _buildSection(
          title: 'Context',
          content: contextExplanation,
          icon: '🌍',
        ),
        const SizedBox(height: AppSpacing.marginLarge),

        // Real-World Examples Section
        _buildSection(
          title: 'Real-World Examples',
          content: examples.join('\n• '),
          icon: '💡',
          isList: true,
        ),
        const SizedBox(height: AppSpacing.marginLarge),

        // Practical Applications Section
        _buildSection(
          title: 'Practical Applications',
          content: applications.join('\n• '),
          icon: '⚙️',
          isList: true,
        ),
      ],
    );
  }

  /// Build a section with title, icon, and content
  Widget _buildSection({
    required String title,
    required String content,
    required String icon,
    bool isList = false,
  }) {
    return Column(
      // Column for section content
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title with Icon
        Row(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: AppSpacing.marginSmall),
            Text(
              title,
              style: AppTypography.headingSmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.marginSmall),

        // Section Content
        Container(
          // Container for content with background
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            color: AppColors.background,
          ),
          padding: const EdgeInsets.all(AppSpacing.paddingMedium),
          child: Text(
            isList ? '• $content' : content,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

/// Model for contextual lesson content
class ContextualLessonContent {
  final String title;
  final String contextExplanation;
  final List<String> examples;
  final List<String> applications;

  ContextualLessonContent({
    required this.title,
    required this.contextExplanation,
    required this.examples,
    required this.applications,
  });

  /// Example: Photosynthesis contextual content
  factory ContextualLessonContent.photosynthesis() {
    return ContextualLessonContent(
      title: 'Photosynthesis',
      contextExplanation:
          'Photosynthesis is nature\'s way of converting solar energy into chemical energy. Every plant on Earth uses this process to survive and grow. Without photosynthesis, there would be no oxygen for us to breathe and no food chain to sustain life.',
      examples: [
        'Green leaves turning brown in autumn as photosynthesis slows down',
        'Plants growing faster in spring when there\'s more sunlight',
        'Aquatic plants producing oxygen bubbles during the day',
        'Farmers rotating crops to maintain soil nutrients produced by photosynthesis',
      ],
      applications: [
        'Agriculture: Optimizing crop yields by understanding light exposure',
        'Renewable Energy: Developing artificial photosynthesis for clean energy',
        'Climate Change: Using plants to absorb CO2 from the atmosphere',
        'Space Exploration: Growing food on spacecraft using controlled photosynthesis',
      ],
    );
  }
}
//bagong lagay