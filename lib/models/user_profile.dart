import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String displayName;
  final String preferredLanguage; // "en", "fil", "ceb"
  final int xp;
  final int level;
  final List<String> downloadedTopics;

  UserModel({
    required this.id,
    required this.displayName,
    required this.preferredLanguage,
    required this.xp,
    required this.level,
    required this.downloadedTopics,
  });

  factory UserModel.fromMap(String documentId, Map<String, dynamic> map) {
    return UserModel(
      id: documentId,
      displayName: map['displayName'] ?? '',
      preferredLanguage: map['preferredLanguage'] ?? 'en',
      xp: map['xp'] ?? 0,
      level: map['level'] ?? 1,
      downloadedTopics: List<String>.from(map['downloadedTopics'] ?? []),
    );
  }

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

class ProgressModel {
  final String topicId;
  final List<String> conceptsLearned;
  final List<String> struggledConcepts;
  final double percentComplete;
  final DateTime lastVisited;

  ProgressModel({
    required this.topicId,
    required this.conceptsLearned,
    required this.struggledConcepts,
    required this.percentComplete,
    required this.lastVisited,
  });

  factory ProgressModel.fromMap(String documentId, Map<String, dynamic> map) {
    return ProgressModel(
      topicId: documentId,
      conceptsLearned: List<String>.from(map['conceptsLearned'] ?? []),
      struggledConcepts: List<String>.from(map['struggledConcepts'] ?? []),
      percentComplete: (map['percentComplete'] ?? 0.0).toDouble(),
      // Safely convert Firestore Timestamp to Dart DateTime
      lastVisited: (map['lastVisited'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'conceptsLearned': conceptsLearned,
      'struggledConcepts': struggledConcepts,
      'percentComplete': percentComplete,
      // Convert Dart DateTime back to Firestore Timestamp
      'lastVisited': Timestamp.fromDate(lastVisited),
    };
  }
}