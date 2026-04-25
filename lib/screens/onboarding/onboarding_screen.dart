import 'package:flutter/material.dart';
import 'package:sikhay/constants/app_colors.dart';
import 'package:sikhay/constants/app_spacing.dart';
import 'package:sikhay/constants/app_typography.dart';
import 'package:sikhay/models/onboarding_model.dart';
import 'package:sikhay/widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onOnboardingComplete;

  const OnboardingScreen({
    super.key,
    required this.onOnboardingComplete,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Language? _selectedLanguage;
  final Set<String> _selectedSubjects = {};

  void _completeOnboarding() {
    widget.onOnboardingComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _buildUnifiedSelectionPage(),
            ),
            // Bottom Action Area
            Padding(
              padding: const EdgeInsets.all(AppSpacing.paddingLarge),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (_selectedLanguage != null && _selectedSubjects.isNotEmpty)
                          ? _completeOnboarding
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.secondary,
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.paddingMedium),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
                        ),
                        disabledBackgroundColor: AppColors.borderMedium,
                      ),
                      child: Text(
                        'Start My Journey',
                        style: AppTypography.labelMedium.copyWith(color: AppColors.secondary),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.marginSmall),
                  Text(
                    'No subscription required to explore the map.',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnifiedSelectionPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      child: Column(
        children: [
          Image.asset(
            '../assets/images/sikhay-logo.png',
            width: 64,
            height: 64,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: AppSpacing.marginLarge),
          Text(
            'Ang tulay mula sa salita patungo sa unawa.',
            style: AppTypography.headingSmall.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.marginLarge),

          // --- LANGUAGE SECTION ---
          _sectionHeader('Pick a Language'),
          const SizedBox(height: AppSpacing.marginMedium),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.marginMedium,
              mainAxisSpacing: AppSpacing.marginMedium,
              childAspectRatio: 1.8, // Adjusted for the new horizontal card look
            ),
            itemCount: availableLanguages.length,
            itemBuilder: (context, index) {
              final language = availableLanguages[index];
              return CustomLanguageCard(
                language: language,
                isSelected: _selectedLanguage == language,
                onTap: () => setState(() => _selectedLanguage = language),
              );
            },
          ),

          const SizedBox(height: AppSpacing.marginLarge),

          // --- SUBJECT SECTION ---
          _sectionHeader('What do you want to learn?'),
          const SizedBox(height: AppSpacing.marginMedium),
          Wrap(
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
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTypography.headingMedium.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}

// --- THIS IS THE SEPARATE WIDGET FOR THE GLOWING CARD ---
class CustomLanguageCard extends StatelessWidget {
  final Language language;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomLanguageCard({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color baseCardColor = const Color(0xFF1B262C); // Darker background
    final Color selectedTeal = const Color(0xFF1ABC9C); 
    final Color mintTealText = const Color(0xFF2ECC71); 
    final Color unselectedBorder = const Color(0xFF1ABC9C).withValues(alpha: 0.3);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF163C40) : baseCardColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXLarge),
          border: Border.all(
            color: isSelected ? selectedTeal : unselectedBorder,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: selectedTeal.withValues(alpha: 0.4),
                blurRadius: 15,
                spreadRadius: 2,
              ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [

            const SizedBox(width: 12),
            Expanded(
              child: Text(
                language.name,
                style: AppTypography.labelMedium.copyWith(
                  color: isSelected ? mintTealText : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}