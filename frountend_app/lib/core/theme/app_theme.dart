import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class AppTheme {
  static const Color primaryGreen = Color(0xFF1E5631); 
  static const Color accentGold = Color(0xFFD4AF37); 
  static const Color bgLight = Color(0xFFF8F9FA);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bgLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: accentGold,
        surface: Colors.white,
      ),
      textTheme: GoogleFonts.cairoTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
