// constellation_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacing.dart';
import '../../models/concept.dart';
import '../../utils/layout_utils.dart';
import '../../widgets/constellation_painter.dart';
import '../../widgets/node_widget.dart';
import '../../widgets/lesson_header.dart';

/// Constellation Screen displaying an interactive concept map.
/// 
/// Features:
/// - Animated node expansion from center outward
/// - Interactive nodes that navigate to related concepts
/// - Connecting lines between center and satellite nodes
/// - Navigation history for back button
/// - Tap on center node to open lesson view
/// - Tap on satellite nodes to explore related concepts
/// 
/// Uses SingleTickerProviderStateMixin for animation control.
class ConstellationScreen extends StatefulWidget {
  /// Initial concept node to display
  final ConceptNode initialNode;

  /// Callback when back button is pressed
  final VoidCallback? onBackPressed;

  /// Callback when lesson view should open
  final Function(ConceptNode)? onOpenLesson;

  const ConstellationScreen({
    super.key,
    required this.initialNode,
    this.onBackPressed,
    this.onOpenLesson,
  });

  @override
  State<ConstellationScreen> createState() => _ConstellationScreenState();
}

class _ConstellationScreenState extends State<ConstellationScreen>
    with SingleTickerProviderStateMixin {
  /// Currently displayed concept node
  late ConceptNode _currentNode;

  /// Animation controller for node expansion
  late AnimationController _animController;

  /// Animation for smooth node entrance
  late Animation<double> _progressAnim;

  /// Navigation history stack for back button
  final List<ConceptNode> _history = [];

  /// Currently selected language
  String _selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    _currentNode = widget.initialNode;

    // Initialize animation controller
    _animController = AnimationController(
      vsync: this,
      // 700ms duration for node expansion
      duration: const Duration(milliseconds: 700),
    );

    // Create curved animation for smooth easing
    _progressAnim = CurvedAnimation(
      parent: _animController,
      // easeOutCubic for natural deceleration
      curve: Curves.easeOutCubic,
    );

    // Start animation on screen load
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  /// Navigate to a related concept node
  void _navigateTo(ConceptNode nextNode) {
    // Add current node to history for back navigation
    _history.add(_currentNode);
    
    setState(() => _currentNode = nextNode);
    
    // Replay entrance animation
    _animController.forward(from: 0.0);
  }

  /// Navigate back to previous concept
  void _navigateBack() {
    if (_history.isNotEmpty) {
      setState(() => _currentNode = _history.removeLast());
      _animController.forward(from: 0.0);
    } else {
      // If no history, call back callback
      widget.onBackPressed?.call();
    }
  }

  /// Open lesson view for current concept
  void _openLesson() {
    widget.onOpenLesson?.call(_currentNode);
  }

  /// Handle language change
  void _handleLanguageChange(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Center position slightly above screen center for visual balance
    final center = Offset(size.width / 2, size.height / 2 - 30);
    
    // Radius for satellite nodes
    const double satelliteRadius = 145.0;
    
    // Size of center node
    const double centerNodeSize = 120.0;
    
    // Size of satellite nodes
    const double satelliteNodeSize = 82.0;

    // Get related nodes for current concept
    final satellites = _currentNode.relatedNodes;
    
    // Calculate positions for satellite nodes
    final satellitePositions = calculateSatellitePositions(
      count: satellites.length,
      center: center,
      radius: satelliteRadius,
    );

    return Scaffold(
      // Scaffold for Material app structure
      backgroundColor: AppColors.background,
      appBar: LessonHeader(
        // Use LessonHeader with language selector
        selectedLanguage: _selectedLanguage,
        onLanguageChanged: _handleLanguageChange,
      ),
      body: SafeArea(
        child: Stack(
          // Stack for layering elements
          children: [
            // ── Animated connecting lines ──────────────────────────────────
            AnimatedBuilder(
              animation: _progressAnim,
              builder: (_, _) => CustomPaint(
                // CustomPaint for drawing lines
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
                    // Position satellite node
                    left: animatedPos.dx - satelliteNodeSize / 2,
                    top: animatedPos.dy - satelliteNodeSize / 2,
                    child: Opacity(
                      // Fade in with animation
                      opacity: _progressAnim.value,
                      child: child,
                    ),
                  );
                },
                child: NodeWidget(
                  // Reusable node widget
                  label: satellites[i].label,
                  size: satelliteNodeSize,
                  isCenter: false,
                  onTap: () => widget.onOpenLesson?.call(satellites[i]),
                ),
              ),

            // ── Center node ────────────────────────────────────────────────
            Positioned(
              // Position center node
              left: center.dx - centerNodeSize / 2,
              top: center.dy - centerNodeSize / 2,
              child: NodeWidget(
                // Center node widget
                label: _currentNode.label,
                size: centerNodeSize,
                isCenter: true,
                onTap: _openLesson,
              ),
            ),

            // ── Back button (shown when there is navigation history) ───────
            if (_history.isNotEmpty)
              Positioned(
                top: AppSpacing.paddingMedium,
                left: AppSpacing.paddingMedium,
                child: IconButton(
                  // Back button
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.primary,
                  ),
                  onPressed: _navigateBack,
                  tooltip: 'Go back',
                ),
              ),
          ],
        ),
      ),
    );
  }
}