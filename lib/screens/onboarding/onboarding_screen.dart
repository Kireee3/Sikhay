import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../constants/app_typography.dart';
import '../../models/onboarding_models.dart';

/// Onboarding screen with PageView for multi-step onboarding flow.
/// 
/// Step 1: Language selection (English, Tagalog, Bisaya)
/// Step 2: Subject selection (Science, English, Math)
/// 
/// Uses PageView.builder for smooth sliding transitions between steps.
/// Implements null-safe code with proper state management.
class OnboardingScreen extends StatefulWidget {
  /// Callback triggered when onboarding is completed
  final VoidCallback onOnboardingComplete;

  const OnboardingScreen({
    Key? key,
    required this.onOnboardingComplete,
  }) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  /// Controller for PageView to manage page transitions
  late PageController _pageController;

  /// Currently selected language
  Language? _selectedLanguage;

  /// Set of selected subjects (multiple selection allowed)
  final Set<String> _selectedSubjects = {};

  /// Current page index (0 = language, 1 = subjects)
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Navigate to the next page in the PageView
  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Navigate to the previous page in the PageView
  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Handle completion of onboarding
  void _completeOnboarding() {
    // Here you would typically save the selected language and subjects
    // to local storage or pass them to the app state
    widget.onOnboardingComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        // SafeArea ensures content is not obscured by system UI
        child: Column(
          // Column for vertical arrangement of PageView and controls
          children: [
            // Expanded PageView for the main content
            Expanded(
              child: PageView.builder(
                // PageView.builder for efficient page rendering
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                // Disable swipe to enforce button-based navigation
                itemCount: 2,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // Step 1: Language Selection
                    return _buildLanguageSelectionPage();
                  } else {
                    // Step 2: Subject Selection
                    return _buildSubjectSelectionPage();
                  }
                },
              ),
            ),

            // Bottom navigation buttons
            Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingLarge),
              child: Row(
                // Row for horizontal arrangement of navigation buttons
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button (visible on step 2)
                  if (_currentPage > 0)
                    OutlinedButton(
                      onPressed: _previousPage,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.paddingLarge,
                          vertical: AppSpacing.paddingMedium,
                        ),
                        side: const BorderSide(
                          color: AppColors.borderMedium,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    )
                  else
                    const SizedBox.shrink(),

                  // Next/Complete button
                  ElevatedButton(
                    onPressed: _currentPage == 0
                        ? (_selectedLanguage != null ? _nextPage : null)
                        : (_selectedSubjects.isNotEmpty ? _completeOnboarding : null),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.neutral,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.paddingLarge,
                        vertical: AppSpacing.paddingMedium,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
                      ),
                      disabledBackgroundColor: AppColors.borderMedium,
                    ),
                    child: Text(
                      _currentPage == 0 ? 'Next' : 'Start My Journey',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.neutral,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build the language selection page (Step 1)
  Widget _buildLanguageSelectionPage() {
    return SingleChildScrollView(
      // SingleChildScrollView for scrollable content
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingLarge,
        vertical: AppSpacing.paddingLarge,
      ),
      child: Column(
        // Column for vertical arrangement of page content
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Decorative icon
          const Icon(
            Icons.auto_awesome,
            color: AppColors.primary,
            size: 64,
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Main heading
          RichText(
            // RichText for mixed text styling
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Learn Anything.\n',
                  style: AppTypography.headingXLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: 'In Any Language.',
                  style: AppTypography.headingXLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Subheading
          Text(
            'Pick a Language',
            style: AppTypography.headingMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.marginSmall),

          // Step indicator
          Text(
            'Step 1 of 2',
            style: AppTypography.caption.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Language selection grid
          GridView.builder(
            // GridView.builder for efficient language card rendering
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.marginMedium,
              mainAxisSpacing: AppSpacing.marginMedium,
              childAspectRatio: 1.5,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: availableLanguages.length,
            itemBuilder: (context, index) {
              final language = availableLanguages[index];
              return LanguageCard(
                language: language,
                isSelected: _selectedLanguage == language,
                onTap: () {
                  setState(() {
                    _selectedLanguage = language;
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// Build the subject selection page (Step 2)
  Widget _buildSubjectSelectionPage() {
    return SingleChildScrollView(
      // SingleChildScrollView for scrollable content
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.paddingLarge,
        vertical: AppSpacing.paddingLarge,
      ),
      child: Column(
        // Column for vertical arrangement of page content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading
          Text(
            'What do you want to learn?',
            style: AppTypography.headingMedium.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // Subject selection buttons
          Wrap(
            // Wrap for flexible arrangement of subject buttons
            spacing: AppSpacing.marginMedium,
            runSpacing: AppSpacing.marginMedium,
            children: availableSubjects.map((subject) {
              return SubjectButton(
                subject: subject,
                isSelected: _selectedSubjects.contains(subject.name),
                onTap: () {
                  setState(() {
                    if (_selectedSubjects.contains(subject.name)) {
                      _selectedSubjects.remove(subject.name);
                    } else {
                      _selectedSubjects.add(subject.name);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.marginXLarge),

          // Info text
          Text(
            'No subscription required to explore the map.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}


// Simple placeholders for your custom widgets
class LanguageCard extends StatelessWidget {
  final dynamic language;
  final bool isSelected;
  final VoidCallback onTap;
  const LanguageCard({super.key, required this.language, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap, 
    child: Container(color: isSelected ? Colors.teal : Colors.grey, child: Center(child: Text(language.name))),
  );
}

class SubjectButton extends StatelessWidget {
  final Subject subject; // Use the Subject type instead of dynamic
  final bool isSelected;
  final VoidCallback onTap;

  const SubjectButton({
    super.key,
    required this.subject,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      // We use a Text widget for the avatar because your icon is an emoji String
      avatar: Text(subject.icon, style: const TextStyle(fontSize: 18)),
      label: Text(
        subject.name,
        style: AppTypography.bodyMedium.copyWith(
          color: isSelected ? AppColors.neutral : AppColors.textPrimary,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.borderMedium,
        ),
      ),
    );
  }
}