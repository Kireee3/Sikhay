import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  final String label;
  final double size;
  final bool isCenter;
  final VoidCallback onTap;

  const NodeWidget({
    super.key,
    required this.label,
    required this.size,
    required this.onTap,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF0D1B2A),
          border: Border.all(
            color: isCenter
                ? Colors.tealAccent
                : Colors.teal.withValues(alpha: 0.7),
            width: isCenter ? 2.0 : 1.2,
          ),
          boxShadow: isCenter
              ? [
                  BoxShadow(
                    color: Colors.tealAccent.withValues(alpha: 0.35),
                    blurRadius: 20,
                    spreadRadius: 3,
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isCenter)
                const Icon(
                  Icons.wb_sunny_outlined,
                  color: Colors.tealAccent,
                  size: 22,
                ),
              if (isCenter) const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isCenter ? Colors.white : Colors.tealAccent,
                  fontSize: isCenter ? 13 : 11,
                  fontWeight:
                      isCenter ? FontWeight.w700 : FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}