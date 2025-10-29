import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizes {
  static const small = 12.0;
  static const standard = 14.0;
  static const standardUp = 16.0;
  static const medium = 20.0;
  static const large = 28.0;
}

class AppColors {
  //Dark Mode
  static const Color primaryBackground = Color(0xFF1C2733);

  static const Color primaryAccent = Color(0xFF00BCD4);

  static const Color primaryText = Color(0xFFFFFFFF);

  static const Color buttonColor = Color(0xFF26A69A);

  static const Color secondaryText = Color(0xFFB0BEC5);

  static const Color senderMessage = Color(0xFF009688);

  static const Color receiverMessage = Color(0xFF455A64);

  static const Color sentMessageInput = Color(0xFF263238);

  //LighMode
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: AppColors.primaryAccent,
      colorScheme: const ColorScheme.dark(
        secondary: AppColors.primaryAccent,
        background: AppColors.primaryBackground,
      ),

      scaffoldBackgroundColor: AppColors.primaryBackground,

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryBackground,
        foregroundColor: AppColors.primaryText,
        elevation: 0,
      ),

      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.sentMessageInput,
        filled: true,
        hintStyle: TextStyle(color: AppColors.secondaryText),
        border: InputBorder.none,
      ),

      textTheme: TextTheme(
        // Title cho AppBar/Header
        titleMedium: GoogleFonts.roboto(
          fontSize: FontSizes.medium,
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.roboto(
          fontSize: FontSizes.large,
          color: AppColors.primaryText,
          fontWeight: FontWeight.bold,
        ),

        bodySmall: GoogleFonts.roboto(
          fontSize: FontSizes.standardUp,
          color: AppColors.primaryText,
        ),

        bodyMedium: GoogleFonts.roboto(
          fontSize: FontSizes.standard,
          color: AppColors.secondaryText,
        ),

        bodyLarge: GoogleFonts.roboto(
          fontSize: FontSizes.standardUp,
          color: AppColors.primaryText,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryAccent,
      colorScheme: const ColorScheme.light(
        secondary: AppColors.primaryAccent,
        background: Colors.white,
      ),

      scaffoldBackgroundColor: Colors.white,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      textTheme: TextTheme(
        titleMedium: GoogleFonts.roboto(
          fontSize: FontSizes.medium,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.roboto(
          fontSize: FontSizes.large,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: FontSizes.standardUp,
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: FontSizes.standard,
          color: Colors.black54,
        ),
        bodyLarge: GoogleFonts.roboto(
          fontSize: FontSizes.standardUp,
          color: Colors.black87,
        ),
      ),
    );
  }
}
