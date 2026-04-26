import 'package:http/http.dart' as http;
import 'dart:convert';

/// Service for generating AI-powered explanations at different difficulty levels.
/// Uses Google Gemini API with embedded lesson definitions and optimized temperatures.
class AIExplanationService {
  static final AIExplanationService _instance = AIExplanationService._internal();

  factory AIExplanationService() {
    return _instance;
  }

  AIExplanationService._internal();

  // Google Gemini API endpoint
  static const String _apiEndpoint = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  /// Lesson definitions map - contains all lesson content
  static const Map<String, String> lessonDefinitions = {
    'nitrogen_cycle': 'The continuous environmental process involving five stages (nitrogen fixation, assimilation, ammonification, nitrification, and denitrification) through which nitrogen, a key element necessary for living organisms, is circulated. The purpose of the nitrogen cycle is to make atmospheric nitrogen available to living organisms and to return nitrogen to the atmosphere, ensuring a sustainable supply of this essential nutrient for life on Earth.',
    
    'nitrogen_fixation': 'The process by which atmospheric nitrogen (N2) is converted into usable ammonia (NH3), either through lightning or by nitrogen-fixing bacteria such as Rhizobium found in the environment or plant root nodules.',
    
    'assimilation': 'The uptake and utilization of nitrates and nitrites by plants to synthesize essential proteins and nucleic acids.',
    
    'ammonification': 'The process performed by soil bacteria and fungi (decomposers) that breaks down the amino acids and nucleic acids of dead plants and animals, returning nitrogen to the soil as nitrates and ammonia.',
    
    'nitrification': 'The process immediately following nitrogen fixation that converts ammonia into nitrates or nitrites, making it readily available for plant absorption.',
    
    'denitrification': 'The process by which denitrifying bacteria reduce soil nitrates and nitrites into gaseous nitrogen and nitrous oxide, returning free nitrogen to the atmosphere and potentially depleting soil fertility.',
    
    'photosynthesis': 'The process by which plants use sunlight to convert carbon dioxide and water into glucose (sugar) and oxygen. This is how plants make their own food and produce the oxygen we breathe.',
    
    'chlorophyll': 'The green pigment found in plant cells that captures light energy from the sun. It absorbs light most strongly in the blue and red wavelengths, which is why plants appear green - they reflect the green wavelengths. This pigment is essential for the light-dependent reactions of photosynthesis.',
    
    'oxygen': 'A colorless, odorless gas that makes up about 21% of Earth\'s atmosphere. It\'s essential for respiration in most living organisms. During photosynthesis, plants release oxygen as a byproduct when they split water molecules.',
    
    'sunlight': 'Electromagnetic radiation emitted by the sun. It travels 93 million miles to reach Earth in about 8 minutes. Sunlight contains visible light, ultraviolet (UV) radiation, and infrared radiation. Plants use the visible light portion of sunlight to power photosynthesis.',
    
    'co2': 'Carbon dioxide (CO₂) is a colorless, odorless gas composed of one carbon atom bonded to two oxygen atoms. It makes up about 0.04% of Earth\'s atmosphere. Plants absorb CO₂ from the air during photosynthesis to create glucose.',
    
    'glucose': 'A simple sugar (monosaccharide) with the chemical formula C₆H₁₂O₆. It\'s produced by plants during photosynthesis and serves as a primary source of energy for cells. Glucose is transported through plant tissues and can be converted into other sugars, starches, or cellulose.',
  };

  /// Generate an explanation at the specified level
  /// 
  /// [conceptTitle]: Name of the concept (e.g., "Photosynthesis")
  /// [conceptId]: ID for looking up definition (e.g., "photosynthesis")
  /// [level]: 1 (Curious), 2 (Struggling), 3 (ELI5)
  /// [language]: 'en' (English), 'tl' (Tagalog/Filipino), 'ceb' (Cebuano/Bisaya)
  Future<String> generateExplanation({
    required String conceptTitle,
    required String conceptId,
    required int level,
    required String language,
  }) async {
    try {
      // Get the core definition from the embedded lessons
      final coreDefinition = lessonDefinitions[conceptId.toLowerCase()] ?? 
          'A key concept in science education.';

      final prompt = _buildPrompt(
        conceptTitle: conceptTitle,
        coreDefinition: coreDefinition,
        level: level,
        language: language,
      );

      // Get temperature optimized for the level
      final temperature = _getTemperatureForLevel(level);

      // Get API key from environment variable
      const String apiKey = String.fromEnvironment('GOOGLE_API_KEY');
      
      if (apiKey.isEmpty) {
        return 'Error: Google API key not configured. Run: flutter run --dart-define=GOOGLE_API_KEY=your_key_here';
      }

      final response = await http.post(
        Uri.parse('$_apiEndpoint?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text': prompt,
                }
              ]
            }
          ],
          'generationConfig': {
            'temperature': temperature,
            'maxOutputTokens': 500,
            'topP': 0.95,
            'topK': 40,
          }
        }),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw Exception('API request timeout'),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        
        // Parse Gemini API response
        if (jsonResponse['candidates'] != null && jsonResponse['candidates'].isNotEmpty) {
          final content = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
          return content ?? 'Unable to generate explanation';
        }
        return 'Unable to generate explanation';
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return 'Error: Invalid API key. Please check your GOOGLE_API_KEY.';
      } else if (response.statusCode == 429) {
        return 'Error: Rate limit exceeded. Please try again later.';
      } else {
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return 'Error generating explanation: $e';
    }
  }

  /// Get optimized temperature for each difficulty level
  double _getTemperatureForLevel(int level) {
    switch (level) {
      case 1:
        // Level 1 (Curious): 0.7 - Balanced, clear explanations
        return 0.7;
      case 2:
        // Level 2 (Struggling): 0.6 - More consistent, easier to understand
        return 0.6;
      case 3:
        // Level 3 (ELI5): 0.9 - More creative and fun for kids
        return 0.9;
      default:
        return 0.7;
    }
  }

  /// Build the prompt based on the difficulty level
  String _buildPrompt({
    required String conceptTitle,
    required String coreDefinition,
    required int level,
    required String language,
  }) {
    final languageName = _getLanguageName(language);

    switch (level) {
      case 1:
        // Level 1: Base (The "Curious" Level)
        return '''You are an encouraging tutor. The core definition of "$conceptTitle" is: "$coreDefinition". 

Based strictly on this definition, explain the concept to a curious student in $languageName. 

Keep the response 2-3 sentences. 

If the language is Filipino or Tagalog, use a warm, encouraging, and natural conversational tone (Taglish is highly encouraged, like a friendly teacher). 

If the language is Bisaya/Cebuano, use standard Cebuano vocabulary strictly—do not mix in Tagalog or standard Filipino words, but maintain a warm tone.

Make sure to provide a complete, detailed explanation that connects the concept to real-world understanding.''';

      case 2:
        // Level 2: Simpler (The "Struggling" Level)
        return '''You are a patient and supportive tutor. The student is struggling to understand "$conceptTitle". The core definition is: "$coreDefinition". 

First, briefly validate that this is a tricky topic. Then, explain it again using ONE easy-to-imagine everyday relatable analogy. Strip away all complex jargon. 

The requested language is $languageName. 

Keep the response 2-3 sentences but make it detailed and helpful.

If the language is Filipino or Tagalog, use a warm, encouraging, and natural conversational tone (Taglish is highly encouraged, like a friendly teacher). 

If the language is Bisaya/Cebuano, use standard Cebuano vocabulary strictly—do not mix in Tagalog or standard Filipino words, but maintain a warm tone.

Make sure the analogy is clear, relatable, and helps the student understand the concept in a new way.''';

      case 3:
        // Level 3: Simplest (The "ELI5" Level)
        return '''You are a gentle tutor explaining things to a beginner. The core definition of "$conceptTitle" is: "$coreDefinition". 

Explain this concept like you're talking to a 12-year-old using just ONE simple analogy based on everyday experiences. Use only very simple, short words—no big science words at all. 

End with a fun, encouraging statement praising them for learning something new today. 

The requested language is $languageName. 

Keep the response 2-3 sentences but make sure it's complete and detailed.

If the language is Filipino or Tagalog, use a warm, encouraging, and natural conversational tone (Taglish is highly encouraged, like a friendly teacher). 

If the language is Bisaya/Cebuano, use standard Cebuano vocabulary strictly—do not mix in Tagalog or standard Filipino words, but maintain a warm tone.

Make the analogy very simple, fun, and easy to understand!''';

      default:
        return '''Explain "$conceptTitle" in simple terms. Definition: "$coreDefinition". Provide a detailed explanation.''';
    }
  }

  /// Get language name from language code
  String _getLanguageName(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'en':
        return 'English';
      case 'tl':
      case 'fil':
      case 'tagalog':
        return 'Filipino/Tagalog';
      case 'ceb':
      case 'bisaya':
        return 'Bisaya/Cebuano';
      default:
        return 'English';
    }
  }
}