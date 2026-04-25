class AppLocales {
  static const Map<String, Map<String, String>> translations = {
    'en': {
      'welcome_title': 'Welcome to Sikhay',
      'welcome_subtitle': 'Learn complex concepts simply.',
      'select_language': 'Select your preferred language',
      'continue_btn': 'Continue',
    },
    'fil': {
      'welcome_title': 'Maligayang pagdating sa Sikhay',
      'welcome_subtitle': 'Matuto ng mahihirap na konsepto nang madali.',
      'select_language': 'Piliin ang iyong wika',
      'continue_btn': 'Magpatuloy',
    },
    'ceb': {
      'welcome_title': 'Maayong pag-abot sa Sikhay',
      'welcome_subtitle': 'Sayon ra ang pagkat-on sa lisod nga mga konsepto.',
      'select_language': 'Pilia ang imong pinulongan',
      'continue_btn': 'Padayon',
    }
  };

  // A helper function to grab the right word based on the current language
  static String get(String langCode, String key) {
    return translations[langCode]?[key] ?? translations['en']![key]!;
  }
}