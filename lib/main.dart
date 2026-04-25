import 'package:flutter/material.dart';
import 'data/sample_graph.dart';
import 'screens/constellation_screen.dart';

void main() => runApp(const LinguaMapApp());

class LinguaMapApp extends StatelessWidget {
  const LinguaMapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinguaMap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF080E1A),
      ),
      home: ConstellationScreen(initialNode: photosynthesisGraph),
    );
  }
}