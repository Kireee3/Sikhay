class ConceptNode {
  final String id;
  final String label;
  final String description;       // Full lesson text shown in LessonView
  final List<ConceptNode> relatedNodes;

  const ConceptNode({
    required this.id,
    required this.label,
    required this.description,
    this.relatedNodes = const [],
  });
}