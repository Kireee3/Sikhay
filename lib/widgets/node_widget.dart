import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Reusable widget for displaying a constellation node.
/// 
/// A node can be either:
/// - Center node: Larger, displays current concept, opens lesson view
/// - Satellite node: Smaller, displays related concept, navigates to that concept
/// 
/// Features:
/// - Circular design with border
/// - Animated appearance
/// - Tap feedback with visual indication
/// - Responsive sizing
/// 
/// Uses GestureDetector for tap interactions and Container for styling.
class NodeWidget extends StatefulWidget {
  /// Display label for the node (e.g., "Photosynthesis")
  final String label;

  /// Size of the node in logical pixels
  final double size;

  /// Whether this is the center node (true) or satellite node (false)
  final bool isCenter;

  /// Callback when the node is tapped
  final VoidCallback onTap;

  /// Optional color for the node (uses theme color if not provided)
  final Color? color;

  const NodeWidget({
    super.key,
    required this.label,
    required this.size,
    required this.onTap,
    this.isCenter = false,
    this.color,
  });

  @override
  State<NodeWidget> createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget>
    with SingleTickerProviderStateMixin {
  /// Animation controller for tap feedback
  late AnimationController _tapController;

  /// Animation for scale effect on tap
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize tap animation controller
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Create scale animation (1.0 -> 0.95 -> 1.0)
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _tapController.dispose();
    super.dispose();
  }

  /// Handle node tap with animation feedback
  void _handleTap() {
    // Play scale animation
    _tapController.forward().then((_) {
      _tapController.reverse();
    });
    
    // Execute callback
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // GestureDetector for tap interactions
      onTap: _handleTap,
      child: ScaleTransition(
        // ScaleTransition for tap feedback animation
        scale: _scaleAnimation,
        child: Container(
          // Container with circular shape and border
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            // Circular shape
            shape: BoxShape.circle,
            // Border styling
            border: Border.all(
              // Use primary color for border
              color: widget.color ?? AppColors.primary,
              // Thicker border for center node
              width: widget.isCenter ? 2.5 : 2.0,
            ),
            // Semi-transparent background
            color: (widget.color ?? AppColors.primary).withValues(alpha: 0.1),
            // Optional shadow for depth
            boxShadow: [
              BoxShadow(
                color: (widget.color ?? AppColors.primary).withValues(alpha: 0.2),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          // Center content
          child: Center(
            child: Padding(
              // Padding for text inside circle
              padding: const EdgeInsets.all(AppSpacing.paddingSmall),
              child: Column(
                // Column for vertical arrangement
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Node label text
                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: widget.isCenter
                        ? AppTypography.headingSmall.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          )
                        : AppTypography.labelMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    // Allow text to wrap within circle
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Optional: Icon for center node
                  if (widget.isCenter) ...[
                    const SizedBox(height: AppSpacing.marginSmall),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//bagong lagay