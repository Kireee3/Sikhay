import 'package:cloud_firestore/cloud_firestore.dart';

class ConceptModel {
  final String id;
  final String title;
  final String coreDefinition;
  final Map<String, Map<String, String>> explanation;
  final List<String> relatedConcepts;
  final String subject;

  ConceptModel({
    required this.id,
    required this.title,
    required this.coreDefinition,
    required this.explanation,
    required this.relatedConcepts,
    required this.subject,
  });

  // Converts Firestore JSON into a Dart Object
  factory ConceptModel.fromMap(String documentId, Map<String, dynamic> map) {
    return ConceptModel(
      id: documentId,
      title: map['title'] ?? '',
      coreDefinition: map['coreDefinition'] ?? '',
      // Parsing nested maps safely
      explanation: (map['explanation'] as Map<String, dynamic>? ?? {}).map(
        (lang, levels) => MapEntry(
          lang,
          Map<String, String>.from(levels as Map),
        ),
      ),
      relatedConcepts: List<String>.from(map['relatedConcepts'] ?? []),
      subject: map['subject'] ?? '',
    );
  }

  // Converts the Dart Object back into Firestore JSON
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'coreDefinition': coreDefinition,
      'explanation': explanation,
      'relatedConcepts': relatedConcepts,
      'subject': subject,
    };
  }
}