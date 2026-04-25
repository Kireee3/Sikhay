class TopicModel {
  final String id;
  final String title;
  final String subject;
  final List<String> concepts;

  TopicModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.concepts,
  });

  factory TopicModel.fromMap(String documentId, Map<String, dynamic> map) {
    return TopicModel(
      id: documentId,
      title: map['title'] ?? '',
      subject: map['subject'] ?? '',
      concepts: List<String>.from(map['concepts'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subject': subject,
      'concepts': concepts,
    };
  }
}