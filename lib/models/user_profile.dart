class UserProfile {
  final String id; // The Firestore Document ID
  final String displayName;
  final String preferredLanguage;
  final int xp;
  final int level;
  final List<String> downloadedTopics;

  UserProfile({
    required this.id,
    required this.displayName,
    required this.preferredLanguage,
    required this.xp,
    required this.level,
    required this.downloadedTopics,
  });

  /// Unpacks the data coming FROM Firebase into a Dart object
  factory UserProfile.fromMap(String documentId, Map<String, dynamic> map) {
    return UserProfile(
      id: documentId,
      displayName: map['displayName'] ?? 'New Learner', // Fallback if null
      preferredLanguage: map['preferredLanguage'] ?? 'en',
      xp: map['xp']?.toInt() ?? 0,
      level: map['level']?.toInt() ?? 1,
      // Safely converts the Firebase array into a Dart List of Strings
      downloadedTopics: List<String>.from(map['downloadedTopics'] ?? []),
    );
  }

  /// Bundles the Dart object UP into a map to save TO Firebase
  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'preferredLanguage': preferredLanguage,
      'xp': xp,
      'level': level,
      'downloadedTopics': downloadedTopics,
    };
  }
}