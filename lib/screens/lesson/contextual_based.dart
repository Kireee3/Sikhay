import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../services/ai_explanation_service.dart';

/// Contextual Based content view with AI-powered explanations at 3 difficulty levels.
///
/// Features:
/// - Level 1 (Curious): Basic explanation with real-world connection
/// - Level 2 (Struggling): Simpler explanation with everyday analogy
/// - Level 3 (ELI5): Simplest explanation for 12-year-olds
/// - Dynamic AI-generated content using OpenAI API
class ContextualBased extends StatefulWidget {
  /// Lesson title
  final String title;

  /// Core definition of the concept
  final String coreDefinition;

  /// Concept title for AI prompt
  final String conceptTitle;

  /// Current language code ('en', 'tl', 'ceb')
  final String language;

  /// List of real-world examples (kept for backwards compatibility but not displayed)
  final List<String> examples;

  /// List of practical applications (kept for backwards compatibility but not displayed)
  final List<String> applications;

  /// Context explanation (kept for backwards compatibility but not displayed)
  final String contextExplanation;

  const ContextualBased({
    super.key,
    required this.title,
    this.coreDefinition = '',
    this.conceptTitle = '',
    this.language = 'en',
    this.examples = const [],
    this.applications = const [],
    this.contextExplanation = '',
  });

  @override
  State<ContextualBased> createState() => _ContextualBasedState();
}

class _ContextualBasedState extends State<ContextualBased> {
  /// Current selected difficulty level (1, 2, or 3)
  int _selectedLevel = 1;

  /// AI-generated explanation text
  String? _explanation;

  /// Loading state
  bool _isLoading = false;

  /// Error message
  String? _error;

  final AIExplanationService _aiService = AIExplanationService();

  @override
  void initState() {
    super.initState();
    // Generate initial explanation for Level 1
    _generateExplanation(1);
  }

  /// Convert title to concept ID (e.g., "Nitrogen Fixation" -> "nitrogen_fixation")
  String _getTitleAsConceptId() {
    return widget.title
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('₂', '2')
        .replaceAll('₃', '3');
  }

  /// Generate explanation for the selected level
  Future<void> _generateExplanation(int level) async {
    setState(() {
      _selectedLevel = level;
      _isLoading = true;
      _error = null;
    });

    try {
      final conceptId = _getTitleAsConceptId();
      
      final explanation = await _aiService.generateExplanation(
        conceptTitle: widget.conceptTitle,
        conceptId: conceptId,
        level: level,
        language: widget.language,
      );

      setState(() {
        _explanation = explanation;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to generate explanation: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Level Selector ─────────────────────────────────────────────────
        _buildLevelSelector(),
        const SizedBox(height: AppSpacing.marginLarge),

        // ── Explanation Card ───────────────────────────────────────────────
        if (_isLoading)
          _buildLoadingCard()
        else if (_error != null)
          _buildErrorCard()
        else
          _buildExplanationCard(),
      ],
    );
  }

  /// Build level selector buttons
  Widget _buildLevelSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose your learning level:',
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.marginSmall),
        Row(
          children: [
            _buildLevelButton(
              level: 1,
              label: 'Curious',
              emoji: '🤔',
            ),
            const SizedBox(width: AppSpacing.marginSmall),
            _buildLevelButton(
              level: 2,
              label: 'Struggling',
              emoji: '🤨',
            ),
            const SizedBox(width: AppSpacing.marginSmall),
            _buildLevelButton(
              level: 3,
              label: 'ELI5',
              emoji: '👶',
            ),
          ],
        ),
      ],
    );
  }

  /// Build individual level button
  Widget _buildLevelButton({
    required int level,
    required String label,
    required String emoji,
  }) {
    final isSelected = _selectedLevel == level;

    return Expanded(
      child: GestureDetector(
        onTap: () => _generateExplanation(level),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.paddingMedium,
            horizontal: AppSpacing.paddingSmall,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.borderLight,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          child: Column(
            children: [
              Text(
                emoji,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build explanation card
  Widget _buildExplanationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                '📖',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(width: AppSpacing.marginSmall),
              Expanded(
                child: Text(
                  'Explanation',
                  style: AppTypography.headingSmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.marginMedium),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              _explanation ?? 'No explanation available',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                height: 1.5,
              ),
              maxLines: null,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  /// Build loading card
  Widget _buildLoadingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.marginMedium),
          Text(
            'Generating explanation...',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  /// Build error card
  Widget _buildErrorCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Error',
            style: AppTypography.headingSmall.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.marginSmall),
          Text(
            _error ?? 'An unknown error occurred',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            maxLines: null,
            overflow: TextOverflow.visible,
          ),
          const SizedBox(height: AppSpacing.marginMedium),
          GestureDetector(
            onTap: () => _generateExplanation(_selectedLevel),
            child: Text(
              'Retry',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}