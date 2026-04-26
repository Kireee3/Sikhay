import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../models/concept.dart';
import '../../models/lesson_content.dart';
import '../../widgets/lesson_header.dart';
import '../../widgets/lesson_card.dart';
import 'contextual_based.dart';

/// Lesson View screen displaying dynamic lesson content.
///
/// Features:
/// - Accepts ConceptNode parameter for dynamic content
/// - Enhanced header with centered Sikhay title
/// - Lesson content card with title, description, and visual diagram
/// - Content toggle: Textual Based | Contextual Based (AI-powered)
/// - Dynamic content for all concepts (Nitrogen Cycle stages, etc.)
///
/// Uses SingleChildScrollView for scrollable content.
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

  /// Get lesson content based on concept node ID
  LessonContent _getLessonContent(String conceptId) {
    switch (conceptId) {
      case 'nitrogen_cycle':
        return LessonContent.nitrogenCycle();
      case 'nitrogen_fixation':
        return LessonContent.nitrogenFixation();
      case 'assimilation':
        return LessonContent.assimilation();
      case 'ammonification':
        return LessonContent.ammonification();
      case 'nitrification':
        return LessonContent.nitrification();
      case 'denitrification':
        return LessonContent.denitrification();
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
        return LessonContent.nitrogenCycle();
    }
  }

  /// Handle language change
  void _handleLanguageChange(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
    widget.onLanguageChanged?.call(languageCode);
  }

  /// Handle back button press
  void _handleBackPressed() {
    if (widget.onBackPressed != null) {
      widget.onBackPressed!();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get lesson content for the current concept
    final lessonContent = _getLessonContent(widget.conceptNode.id);

    // Map language code to AI service format
    final aiLanguageCode = _mapLanguageCode(_selectedLanguage);

    // Create contextual content widget with AI-powered explanations
    final contextualContent = ContextualBased(
      title: lessonContent.title,
      conceptTitle: widget.conceptNode.label,
      coreDefinition: lessonContent.title, // Use title as core definition
      language: aiLanguageCode,
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
            // ── Back Button ────────────────────────────────────────────────
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
                    content:
                        Text('Playing audio for ${lessonContent.title}...'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              // Contextual content widget with AI-powered explanations
              contextualContent: contextualContent,
            ),
            const SizedBox(height: AppSpacing.marginLarge),
          ],
        ),
      ),
    );
  }

  /// Map language code from lesson header to AI service format
  String _mapLanguageCode(String lessonLanguageCode) {
    switch (lessonLanguageCode.toLowerCase()) {
      case 'english':
      case 'en':
        return 'en';
      case 'tagalog':
      case 'tl':
      case 'fil':
        return 'tl';
      case 'bisaya':
      case 'ceb':
        return 'ceb';
      default:
        return 'en';
    }
  }
}