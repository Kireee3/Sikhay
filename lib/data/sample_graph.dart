
import '../models/concept.dart';

final ConceptNode photosynthesisGraph = ConceptNode(
  id: 'photosynthesis',
  label: 'Photosynthesis',
  description: 'Photosynthesis is the process by which green plants and '
      'some other organisms use sunlight to synthesize nutrients from '
      'carbon dioxide and water...',
  relatedNodes: [
    ConceptNode(
      id: 'chlorophyll',
      label: 'Chlorophyll',
      description: 'Chlorophyll is the green pigment found in the chloroplasts '
          'of plants that absorbs light energy for photosynthesis...',
      relatedNodes: [
        ConceptNode(id: 'light_absorption', label: 'Light Absorption', description: '...'),
        ConceptNode(id: 'chloroplast', label: 'Chloroplast', description: '...'),
      ],
    ),
    ConceptNode(
      id: 'oxygen',
      label: 'Oxygen',
      description: 'Oxygen is released as a byproduct of photosynthesis...',
      relatedNodes: [],
    ),
    ConceptNode(
      id: 'sunlight',
      label: 'Sunlight',
      description: 'Sunlight provides the energy that drives the photosynthesis reaction...',
      relatedNodes: [],
    ),
    ConceptNode(
      id: 'co2',
      label: 'CO₂',
      description: 'Carbon dioxide is one of the raw materials absorbed by plants...',
      relatedNodes: [],
    ),
    ConceptNode(
      id: 'glucose',
      label: 'Glucose',
      description: 'Glucose is the sugar produced during photosynthesis...',
      relatedNodes: [],
    ),
  ],
);