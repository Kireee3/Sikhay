/// Model representing a concept node in the constellation map.
/// 
/// Each node can have related nodes (satellites) that orbit around it.
/// This creates a hierarchical concept map where users can explore related topics.
class ConceptNode {
  /// Unique identifier for the concept
  final String id;

  /// Display label for the concept (e.g., "Photosynthesis")
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

  /// Factory constructor for Photosynthesis concept with related nodes
  factory ConceptNode.photosynthesis() {
    return ConceptNode(
      id: 'photosynthesis',
      label: 'Photosynthesis',
      description:
          'Think of a plant as a solar-powered food factory. Using sunlight as fuel, leaves take in carbon dioxide from the air and water from the soil. Through this chemical magic, they create glucose to grow and release fresh oxygen for us to breathe.',
      subject: 'Biology',
      level: 'Level 2',
      colorCode: '#FF131415',
      relatedNodes: [
        ConceptNode(
          id: 'chlorophyll',
          label: 'Chlorophyll',
          description:
              'The green pigment in plants that captures light energy from the sun.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'oxygen',
          label: 'Oxygen',
          description:
              'The gas produced by plants during photosynthesis that we breathe.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'sunlight',
          label: 'Sunlight',
          description:
              'The energy source that powers the photosynthesis process.',
          subject: 'Physics',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'co2',
          label: 'CO₂',
          description:
              'Carbon dioxide from the air that plants use in photosynthesis.',
          subject: 'Chemistry',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'glucose',
          label: 'Glucose',
          description:
              'The sugar produced by plants as food for growth and energy.',
          subject: 'Chemistry',
          level: 'Level 2',
          relatedNodes: [],
        ),
      ],
    );
  }

  /// Factory constructor for Chlorophyll concept
  factory ConceptNode.chlorophyll() {
    return ConceptNode(
      id: 'chlorophyll',
      label: 'Chlorophyll',
      description:
          'The green pigment in plants that captures light energy from the sun.',
      subject: 'Biology',
      level: 'Level 2',
      relatedNodes: [
        ConceptNode(
          id: 'light_absorption',
          label: 'Light Absorption',
          description: 'How chlorophyll absorbs different wavelengths of light.',
          subject: 'Physics',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'electron_transfer',
          label: 'Electron Transfer',
          description: 'The movement of electrons during light reactions.',
          subject: 'Chemistry',
          level: 'Level 2',
          relatedNodes: [],
        ),
      ],
    );
  }

  /// Factory constructor for Oxygen concept
  factory ConceptNode.oxygen() {
    return ConceptNode(
      id: 'oxygen',
      label: 'Oxygen',
      description:
          'The gas produced by plants during photosynthesis that we breathe.',
      subject: 'Biology',
      level: 'Level 2',
      relatedNodes: [
        ConceptNode(
          id: 'respiration',
          label: 'Respiration',
          description: 'How organisms use oxygen for energy production.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'atmosphere',
          label: 'Atmosphere',
          description: 'The layer of gases surrounding Earth.',
          subject: 'Earth Science',
          level: 'Level 2',
          relatedNodes: [],
        ),
      ],
    );
  }

  /// Factory constructor for Sunlight concept
  factory ConceptNode.sunlight() {
    return ConceptNode(
      id: 'sunlight',
      label: 'Sunlight',
      description:
          'The energy source that powers the photosynthesis process.',
      subject: 'Physics',
      level: 'Level 2',
      relatedNodes: [
        ConceptNode(
          id: 'electromagnetic_spectrum',
          label: 'EM Spectrum',
          description: 'The range of all types of electromagnetic radiation.',
          subject: 'Physics',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'wavelength',
          label: 'Wavelength',
          description: 'The distance between consecutive peaks of light waves.',
          subject: 'Physics',
          level: 'Level 2',
          relatedNodes: [],
        ),
      ],
    );
  }

  /// Factory constructor for CO₂ concept
  factory ConceptNode.carbonDioxide() {
    return ConceptNode(
      id: 'co2',
      label: 'CO₂',
      description:
          'Carbon dioxide from the air that plants use in photosynthesis.',
      subject: 'Chemistry',
      level: 'Level 2',
      relatedNodes: [
        ConceptNode(
          id: 'carbon_cycle',
          label: 'Carbon Cycle',
          description: 'The process of carbon moving through ecosystems.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'greenhouse_gas',
          label: 'Greenhouse Gas',
          description: 'Gases that trap heat in the atmosphere.',
          subject: 'Earth Science',
          level: 'Level 2',
          relatedNodes: [],
        ),
      ],
    );
  }

  /// Factory constructor for Glucose concept
  factory ConceptNode.glucose() {
    return ConceptNode(
      id: 'glucose',
      label: 'Glucose',
      description:
          'The sugar produced by plants as food for growth and energy.',
      subject: 'Chemistry',
      level: 'Level 2',
      relatedNodes: [
        ConceptNode(
          id: 'cellular_respiration',
          label: 'Cellular Respiration',
          description: 'How cells break down glucose for energy.',
          subject: 'Biology',
          level: 'Level 2',
          relatedNodes: [],
        ),
        ConceptNode(
          id: 'sugar_metabolism',
          label: 'Sugar Metabolism',
          description: 'The breakdown and synthesis of sugars in organisms.',
          subject: 'Chemistry',
          level: 'Level 2',
          relatedNodes: [],
        ),
      ],
    );
  }
}
//bagong lagay
