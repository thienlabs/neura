import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizes {
  static const small = 12.0;
  static const standard = 14.0;
  static const standardUp = 16.0;
  static const medium = 20.0;
  static const large = 28.0;
}

class DefaultColors {
  static const Color greyText = Color(0xFF8A94A6); // Softer gray for secondary text
  static const Color whiteText = Color(0xFFF5F7FA); // Off-white for better contrast
  static const Color senderMessage = Color(0xFFFF8A80); // Warm coral for sender messages
  static const Color receiverMessage = Color(0xFF4A6FA5); // Cool blue for receiver messages
  static const Color sentMessageInput = Color(0xFF2A2D3E); // Darker input field
  static const Color messageListPage = Color(0xFF1E222B); // Deep blue-gray background
  static const Color buttonColor = Color(0xFFFF8A80); // Matching coral for buttons
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: DefaultColors.buttonColor,
      scaffoldBackgroundColor: DefaultColors.messageListPage,
      textTheme: TextTheme(
        titleMedium: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.medium,
          color: DefaultColors.whiteText,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.large,
          color: DefaultColors.whiteText,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standardUp,
          color: DefaultColors.whiteText,
        ),
        bodyMedium: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standard,
          color: DefaultColors.whiteText,
        ),
        bodyLarge: GoogleFonts.alegreyaSans(
          fontSize: FontSizes.standardUp,
          color: DefaultColors.whiteText,
        ),
      ),
    );
  }
}