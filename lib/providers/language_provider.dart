import 'package:flutter_riverpod/flutter_riverpod.dart';

// The Notifier class that controls the language state
class LanguageNotifier extends Notifier<String> {
  @override
  String build() {
    // We default to English ("en") when the app first launches
    return 'en'; 
  }

  // A simple function to change the language ("en", "fil", "ceb")
  void setLanguage(String langCode) {
    state = langCode;
  }
}

// The actual provider we will call from our UI
final languageProvider = NotifierProvider<LanguageNotifier, String>(() {
  return LanguageNotifier();
});