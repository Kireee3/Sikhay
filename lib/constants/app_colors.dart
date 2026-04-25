import 'package:flutter/material.dart';

/// Application color palette following the design system.
/// Text on dark / Hover: #FBF0D3 (Warm Cream)
/// Background:           #FFFFFF (White)
/// Text & Buttons:       #131415 (Near Black)
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Colors
  static const Color primary = Color(0xFF131415);
  static const Color primaryDark = Color(0xFF000000);
  static const Color primaryLight = Color(0xFF2C2E30);

  // Secondary Colors
  static const Color secondary = Color(0xFFFBF0D3);
  static const Color secondaryDark = Color(0xFFE8D9B0);
  static const Color secondaryLight = Color(0xFFFFF8EC);

  // Tertiary Colors
  static const Color tertiary = Color(0xFF131415);
  static const Color tertiaryDark = Color(0xFF000000);
  static const Color tertiaryLight = Color(0xFF2C2E30);

  // Neutral Colors
  static const Color neutral = Color(0xFF131415);
  static const Color neutralDark = Color(0xFF000000);
  static const Color neutralLight = Color(0xFF2C2E30);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFFF5F5F5);
  static const Color surfaceLight = Color(0xFFFAFAFA);

  // Text Colors
  static const Color textPrimary = Color(0xFF131415);
  static const Color textSecondary = Color(0xFF131415);
  static const Color textTertiary = Color(0xFF131415);

  // Text on Dark / Hover Color
  static const Color textOnDark = Color(0xFFFBF0D3);
  static const Color hover = Color(0xFFFBF0D3);

  // Status Colors
  static const Color success = Color(0xFF131415);
  static const Color warning = Color(0xFFFBF0D3);
  static const Color error = Color(0xFF131415);
  static const Color info = Color(0xFF131415);

  // Border Colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderMedium = Color(0xFFBDBDBD);
  static const Color borderDark = Color(0xFF131415);
}