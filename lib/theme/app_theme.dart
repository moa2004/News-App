import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFFF4F4F4),
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF1C1C1C),
        secondary: Color(0xFF5E8AFF),
        surface: Color(0xFFF7F7F7),
      ),
      textTheme: GoogleFonts.rubikTextTheme(base.textTheme).apply(
        bodyColor: const Color(0xFF1A1A1A),
        displayColor: const Color(0xFF1A1A1A),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF7F7F7),
        foregroundColor: Color(0xFF0F0F0F),
        elevation: 0,
        centerTitle: true,
      ),
      cardColor: const Color(0xFFFFFFFF),
      dividerColor: Colors.grey.shade300,
      iconTheme: const IconThemeData(color: Color(0xFF1C1C1C)),
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF0F0F0F),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFFF8F8F8),
        secondary: Color(0xFF8BD1FF),
        surface: Color(0xFF1E1E1E),
      ),
      textTheme: GoogleFonts.rubikTextTheme(base.textTheme).apply(
        bodyColor: const Color(0xFFF5F5F5),
        displayColor: const Color(0xFFF5F5F5),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF161616),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardColor: const Color(0xFF1F1F1F),
      dividerColor: Colors.grey.shade800,
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
