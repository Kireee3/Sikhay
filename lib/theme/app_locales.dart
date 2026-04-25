class AppLocales {
  static const Map<String, Map<String, String>> translations = {
    'English': {
      // Onboarding
      'welcome_title': 'Welcome to Sikhay',
      'welcome_subtitle': 'Learn complex concepts simply.',
      'select_language': 'Select your preferred language',
      'continue_btn': 'Continue',
      // Home Screen
      'good_morning': 'Good day',
      'ready_explore': 'Ready to explore the constellations of knowledge?',
      'explore_topics': 'Explore Topics',
      'see_all': 'See all categories →',
    },
    'Tagalog': {
      'welcome_title': 'Maligayang pagdating sa Sikhay',
      'welcome_subtitle': 'Matuto ng mahihirap na konsepto nang madali.',
      'select_language': 'Piliin ang iyong wika',
      'continue_btn': 'Magpatuloy',
      'good_morning': 'Magandang araw',
      'ready_explore': 'Handa na bang tuklasin ang mga bituin ng kaalaman?',
      'explore_topics': 'Tuklasin ang mga Paksa',
      'see_all': 'Tingnan lahat ng kategorya →',
    },
    'Bisaya': {
      'welcome_title': 'Maayong pag-abot sa Sikhay',
      'welcome_subtitle': 'Sayon ra ang pagkat-on sa lisod nga mga konsepto.',
      'select_language': 'Pilia ang imong pinulongan',
      'continue_btn': 'Padayon',
      'good_morning': 'Maayong adlaw',
      'ready_explore': 'Andam na ba ka mosuhid sa mga bituon sa kahibalo?',
      'explore_topics': 'Suhira ang mga Hilisgutan',
      'see_all': 'Tan-awa ang tanang kategorya →',
    }
  };

  static String get(String langCode, String key) {
    return translations[langCode]?[key] ?? translations['en']![key]!;
  }
}