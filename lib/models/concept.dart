//concept.dart
/// Model representing a concept node in the constellation map.
/// 
/// Each node can have related nodes (satellites) that orbit around it.
/// This creates a hierarchical concept map where users can explore related topics.
class ConceptNode {
  /// Unique identifier for the concept
  final String id;

  /// Display label for the concept (e.g., "Nitrogen Cycle")
  final String label;

  /// Description of the concept
  final String description;

  /// Subject category (e.g., "Biology", "Physics")
  final String subject;

  /// Learning level (e.g., "Level 2")
  final String level;

  /// List of related concept nodes that orbit around this node
  final List<ConceptNode> relatedNodes;

  /// Color code for the node (optional, for future customization)
  final String? colorCode;

  const ConceptNode({
    required this.id,
    required this.label,
    required this.description,
    required this.subject,
    required this.level,
    required this.relatedNodes,
    this.colorCode,
  });

  /// Factory constructor for Nitrogen Cycle concept with related nodes
  factory ConceptNode.nitrogenCycle() {
    return ConceptNode(
      id: 'nitrogen_cycle',
      label: 'Nitrogen Cycle',
      description:
          'The continuous environmental process involving five stages (nitrogen fixation, assimilation, ammonification, nitrification, and denitrification) through which nitrogen, a key element necessary for living organisms, is circulated. The purpose of the nitrogen cycle is to make atmospheric nitrogen available to living organisms and to return nitrogen to the atmosphere, ensuring a sustainable supply of this essential nutrient for life on Earth.',
      subject: 'Biology',
      level: 'Level 2',
      colorCode: '#FF4CAF50',
      relatedNodes: [
        ConceptNode(
          id: 'nitrogen_fixation',
          label: 'Nitrogen Fixation',
          description:
              'The process by which atmospheric nitrogen (N2) is converted into usable ammonia (NH3), either through lightning or by nitrogen-fixing bacteria such as Rhizobium found in the environment or plant root nodules.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'assimilation',
          label: 'Assimilation',
          description:
              'The uptake and utilization of nitrates and nitrites by plants to synthesize essential proteins and nucleic acids.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'ammonification',
          label: 'Ammonification',
          description:
              'The process performed by soil bacteria and fungi (decomposers) that breaks down the amino acids and nucleic acids of dead plants and animals, returning nitrogen to the soil as nitrates and ammonia.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'nitrification',
          label: 'Nitrification',
          description:
              'The process immediately following nitrogen fixation that converts ammonia into nitrates or nitrites, making it readily available for plant absorption.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'denitrification',
          label: 'Denitrification',
          description:
              'The process by which denitrifying bacteria reduce soil nitrates and nitrites into gaseous nitrogen and nitrous oxide, returning free nitrogen to the atmosphere and potentially depleting soil fertility.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
      ],
    );
  }
}