//lesson_content.dart
/// Model for lesson content with textual and contextual explanations.
/// 
/// Each lesson contains:
/// - Subject and level information
/// - Textual description
/// - Contextual explanation with real-world examples and applications
/// - Visual diagram information
class LessonContent {
  /// Subject name (e.g., "Biology")
  final String subject;

  /// Level indicator (e.g., "Level 2")
  final String level;

  /// Lesson title
  final String title;

  /// Textual based description
  final String textualDescription;

  /// Context explanation for contextual based view
  final String contextExplanation;

  /// Real-world examples
  final List<String> examples;

  /// Practical applications
  final List<String> applications;

  /// Diagram elements (e.g., "Sunlight → Chlorophyll → Oxygen")
  final DiagramInfo? diagramInfo;

  const LessonContent({
    required this.subject,
    required this.level,
    required this.title,
    required this.textualDescription,
    required this.contextExplanation,
    required this.examples,
    required this.applications,
    this.diagramInfo,
  });

  /// Factory constructor for Nitrogen Cycle lesson
  factory LessonContent.nitrogenCycle() {
    return LessonContent(
      subject: 'Biology',
      level: 'Level 2',
      title: 'Nitrogen Cycle',
      textualDescription:
          'The continuous environmental process involving five stages (nitrogen fixation, assimilation, ammonification, nitrification, and denitrification) through which nitrogen, a key element necessary for living organisms, is circulated. The purpose of the nitrogen cycle is to make atmospheric nitrogen available to living organisms and to return nitrogen to the atmosphere, ensuring a sustainable supply of this essential nutrient for life on Earth.',
      contextExplanation:
          'Nitrogen is an essential element for all living organisms, forming the backbone of proteins and nucleic acids. The nitrogen cycle is nature\'s way of recycling this vital element. Without this cycle, life as we know it would not exist. Understanding the nitrogen cycle is crucial for agriculture, environmental science, and addressing issues like nutrient pollution.',
      examples: [
        'Legume crops (beans, peas) have nitrogen-fixing bacteria in their root nodules',
        'Decomposing leaves release nitrogen back into the soil',
        'Fertilizers are used to supplement nitrogen in agricultural soils',
        'Wetlands filter excess nitrogen from agricultural runoff',
      ],
      applications: [
        'Agriculture: Using nitrogen-fixing crops to maintain soil fertility',
        'Environmental Science: Managing nitrogen pollution in water systems',
        'Biotechnology: Studying nitrogen-fixing bacteria for sustainable farming',
        'Climate Science: Understanding nitrogen cycling in different ecosystems',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Atmosphere', 'Bacteria', 'Plants', 'Soil'],
        emojis: ['🌫️', '🦠', '🌱', '🌍'],
      ),
    );
  }

  /// Factory constructor for Nitrogen Fixation lesson
  factory LessonContent.nitrogenFixation() {
    return LessonContent(
      subject: 'Biology',
      level: 'Level 2',
      title: 'Nitrogen Fixation',
      textualDescription:
          'The process by which atmospheric nitrogen (N2) is converted into usable ammonia (NH3), either through lightning or by nitrogen-fixing bacteria such as Rhizobium found in the environment or plant root nodules.',
      contextExplanation:
          'Nitrogen fixation is the critical first step of the nitrogen cycle. Most atmospheric nitrogen cannot be directly used by plants. Specialized bacteria have evolved the ability to break the strong triple bond in N2 and convert it to ammonia. This process is essential for life on Earth.',
      examples: [
        'Rhizobium bacteria live in root nodules of legume plants',
        'Lightning can fix nitrogen by creating nitrogen oxides',
        'Cyanobacteria in oceans fix nitrogen for marine ecosystems',
        'Farmers plant legumes to naturally fix nitrogen in soil',
      ],
      applications: [
        'Agriculture: Crop rotation with legumes to maintain soil nitrogen',
        'Biotechnology: Studying nitrogen-fixing bacteria for genetic engineering',
        'Industrial: Haber-Bosch process for artificial nitrogen fixation',
        'Sustainability: Reducing reliance on synthetic fertilizers',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Atmosphere N2', 'Bacteria', 'Ammonia NH3'],
        emojis: ['🌫️', '🦠', '💧'],
      ),
    );
  }

  /// Factory constructor for Assimilation lesson
  factory LessonContent.assimilation() {
    return LessonContent(
      subject: 'Biology',
      level: 'Level 2',
      title: 'Assimilation',
      textualDescription:
          'The uptake and utilization of nitrates and nitrites by plants to synthesize essential proteins and nucleic acids.',
      contextExplanation:
          'Assimilation is how plants use fixed nitrogen to build the proteins and DNA they need to grow. This is the bridge between the nitrogen cycle and living organisms. Without assimilation, the nitrogen cycle would have no purpose.',
      examples: [
        'Plants absorb nitrates through their root systems',
        'Nitrogen is incorporated into amino acids and proteins',
        'Green vegetables are rich in plant proteins made from assimilated nitrogen',
        'Plant growth rate depends on available nitrogen',
      ],
      applications: [
        'Agriculture: Optimizing nitrogen fertilizer application',
        'Nutrition: Understanding protein content in plant-based foods',
        'Horticulture: Managing plant nutrition for optimal growth',
        'Environmental Science: Predicting plant productivity',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Nitrates', 'Plant Roots', 'Proteins'],
        emojis: ['💧', '🌿', '🧬'],
      ),
    );
  }

  /// Factory constructor for Ammonification lesson
  factory LessonContent.ammonification() {
    return LessonContent(
      subject: 'Biology',
      level: 'Level 2',
      title: 'Ammonification',
      textualDescription:
          'The process performed by soil bacteria and fungi (decomposers) that breaks down the amino acids and nucleic acids of dead plants and animals, returning nitrogen to the soil as nitrates and ammonia.',
      contextExplanation:
          'Ammonification is nature\'s recycling process for nitrogen. When organisms die, decomposers break down their proteins and return nitrogen to the soil. This process is essential for nutrient cycling in ecosystems.',
      examples: [
        'Decomposing leaves release nitrogen into soil',
        'Compost piles generate ammonia as organic matter breaks down',
        'Soil bacteria break down dead organisms',
        'Nitrogen from dead animals enriches soil',
      ],
      applications: [
        'Composting: Creating nutrient-rich soil amendments',
        'Waste Management: Treating organic waste sustainably',
        'Soil Science: Understanding soil nutrient cycling',
        'Agriculture: Maximizing nutrient recovery from crop residues',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Dead Organisms', 'Decomposers', 'Ammonia'],
        emojis: ['💀', '🦠', '💨'],
      ),
    );
  }

  /// Factory constructor for Nitrification lesson
  factory LessonContent.nitrification() {
    return LessonContent(
      subject: 'Biology',
      level: 'Level 2',
      title: 'Nitrification',
      textualDescription:
          'The process immediately following nitrogen fixation that converts ammonia into nitrates or nitrites, making it readily available for plant absorption.',
      contextExplanation:
          'Nitrification is the process that makes nitrogen available to plants. Specialized bacteria oxidize ammonia into nitrates, which plants can readily absorb. This is a critical link in the nitrogen cycle.',
      examples: [
        'Nitrosomonas bacteria convert ammonia to nitrite',
        'Nitrobacter bacteria convert nitrite to nitrate',
        'Nitrification occurs in soil and aquatic environments',
        'Nitrifying bacteria are used in wastewater treatment',
      ],
      applications: [
        'Wastewater Treatment: Removing nitrogen from treated water',
        'Aquaculture: Maintaining nitrogen balance in fish tanks',
        'Soil Management: Understanding nitrogen availability',
        'Environmental Science: Predicting nitrogen cycling rates',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Ammonia', 'Nitrifying Bacteria', 'Nitrates'],
        emojis: ['💨', '🦠', '💧'],
      ),
    );
  }

  /// Factory constructor for Denitrification lesson
  factory LessonContent.denitrification() {
    return LessonContent(
      subject: 'Biology',
      level: 'Level 2',
      title: 'Denitrification',
      textualDescription:
          'The process by which denitrifying bacteria reduce soil nitrates and nitrites into gaseous nitrogen and nitrous oxide, returning free nitrogen to the atmosphere and potentially depleting soil fertility.',
      contextExplanation:
          'Denitrification completes the nitrogen cycle by returning nitrogen to the atmosphere. While this process can deplete soil nitrogen, it\'s essential for maintaining atmospheric nitrogen balance. Understanding denitrification is important for agriculture and environmental management.',
      examples: [
        'Waterlogged soils promote denitrification',
        'Denitrifying bacteria thrive in anaerobic conditions',
        'Nitrous oxide (N2O) is a potent greenhouse gas from denitrification',
        'Constructed wetlands use denitrification to remove nitrogen from water',
      ],
      applications: [
        'Wastewater Treatment: Using denitrification to remove excess nitrogen',
        'Environmental Science: Reducing nitrogen pollution in water bodies',
        'Climate Science: Understanding N2O emissions from agriculture',
        'Soil Management: Preventing nitrogen loss from agricultural soils',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Nitrates', 'Denitrifying Bacteria', 'Nitrogen Gas'],
        emojis: ['💧', '🦠', '🌫️'],
      ),
    );
  }

  /// Factory constructor for Photosynthesis lesson
  factory LessonContent.photosynthesis() {
    return LessonContent(
      subject: 'Biology',
      level: 'Level 2',
      title: 'Photosynthesis',
      textualDescription:
          'Think of a plant as a solar-powered food factory. Using sunlight as fuel, leaves take in carbon dioxide from the air and water from the soil. Through this chemical magic, they create glucose to grow and release fresh oxygen for us to breathe.',
      contextExplanation:
          'Photosynthesis is nature\'s way of converting solar energy into chemical energy. Every plant on Earth uses this process to survive and grow. Without photosynthesis, there would be no oxygen for us to breathe and no food chain to sustain life. It\'s the foundation of almost all life on Earth.',
      examples: [
        'Green leaves turning brown in autumn as photosynthesis slows down',
        'Plants growing faster in spring when there\'s more sunlight',
        'Aquatic plants producing oxygen bubbles during the day',
        'Farmers rotating crops to maintain soil nutrients produced by photosynthesis',
      ],
      applications: [
        'Agriculture: Optimizing crop yields by understanding light exposure',
        'Renewable Energy: Developing artificial photosynthesis for clean energy',
        'Climate Change: Using plants to absorb CO2 from the atmosphere',
        'Space Exploration: Growing food on spacecraft using controlled photosynthesis',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Sunlight', 'Chlorophyll', 'Oxygen'],
        emojis: ['☀️', '🌿', '💨'],
      ),
    );
  }

  /// Factory constructor for Chlorophyll lesson
  factory LessonContent.chlorophyll() {
    return LessonContent(
      subject: 'Biology',
      level: 'Level 2',
      title: 'Chlorophyll',
      textualDescription:
          'Chlorophyll is the green pigment found in plant cells that captures light energy from the sun. It absorbs light most strongly in the blue and red wavelengths, which is why plants appear green - they reflect the green wavelengths. This pigment is essential for the light-dependent reactions of photosynthesis.',
      contextExplanation:
          'Chlorophyll is the key to photosynthesis. Without this remarkable molecule, plants couldn\'t convert sunlight into food. The structure of chlorophyll allows it to absorb specific wavelengths of light and transfer that energy to electrons, starting the entire photosynthetic process. Scientists are studying chlorophyll to create artificial photosynthesis systems.',
      examples: [
        'Leaves are green because chlorophyll reflects green light',
        'Autumn leaves turn red and yellow when chlorophyll breaks down',
        'Spinach and kale are rich in chlorophyll, giving them their dark green color',
        'Algae in ponds contain chlorophyll, making the water appear green',
      ],
      applications: [
        'Medicine: Chlorophyll is used in some health supplements and treatments',
        'Food Industry: Chlorophyll extract is used as a natural food coloring',
        'Biotechnology: Scientists use chlorophyll to develop solar cells',
        'Environmental Science: Chlorophyll levels indicate plant health and ecosystem vitality',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Light Energy', 'Chlorophyll', 'Electrons'],
        emojis: ['💡', '🟢', '⚡'],
      ),
    );
  }

  /// Factory constructor for Oxygen lesson
  factory LessonContent.oxygen() {
    return LessonContent(
      subject: 'Chemistry',
      level: 'Level 2',
      title: 'Oxygen',
      textualDescription:
          'Oxygen is a colorless, odorless gas that makes up about 21% of Earth\'s atmosphere. It\'s essential for respiration in most living organisms. During photosynthesis, plants release oxygen as a byproduct when they split water molecules. This oxygen is then used by animals and plants for cellular respiration to produce energy.',
      contextExplanation:
          'Oxygen is one of the most important elements for life on Earth. The oxygen we breathe comes primarily from photosynthetic organisms - plants, algae, and cyanobacteria. Early in Earth\'s history, there was no oxygen in the atmosphere. The Great Oxidation Event, caused by photosynthetic organisms, transformed our planet and made complex life possible.',
      examples: [
        'Fish extract dissolved oxygen from water using their gills',
        'Oxygen levels in water determine which aquatic life can survive',
        'High-altitude climbers need supplemental oxygen because there\'s less in the air',
        'Oxygen is used in hospitals to help patients with breathing difficulties',
      ],
      applications: [
        'Medicine: Oxygen therapy for patients with respiratory conditions',
        'Industry: Oxygen is used in steel production and welding',
        'Environmental Science: Dissolved oxygen is a key indicator of water quality',
        'Space Exploration: Oxygen generation systems are crucial for spacecraft',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Water', 'Oxygen', 'Respiration'],
        emojis: ['💧', '💨', '🫁'],
      ),
    );
  }

  /// Factory constructor for Sunlight lesson
  factory LessonContent.sunlight() {
    return LessonContent(
      subject: 'Physics',
      level: 'Level 2',
      title: 'Sunlight',
      textualDescription:
          'Sunlight is electromagnetic radiation emitted by the sun. It travels 93 million miles to reach Earth in about 8 minutes. Sunlight contains visible light, ultraviolet (UV) radiation, and infrared radiation. Plants use the visible light portion of sunlight to power photosynthesis, while the infrared portion provides heat.',
      contextExplanation:
          'The sun is the ultimate energy source for almost all life on Earth. Every food we eat, every fossil fuel we burn, and every renewable energy source (except geothermal and nuclear) ultimately comes from the sun\'s energy. Understanding sunlight and how to harness it is crucial for addressing climate change and energy needs.',
      examples: [
        'Solar panels convert sunlight directly into electricity',
        'Sunburn is caused by ultraviolet radiation in sunlight',
        'The intensity of sunlight varies with latitude and season',
        'Shadows form because objects block sunlight',
      ],
      applications: [
        'Energy: Solar panels and solar thermal systems for electricity and heating',
        'Medicine: UV light therapy for treating certain skin conditions',
        'Agriculture: Understanding light requirements for optimal crop growth',
        'Climate Science: Solar radiation is a key factor in Earth\'s climate system',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Sun', 'Light Waves', 'Earth'],
        emojis: ['☀️', '〰️', '🌍'],
      ),
    );
  }

  /// Factory constructor for CO₂ lesson
  factory LessonContent.carbonDioxide() {
    return LessonContent(
      subject: 'Chemistry',
      level: 'Level 2',
      title: 'CO₂',
      textualDescription:
          'Carbon dioxide (CO₂) is a colorless, odorless gas composed of one carbon atom bonded to two oxygen atoms. It makes up about 0.04% of Earth\'s atmosphere. Plants absorb CO₂ from the air during photosynthesis to create glucose. Humans and animals release CO₂ as a waste product of cellular respiration.',
      contextExplanation:
          'Carbon dioxide is essential for life, yet it\'s also a major greenhouse gas contributing to climate change. The balance of CO₂ in our atmosphere is delicate. While plants need CO₂ for photosynthesis, increased atmospheric CO₂ levels trap more heat, warming the planet. Understanding the carbon cycle is crucial for addressing environmental challenges.',
      examples: [
        'Dry ice is solid carbon dioxide used in special effects',
        'Carbonated beverages contain CO₂ dissolved under pressure',
        'Plants grow better with higher CO₂ levels in greenhouses',
        'The atmosphere\'s CO₂ levels have increased significantly since industrialization',
      ],
      applications: [
        'Agriculture: CO₂ enrichment in greenhouses increases crop yields',
        'Food Industry: CO₂ is used in carbonation and food preservation',
        'Environmental Science: CO₂ monitoring is critical for climate research',
        'Technology: CO₂ capture and storage technology for climate mitigation',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Atmosphere', 'CO₂', 'Plants'],
        emojis: ['🌫️', '💨', '🌱'],
      ),
    );
  }

  /// Factory constructor for Glucose lesson
  factory LessonContent.glucose() {
    return LessonContent(
      subject: 'Chemistry',
      level: 'Level 2',
      title: 'Glucose',
      textualDescription:
          'Glucose is a simple sugar (monosaccharide) with the chemical formula C₆H₁₂O₆. It\'s produced by plants during photosynthesis and serves as a primary source of energy for cells. Glucose is transported through plant tissues and can be converted into other sugars, starches, or cellulose. In animals, glucose is obtained from food and used for energy production.',
      contextExplanation:
          'Glucose is the fundamental fuel of life. Every cell in every organism relies on glucose (or derivatives of it) for energy. The process of breaking down glucose through cellular respiration releases energy that powers all biological processes. Understanding glucose metabolism is crucial for treating diabetes and other metabolic disorders.',
      examples: [
        'Honey contains glucose and is a quick energy source',
        'Fruits taste sweet because they contain glucose and fructose',
        'Blood glucose levels are tightly regulated by the pancreas',
        'Athletes consume glucose-rich foods for quick energy',
      ],
      applications: [
        'Medicine: Blood glucose monitoring is essential for diabetes management',
        'Nutrition: Understanding glucose helps in dietary planning',
        'Biotechnology: Glucose fermentation produces ethanol and other products',
        'Food Science: Glucose is used as a sweetener and preservative',
      ],
      diagramInfo: DiagramInfo(
        elements: ['Glucose', 'Energy', 'Cells'],
        emojis: ['🍯', '⚡', '🧬'],
      ),
    );
  }
}

/// Model for diagram information
class DiagramInfo {
  /// Elements in the diagram
  final List<String> elements;

  /// Emoji representations
  final List<String> emojis;

  const DiagramInfo({
    required this.elements,
    required this.emojis,
  });
}
//bagong lagay