import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Card widget for displaying lesson content with content type toggle.
/// 
/// Displays:
/// - Subject and level badges
/// - Lesson title
/// - Content type toggle (Textual Based / Contextual Based)
/// - Lesson description with audio icon (for textual mode)
/// - Visual diagram with process flow
/// - Audio visualization
/// - Contextual content (for contextual mode)
/// 
/// Uses Column and Row layout for proper widget hierarchy.
class LessonCard extends StatefulWidget {
  /// Subject name (e.g., "Biology")
  final String subject;

  /// Level indicator (e.g., "Level 2")
  final String level;

  /// Lesson title (e.g., "Photosynthesis")
  final String title;

  /// Lesson description text
  final String description;

  /// Whether audio is available
  final bool hasAudio;

  /// Callback when audio button is pressed
  final VoidCallback? onAudioPressed;

  /// Widget to display for contextual based content
  final Widget? contextualContent;

  const LessonCard({
    super.key,
    required this.subject,
    required this.level,
    required this.title,
    required this.description,
    this.hasAudio = true,
    this.onAudioPressed,
    this.contextualContent,
  });

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  /// Currently selected content type
  String _contentType = 'textual';

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
        // Column for vertical arrangement of card content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject and Level badges
          Row(
            // Row for horizontal arrangement of badges
            children: [
              // Subject badge
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  border: Border.all(
                    color: AppColors.borderMedium,
                    width: 1.0,
                  ),
                  color: Colors.transparent,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                  vertical: AppSpacing.paddingSmall,
                ),
                child: Text(
                  widget.subject,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.marginSmall),

              // Level badge
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingMedium,
                  vertical: AppSpacing.paddingSmall,
                ),
                child: Text(
                  widget.level,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Lesson Title
          Text(
            widget.title,
            style: AppTypography.headingLarge.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Content Type Toggle (if contextual content is available)
          if (widget.contextualContent != null) ...[
            _buildContentToggle(),
            const SizedBox(height: AppSpacing.marginLarge),
          ],

          // Display content based on selected type
          if (_contentType == 'textual')
            _buildTextualContent()
          else
            widget.contextualContent ?? _buildTextualContent(),
        ],
      ),
    );
  }

  /// Build textual based content
  Widget _buildTextualContent() {
    return Column(
      // Column for textual content arrangement
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description with Audio Button
        Row(
          // Row for horizontal arrangement of description and audio button
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.description,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
            if (widget.hasAudio)
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.marginMedium),
                child: GestureDetector(
                  onTap: widget.onAudioPressed,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                    padding: const EdgeInsets.all(AppSpacing.paddingSmall),
                    child: const Icon(
                      Icons.volume_up,
                      color: AppColors.primary,
                      size: AppSpacing.iconMedium,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.marginLarge),

        // Visual Diagram (Process Flow)
        _buildProcessDiagram(),
        const SizedBox(height: AppSpacing.marginLarge),

        // Audio Visualization
        _buildAudioVisualization(),
      ],
    );
  }

  /// Build content toggle buttons
  Widget _buildContentToggle() {
    return Container(
      // Container with background styling for toggle
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        color: AppColors.background,
      ),
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: Row(
        // Row for horizontal arrangement of toggle buttons
        children: [
          // Textual Based Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _contentType = 'textual';
                });
              },
              child: Container(
                // Container for textual button with conditional styling
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  color: _contentType == 'textual'
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : Colors.transparent,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.paddingMedium,
                  horizontal: AppSpacing.paddingSmall,
                ),
                child: Center(
                  child: Text(
                    'Textual Based',
                    style: AppTypography.labelMedium.copyWith(
                      color: _contentType == 'textual'
                          ? AppColors.neutral
                          : AppColors.textSecondary,
                      fontWeight: _contentType == 'textual'
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.marginSmall),

          // Contextual Based Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _contentType = 'contextual';
                });
              },
              child: Container(
                // Container for contextual button with conditional styling
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
                  color: _contentType == 'contextual'
                      ? AppColors.primary
                      : Colors.transparent,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.paddingMedium,
                  horizontal: AppSpacing.paddingSmall,
                ),
                child: Center(
                  child: Text(
                    'Contextual Based',
                    style: AppTypography.labelMedium.copyWith(
                      color: _contentType == 'contextual'
                          ? AppColors.neutral
                          : AppColors.textSecondary,
                      fontWeight: _contentType == 'contextual'
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the process diagram (Sunlight → Chlorophyll → Oxygen)
  Widget _buildProcessDiagram() {
    return Container(
      // Container for the diagram with background
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        color: AppColors.background,
      ),
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      child: Row(
        // Row for horizontal arrangement of diagram elements
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Sunlight
          Column(
            children: [
              Text(
                '☀️',
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: AppSpacing.marginSmall),
              Text(
                'Sunlight',
                style: AppTypography.caption.copyWith(
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),

          // Arrow
          Text(
            '→',
            style: AppTypography.headingMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),

          // Chlorophyll
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.eco,
                  color: AppColors.background,
                  size: 24,
                ),
              ),
              const SizedBox(height: AppSpacing.marginSmall),
              Text(
                'Chlorophyll',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),

          // Arrow
          Text(
            '→',
            style: AppTypography.headingMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),

          // Oxygen
          Column(
            children: [
              Text(
                '💨',
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: AppSpacing.marginSmall),
              Text(
                'Oxygen',
                style: AppTypography.caption.copyWith(
                  color: AppColors.tertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build audio visualization bars
  Widget _buildAudioVisualization() {
    return Center(
      child: Row(
        // Row for horizontal arrangement of audio bars
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
          (index) {
            final heights = [20.0, 30.0, 40.0, 30.0, 20.0];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 4,
                height: heights[index],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppColors.primary,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
