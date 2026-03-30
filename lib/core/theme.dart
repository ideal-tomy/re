import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors for "Neo Histo-Pop"
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F9FA);
  static const Color energyCyan = Color(0xFF00E5FF);
  static const Color bubblegumPink = Color(0xFFFF4081);
  static const Color sunshineYellow = Color(0xFFFFD600);
  static const Color textDark = Color(0xFF212121);
  static const Color textLight = Color(0xFF757575);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: energyCyan,
        primary: energyCyan,
        secondary: bubblegumPink,
        tertiary: sunshineYellow,
        surface: primaryWhite,
        background: offWhite,
      ),
      scaffoldBackgroundColor: offWhite,
      textTheme: GoogleFonts.notoSansJpTextTheme().copyWith(
        displayLarge: GoogleFonts.notoSansJp(
          fontWeight: FontWeight.bold,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.notoSansJp(
          color: textDark,
          fontSize: 16,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryWhite,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: primaryWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: energyCyan,
          foregroundColor: primaryWhite,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
