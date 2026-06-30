import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFFF5A623);
  static const Color primaryDark = Color(0xFFE07000);
  static const Color background = Color(0xFFF5F0E8);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF888888);
  static const Color textDarkBrown = Color(0xFF2D1B00);
  static const Color green = Color(0xFF2E7D32);
  static const Color greenLight = Color(0xFF4CAF50);
  static const Color red = Color(0xFFE53935);
  static const Color badgeRed = Color(0xFFCC3333);
  static const Color orange = Color(0xFFF5A623);
  static const Color orangeText = Color(0xFFC65E00);
  static const Color statBadgeBg = Color(0xFFFFD699);
  static const Color greenBadgeBg = Color(0xFFE8F5E9);
  static const Color priceSale = Color(0xFF2E7D32);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        background: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}