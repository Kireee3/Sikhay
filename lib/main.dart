import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart'; // <--- ADDED FIREBASE IMPORT
import 'firebase_options.dart';                    // <--- ADDED OPTIONS IMPORT
import 'screens/screens.dart';
import 'package:sikhay/theme/app_theme.dart';

/// Main entry point of the Sikhay app.
void main() async {
  // 1. MUST BE FIRST: Initialize the connection between Flutter and the host platform
  WidgetsFlutterBinding.ensureInitialized();

  // 2. BOOT UP FIREBASE (This is what was missing!)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 3. Configure system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0D1B2A),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0D1B2A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // 4. Set preferred device orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 5. Finally, start the app
  runApp(const SikhayApp());
}
/// Root widget of the Sikhay app.
/// 
/// Provides the Material app configuration and theme.
/// Manages the navigation between onboarding and main app.
class SikhayApp extends StatefulWidget {
  const SikhayApp({super.key});

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