import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sikhay/models/concept.dart';
import 'package:sikhay/utils/layout_utils.dart';
import 'package:sikhay/widgets/constellation_painter.dart';
import 'package:sikhay/widgets/node_widget.dart';
import 'package:sikhay/screens/lesson/lesson_screen.dart';

class ConstellationScreen extends StatefulWidget {
  final ConceptNode initialNode;

  const ConstellationScreen({super.key, required this.initialNode});

  @override
  State<ConstellationScreen> createState() => _ConstellationScreenState();
}

class _ConstellationScreenState extends State<ConstellationScreen>
    with SingleTickerProviderStateMixin {
  late ConceptNode _currentNode;
  late AnimationController _animController;
  late Animation<double> _progressAnim;

  // Navigation history stack for back navigation
  final List<ConceptNode> _history = [];

  @override
  void initState() {
    super.initState();
    _currentNode = widget.initialNode;

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _progressAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _navigateTo(ConceptNode nextNode) {
    _history.add(_currentNode);
    setState(() => _currentNode = nextNode);
    _animController.forward(from: 0.0); // Replay entrance animation
  }

  void _navigateBack() {
    if (_history.isNotEmpty) {
      setState(() => _currentNode = _history.removeLast());
      _animController.forward(from: 0.0);
    }
  }

  void _openLesson() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, _) => LessonView(node: _currentNode),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Place the constellation center slightly above screen center for visual balance
    final center = Offset(size.width / 2, size.height / 2 - 30);
    const double satelliteRadius = 145.0;
    const double centerNodeSize = 120.0;
    const double satelliteNodeSize = 82.0;

    final satellites = _currentNode.relatedNodes;
    final satellitePositions = calculateSatellitePositions(
      count: satellites.length,
      center: center,
      radius: satelliteRadius,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF080E1A),
      body: SafeArea(
        child: Stack(
          children: [
            // ── Background star field (optional decorative layer) ──────────
            // You can add a static Image.asset('assets/stars.png') here.

            // ── Animated connecting lines ──────────────────────────────────
            AnimatedBuilder(
              animation: _progressAnim,
              builder: (_, _) => CustomPaint(
                size: size,
                painter: ConstellationPainter(
                  center: center,
                  satellitePositions: satellitePositions,
                  animationProgress: _progressAnim.value,
                ),
              ),
            ),

            // ── Satellite nodes ────────────────────────────────────────────
            for (int i = 0; i < satellites.length; i++)
              AnimatedBuilder(
                animation: _progressAnim,
                builder: (_, child) {
                  // Each satellite animates outward from center
                  final animatedPos = Offset.lerp(
                    center,
                    satellitePositions[i],
                    _progressAnim.value,
                  )!;
                  return Positioned(
                    left: animatedPos.dx - satelliteNodeSize / 2,
                    top: animatedPos.dy - satelliteNodeSize / 2,
                    child: Opacity(
                      opacity: _progressAnim.value,
                      child: child,
                    ),
                  );
                },
                child: NodeWidget(
                  label: satellites[i].label,
                  size: satelliteNodeSize,
                  onTap: () => _navigateTo(satellites[i]),
                ),
              ),

            // ── Center node ────────────────────────────────────────────────
            Positioned(
              left: center.dx - centerNodeSize / 2,
              top: center.dy - centerNodeSize / 2,
              child: NodeWidget(
                label: _currentNode.label,
                size: centerNodeSize,
                isCenter: true,
                onTap: _openLesson,
              ),
            ),

            // ── Back button (shown when there is navigation history) ───────
            if (_history.isNotEmpty)
              Positioned(
                top: 12,
                left: 12,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.tealAccent),
                  onPressed: _navigateBack,
                ),
              ),

            // ── "Explore Deeper" CTA button ────────────────────────────────
            Positioned(
              bottom: 24,
              left: size.width * 0.15,
              right: size.width * 0.15,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _openLesson,
                child: const Text(
                  'Explore Deeper  ›',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}