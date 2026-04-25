import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/screens.dart';


/// Main entry point of the Sikhay app.
/// 
/// Configures the app with:
/// - Custom theme (dark theme with primary color #00F5D4)
/// - System UI overlay style
/// - Onboarding flow
/// - Navigation shell
void main() {
  // Configure system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0D1B2A),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0D1B2A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Set preferred device orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const SikhayApp());
  });
}

/// Root widget of the Sikhay app.
/// 
/// Provides the Material app configuration and theme.
/// Manages the navigation between onboarding and main app.
class SikhayApp extends StatefulWidget {
  const SikhayApp({Key? key}) : super(key: key);

  @override
  State<SikhayApp> createState() => _SikhayAppState();
}

class _SikhayAppState extends State<SikhayApp> {
  /// Whether the user has completed onboarding
  bool _hasCompletedOnboarding = false;

  /// Handle onboarding completion
  void _completeOnboarding() {
    setState(() {
      _hasCompletedOnboarding = true;
    });
    // Here you would typically save the onboarding state to local storage
    // using SharedPreferences or similar
  }

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sikhay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      // Restore the conditional logic here:
      home: _hasCompletedOnboarding
          ? const AppShell() // Shows after onboarding is done
          : OnboardingScreen(
              onOnboardingComplete: _completeOnboarding,
            ),
    );
  }
}