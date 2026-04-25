
/// Model representing a language option for onboarding.
class Language {
  final String name;
  final String flagEmoji;
  final String code;

  const Language({
    required this.name,
    required this.flagEmoji,
    required this.code,
  });
}

/// Model representing a subject option for onboarding.
class Subject {
  final String name;
  final String icon;

  const Subject({
    required this.name,
    required this.icon,
  });
}

/// Available languages for the app (limited to: Tagalog, English, Bisaya)
final List<Language> availableLanguages = [
  const Language(
    name: 'English',
    flagEmoji: '🇬🇧',
    code: 'en',
  ),
  const Language(
    name: 'Tagalog',
    flagEmoji: '🇵🇭',
    code: 'tl',
  ),
  const Language(
    name: 'Bisaya',
    flagEmoji: '🇵🇭',
    code: 'ceb',
  ),
];

/// Available subjects for learning (limited to: Science, English, Math)
final List<Subject> availableSubjects = [
  const Subject(
    name: 'Science',
    icon: '🔬',
  ),
  const Subject(
    name: 'English',
    icon: '📚',
  ),
  const Subject(
    name: 'Math',
    icon: '📐',
  ),
];
