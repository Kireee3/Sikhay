import 'package:flutter/material.dart';
import 'package:sikhay/constants/app_colors.dart';
import 'package:sikhay/constants/app_spacing.dart';
import 'package:sikhay/constants/app_typography.dart';
import 'package:sikhay/models/concept.dart';
import 'package:sikhay/models/lesson_content.dart';
import 'package:sikhay/widgets/lesson_header.dart';
import 'package:sikhay/widgets/lesson_card.dart';
import 'package:sikhay/widgets/comprehension_check.dart';
import 'package:sikhay/screens/lesson/contextual_based.dart';

/// Lesson View screen displaying dynamic lesson content with comprehension check.
/// 
/// Features:
/// - Accepts ConceptNode parameter for dynamic content
/// - Enhanced header with language selector (English, Tagalog, Bisaya)
/// - Lesson content card with title, description, and visual diagram
/// - Content toggle: Textual Based | Contextual Based
/// - Comprehension check with emoji reactions (😕 🤔 ✅)
/// - Dynamic content for all 6 concepts (Photosynthesis, Chlorophyll, Oxygen, etc.)
/// - "Go Deeper" button REMOVED as per requirements
/// 
/// Uses SingleChildScrollView for scrollable content.
/// Implements null-safe code with proper state management.
class LessonScreen extends StatefulWidget {
  /// The concept node to display lesson for
  final ConceptNode conceptNode;

  /// Callback when back button is pressed
  final VoidCallback? onBackPressed;

  /// Callback when language is changed
  final Function(String)? onLanguageChanged;

  const LessonScreen({
    super.key,
    required this.conceptNode,
    this.onBackPressed,
    this.onLanguageChanged,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  /// Currently selected language
  String _selectedLanguage = 'en';

  /// Currently selected comprehension reaction
  String? _selectedReaction;

  /// Get lesson content based on concept node ID
  LessonContent _getLessonContent(String conceptId) {
    switch (conceptId) {
      case 'photosynthesis':
        return LessonContent.photosynthesis();
      case 'chlorophyll':
        return LessonContent.chlorophyll();
      case 'oxygen':
        return LessonContent.oxygen();
      case 'sunlight':
        return LessonContent.sunlight();
      case 'co2':
        return LessonContent.carbonDioxide();
      case 'glucose':
        return LessonContent.glucose();
      default:
        return LessonContent.photosynthesis();
    }
  }

  /// Handle language change
  void _handleLanguageChange(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
    widget.onLanguageChanged?.call(languageCode);
  }

  /// Handle comprehension reaction selection
  void _handleReactionSelected(String reactionCode) {
    setState(() {
      _selectedReaction = reactionCode;
    });
    // Here you would typically save the reaction to the backend
  }

  /// Handle back button press
  void _handleBackPressed() {
    widget.onBackPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    // Get lesson content for the current concept
    final lessonContent = _getLessonContent(widget.conceptNode.id);

    // Create contextual content widget
    final contextualContent = ContextualBased(
      title: lessonContent.title,
      contextExplanation: lessonContent.contextExplanation,
      examples: lessonContent.examples,
      applications: lessonContent.applications,
    );

    return Scaffold(
      // Scaffold for basic Material app structure
      backgroundColor: AppColors.background,
      appBar: LessonHeader(
        selectedLanguage: _selectedLanguage,
        onLanguageChanged: _handleLanguageChange,
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView for scrollable content
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingLarge,
          vertical: AppSpacing.paddingLarge,
        ),
        child: Column(
          // Column for vertical arrangement of screen content
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Back Button (if onBackPressed is provided) ──────────────────
            if (widget.onBackPressed != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppSpacing.marginLarge,
                ),
                child: GestureDetector(
                  onTap: _handleBackPressed,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: AppSpacing.marginSmall),
                      Text(
                        'Back to Constellation',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // ── Lesson Content Card with Dynamic Content ────────────────────
            LessonCard(
              subject: lessonContent.subject,
              level: lessonContent.level,
              title: lessonContent.title,
              description: lessonContent.textualDescription,
              hasAudio: true,
              onAudioPressed: () {
                // Handle audio playback
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Playing audio for ${lessonContent.title}...'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              // Contextual content widget
              contextualContent: contextualContent,
            ),
            const SizedBox(height: AppSpacing.marginLarge),

            // ── Comprehension Check ────────────────────────────────────────
            ComprehensionCheck(
              selectedReaction: _selectedReaction,
              onReactionSelected: _handleReactionSelected,
            ),
            const SizedBox(height: AppSpacing.marginLarge),
          ],
        ),
      ),
    );
  }
}
