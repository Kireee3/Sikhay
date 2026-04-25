import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Application typography following the design system.
/// Headers use: Adriane Text
/// Body text uses: Gordita
class AppTypography {
  AppTypography._(); // Private constructor to prevent instantiation

  // Header Text Styles (Adriane Text)
  static const TextStyle headingXLarge = TextStyle(
    fontFamily: 'AdrianText',
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.5,
  );

  static const TextStyle headingLarge = TextStyle(
    fontFamily: 'AdrianText',
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.3,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: 'AdrianText',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.2,
  );

  static const TextStyle headingSmall = TextStyle(
    fontFamily: 'AdrianText',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Body Text Styles (Gordita)
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Gordita',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Gordita',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Gordita',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Label Text Styles (Gordita)
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Gordita',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Gordita',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Gordita',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    height: 1.3,
    letterSpacing: 0.2,
  );

  // Caption Text Styles (Gordita)
  static const TextStyle caption = TextStyle(
    fontFamily: 'Gordita',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.4,
  );

  static const TextStyle captionSmall = TextStyle(
    fontFamily: 'Gordita',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textTertiary,
    height: 1.3,
  );
}
