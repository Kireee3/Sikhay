import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

// Your screen imports
import 'screens/screens.dart';
import 'package:sikhay/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure System UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0D1B2A),
      statusBarIconBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Wrap in ProviderScope for Riverpod support
  runApp(const ProviderScope(child: SikhayApp()));
}

class SikhayApp extends StatefulWidget {
  const SikhayApp({super.key});

  @override
  State<SikhayApp> createState() => _SikhayAppState();
}

class _SikhayAppState extends State<SikhayApp> {
  bool _hasCompletedOnboarding = false;

  void _completeOnboarding() {
    setState(() {
      _hasCompletedOnboarding = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sikhay',
      debugShowCheckedModeBanner: false,
      // Use your custom theme from app_theme.dart
      theme: AppTheme.darkTheme, 
      home: _hasCompletedOnboarding
          ? const AppShell()
          : OnboardingScreen(
              onOnboardingComplete: _completeOnboarding,
            ),
    );
  }
}