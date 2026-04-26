class AppLocales {
  static const Map<String, Map<String, String>> translations = {
    'English': {
      'welcome_title': 'Welcome to Sikhay',
      'welcome_subtitle': 'Learn complex concepts simply.',
      'select_language': 'Select your preferred language',
      'continue_btn': 'Continue',
      'good_morning': 'Good day',
      'ready_explore': 'Ready to explore the constellations of knowledge?',
      'explore_topics': 'Explore Topics',
      'see_all': 'See all categories →',
      
      // --- NEW CARD CONTENT ---
      'photosynthesis': 'Photosynthesis',
      'photo_desc': 'The process of light-to-energy conversion in botanical systems.',
      'nitrogen_desc': 'The process of making atmospheric nitrogen available to living organisms and to return nitrogen to the atmosphere.',
      'astrophysics': 'Astrophysics',
      'orbital_mechanics': 'Orbital Mechanics',
      'chemistry': 'Chemistry',
      'organic_chemistry': 'Organic Chemistry',
      'biology': 'Biology',
      'cell_biology': 'Cell Biology',
      'physics': 'Physics',
      'quantum_mechanics': 'Quantum Mechanics',
      'lessons': 'Lessons',
      'new_content': 'New Content',
      'current_voyage': 'CURRENT VOYAGE',
      'resume_study': 'Resume Study',
      'view_constellation': 'View Constellation', 
      'mastery': 'Mastery',
      'explore_lesson': 'Explore the Lesson',
      'soon': 'To be released soon',
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

      // --- NEW CARD CONTENT ---
      'photosynthesis': 'Photosynthesis', 
      'photo_desc': 'Ang proseso ng pag-convert ng liwanag sa enerhiya sa mga halaman.',
      'nitrogen_desc': 'Ang proseso ng pagbabago ng nitroheno sa atmospera upang magamit ng mga buhay na organismo at ang muling pagbabalik nito sa atmospera.',
      'astrophysics': 'Astropisika',
      'orbital_mechanics': 'Mekanika ng Orbit',
      'chemistry': 'Kemistri',
      'organic_chemistry': 'Organikong Kemistri',
      'biology': 'Biyolohiya',
      'cell_biology': 'Biyolohiya ng Cell',
      'physics': 'Pisika',
      'quantum_mechanics': 'Quantum Mechanics',
      'lessons': 'Mga Aralin',
      'new_content': 'Bagong Nilalaman',
      'current_voyage': 'KASALUKUYANG PAGLALAKBAY',
      'resume_study': 'Ipagpatuloy ang Pag-aaral',
      'view_constellation': 'Tingnan ang Constellation', // Constellation kept in English!
      'mastery': 'Kahusayan',
      'explore_lesson': 'Tuklasin ang Aralin',
      'soon': 'Ilalabas na sa madaling panahon',
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

      // --- NEW CARD CONTENT ---
      'photosynthesis': 'Photosynthesis',
      'photo_desc': 'Ang proseso sa pag-usab sa kahayag ngadto sa enerhiya sa mga tanom.',
      'nitrogen_desc': 'Ang proseso sa pag-usab sa nitroheno sa atmospera aron magamit sa mga buhing organismo ug ang pagbalik niini sa atmospera.',
      'astrophysics': 'Astropisika',
      'orbital_mechanics': 'Mekanika sa Orbit',
      'chemistry': 'Kemistri',
      'organic_chemistry': 'Organikong Kemistri',
      'biology': 'Biyolohiya',
      'cell_biology': 'Biyolohiya sa Cell',
      'physics': 'Pisika',
      'quantum_mechanics': 'Quantum Mechanics',
      'lessons': 'Mga Leksyon',
      'new_content': 'Bag-ong Sulod',
      'current_voyage': 'KASAMTANGANG PANAGLAYAG',
      'resume_study': 'Ipadayon ang Pagtuon',
      'view_constellation': 'Tan-awa ang Constellation', // Constellation kept in English!
      'mastery': 'Kahanas',
      'explore_lesson': 'Suhira ang Leksyon',
      'soon': 'Ipagawas na sa dili madugay',
    }
  };

  static String get(String langCode, String key) {
    return translations[langCode]?[key] ?? translations['English']![key]!;
  }
}