import 'package:flutter/material.dart';

/// Application color palette following the design system.
/// Primary: #00F5D4 (Teal/Cyan)
/// Secondary: #FFB703 (Amber/Gold)
/// Tertiary: #C77DFF (Purple)
/// Neutral: #0D1B2A (Dark Navy)
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Colors
  static const Color primary = Color(0xFF00F5D4);
  static const Color primaryDark = Color(0xFF00D4B0);
  static const Color primaryLight = Color(0xFF66FFEB);

  // Secondary Colors
  static const Color secondary = Color(0xFFFFB703);
  static const Color secondaryDark = Color(0xFFE6A500);
  static const Color secondaryLight = Color(0xFFFFD233);

  // Tertiary Colors
  static const Color tertiary = Color(0xFFC77DFF);
  static const Color tertiaryDark = Color(0xFFB366E6);
  static const Color tertiaryLight = Color(0xFFE0B3FF);

  // Neutral Colors
  static const Color neutral = Color(0xFF0D1B2A);
  static const Color neutralDark = Color(0xFF050A12);
  static const Color neutralLight = Color(0xFF1A2F47);

  // Background Colors
  static const Color background = Color(0xFF0D1B2A);
  static const Color surfaceDark = Color(0xFF1A2F47);
  static const Color surfaceLight = Color(0xFF2A4563);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B8C1);
  static const Color textTertiary = Color(0xFF7A8A99);

  // Status Colors
  static const Color success = Color(0xFF00F5D4);
  static const Color warning = Color(0xFFFFB703);
  static const Color error = Color(0xFFFF6B6B);
  static const Color info = Color(0xFF4A90E2);

  // Border Colors
  static const Color borderLight = Color(0xFF2A4563);
  static const Color borderMedium = Color(0xFF3A5573);
  static const Color borderDark = Color(0xFF1A2F47);
}
