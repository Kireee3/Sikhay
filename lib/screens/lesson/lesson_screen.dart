import 'package:flutter/material.dart';
import 'package:sikhay/models/concept.dart';
import 'package:sikhay/screens/constellation_screen.dart';

class LessonView extends StatelessWidget {
  final ConceptNode node;

  const LessonView({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080E1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.tealAccent),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          node.label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lesson content
            Text(
              node.description,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 40),

            // Related concepts section
            if (node.relatedNodes.isNotEmpty) ...[
              const Text(
                'Related Concepts',
                style: TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: node.relatedNodes.map((related) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a new constellation centered on this node
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) =>
                              ConstellationScreen(initialNode: related),
                        ),
                      );
                    },
                    child: Chip(
                      label: Text(
                        related.label,
                        style: const TextStyle(color: Colors.tealAccent),
                      ),
                      backgroundColor: const Color(0xFF0D1B2A),
                      side: const BorderSide(color: Colors.teal),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}