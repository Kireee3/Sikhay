import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../models/user_profile.dart';
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

  /// Handle Google Sign-In (Cross-Platform) & Save to Database
  Future<void> _signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // THE WEB SHORTCUT (Bypasses rendering errors)
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        // THE MOBILE FLOW (v7.2.0 Compliant)
        final googleSignIn = GoogleSignIn.instance;
        await googleSignIn.initialize(); 

        final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
        if (googleUser == null) return; // User closed the popup

        final clientAuth = await googleUser.authorizationClient.authorizeScopes(['email', 'profile']);
        final googleAuth = googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: clientAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
      }

      // --- SAVE TO DATABASE ---
      final User? currentUser = FirebaseAuth.instance.currentUser;
      
      if (currentUser != null) {
        final userRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
        final docSnapshot = await userRef.get();

        // ONLY save if they don't exist yet (First time logging in!)
        if (!docSnapshot.exists) {
          final newUserProfile = UserProfile(
            id: currentUser.uid,
            displayName: currentUser.displayName ?? 'New Learner',
            preferredLanguage: _selectedLanguage?.name ?? 'English',
            xp: 0,
            level: 1,
            downloadedTopics: _selectedSubjects.toList(), 
          );

          await userRef.set(newUserProfile.toMap());
        }
      }

      if (!mounted) return;
      _completeOnboarding(); // Move to the App Shell!

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Auth Error: ${e.message ?? e.code}')),
      );
    } catch (e) {
      print("🚨 HIDDEN ERROR: $e");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign in was cancelled or blocked by the browser.')),
      );
    }
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
                          ? _signInWithGoogle
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
                        'Sign in with Google',
                        style: AppTypography.labelMedium.copyWith(color: AppColors.secondary),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.marginSmall),
                  Text(
                    'By signing in, you agree to our Terms of Service and Privacy Policy.',
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