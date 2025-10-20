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
  // --- BẢNG MÀU MỚI CHO DARK MODE HIỆN ĐẠI (Deep Blue-Green Palette) ---

  // Màu nền tối sâu (Deep Slate Blue) 
  static const Color primaryBackground = Color(0xFF1C2733);

  // Màu chủ đạo (Vibrant Cyan) - Dùng cho nút bấm, icon active, thanh nổi bật. Năng lượng và hiện đại.
  static const Color primaryAccent = Color(0xFF00BCD4); // Cyan 500

  // Màu chữ chính (Pure White) - Tương phản tối đa trên nền tối
  static const Color primaryText = Color(0xFFFFFFFF);
// Màu cho nút bấm chính, sử dụng primaryAccent để đảm bảo tính nhất quán và nổi bật
  static const Color buttonColor = Color(0xFF26A69A);
  // Màu chữ phụ (Light Grey) - Dùng cho timestamp, văn bản ít quan trọng
  static const Color secondaryText = Color(0xFFB0BEC5); // Blue Grey 200

  // Màu tin nhắn người gửi (Soft Teal) - Dễ chịu, hài hòa với màu nền
  static const Color senderMessage = Color(0xFF009688); // Teal 500

  // Màu tin nhắn người nhận (Light Blue-Grey) - Phân biệt rõ ràng nhưng không quá chói
  static const Color receiverMessage = Color(0xFF455A64); // Blue Grey 700

  // Màu nền input field (Darker Slate) - Hợp nhất với nền chính, tạo cảm giác liền mạch
  static const Color sentMessageInput = Color(0xFF263238); // Blue Grey 900
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      // Màu Nút bấm, ActionBar, Icon Active
      primaryColor: DefaultColors.primaryAccent,
      colorScheme: const ColorScheme.dark(
        // Màu nổi bật (Accent)
        secondary: DefaultColors.primaryAccent,
        // Màu nền mặc định cho Scaffolds
        background: DefaultColors.primaryBackground,
        
      ),
      // Màu nền chính của màn hình
      scaffoldBackgroundColor: DefaultColors.primaryBackground,
      // Theme cho AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: DefaultColors.primaryBackground,
        foregroundColor:
            DefaultColors.primaryText, // Màu icon và chữ trên AppBar
        elevation: 0, // Bỏ đổ bóng cho giao diện phẳng
      ),

      // Theme cho Input Field (như TextField)
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: DefaultColors.sentMessageInput,
        filled: true,
        hintStyle: TextStyle(color: DefaultColors.secondaryText),
        border: InputBorder
            .none, // Hoặc OutlineInputBorder(borderRadius: BorderRadius.circular(20))
      ),

      // Cấu hình Text Theme - Sử dụng Roboto để giống font của Facebook Messenger (gần với Helvetica Neue)
      textTheme: TextTheme(
        // Title cho AppBar/Header
        titleMedium: GoogleFonts.roboto(
          fontSize: FontSizes.medium,
          color: DefaultColors.primaryText,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.roboto(
          fontSize: FontSizes.large,
          color: DefaultColors.primaryText,
          fontWeight: FontWeight.bold,
        ),
        // Body cho tin nhắn/nội dung chính
        bodySmall: GoogleFonts.roboto(
          fontSize: FontSizes.standardUp,
          color: DefaultColors.primaryText,
        ),
        // Body cho chi tiết nhỏ/thông tin phụ
        bodyMedium: GoogleFonts.roboto(
          fontSize: FontSizes.standard,
          color: DefaultColors.secondaryText, // Dùng màu phụ cho các text nhỏ
        ),
        // Body cho nội dung lớn hơn
        bodyLarge: GoogleFonts.roboto(
          fontSize: FontSizes.standardUp,
          color: DefaultColors.primaryText,
        ),
      ),
    );
  }
}