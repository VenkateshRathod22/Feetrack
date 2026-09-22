import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ============================================================
// GOLD COLORS
// ============================================================

const Color primaryColor = Color(0xFFF5BA42);
const Color primaryColorDark = Color(0xFFE5A93C);
const Color primaryColorLight = Color(0xFFFFD56B);

const Color goldSurface = Color(0xFFFEF3D6);

// ============================================================
// BACKGROUND COLORS
// ============================================================

const Color backgroundDark = Color(0xFF040E22);
const Color surfaceNavy = Color(0xFF091327);
const Color cardBackground = Color(0xFF0D2040);

const Color surfaceLow = Color(0xFF121B30);
const Color surfaceBright = Color(0xFF30394F);

// ============================================================
// LIGHT CARD COLORS
// ============================================================

const Color cardWhite = Color(0xFFFFFFFF);
const Color cardWhiteSubtle = Color(0xFFF8FAFC);

// ============================================================
// TEXT COLORS
// ============================================================

const Color textPrimary = Color(0xFFF8FAFC);
const Color textSecondary = Color(0xFF94A3B8);
const Color textMuted = Color(0xFF64748B);

const Color textDarkPrimary = Color(0xFF0F172A);
const Color textDarkSecondary = Color(0xFF475569);
const Color textDarkMuted = Color(0xFF94A3B8);

// ============================================================
// STATUS COLORS
// ============================================================

const Color green = Color(0xFF10B981);
const Color greenLight = Color(0xFFD1FAE5);

const Color red = Color(0xFFEF4444);
const Color redLight = Color(0xFFFEE2E2);

const Color blue = Color(0xFF3B82F6);
const Color blueLight = Color(0xFFDBEAFE);

const Color yellow = Color(0xFFF59E0B);
const Color yellowLight = Color(0xFFFFF4E5);

// ============================================================
// BORDER COLORS
// ============================================================

const Color borderDark = Color(0xFF1E293B);
const Color borderLight = Color(0xFFE2E8F0);

// ============================================================
// COMMON
// ============================================================

const Color black = Colors.black;
const Color white = Colors.white;

// ============================================================
// GRADIENTS
// ============================================================

const LinearGradient goldGradient = LinearGradient(
  colors: [
    primaryColorLight,
    primaryColor,
    primaryColorDark,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const LinearGradient cardDarkGradient = LinearGradient(
  colors: [
    Color(0xFF0D2040),
    Color(0xFF091327),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class CustomTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: backgroundDark,
    hintColor: textMuted,
    canvasColor: backgroundDark,
    primaryColorLight: primaryColorLight,
    splashColor: primaryColor.withValues(
      alpha: 0.08,
    ),
    shadowColor: Colors.black45,
    cardColor: cardWhite,
    primaryColor: primaryColor,
    dividerColor: borderDark,
    primaryColorDark: primaryColorDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      onPrimary: textDarkPrimary,
      secondary: primaryColorLight,
      onSecondary: textDarkPrimary,
      surface: surfaceNavy,
      onSurface: textPrimary,
      error: red,
      onError: white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundDark,
      foregroundColor: textPrimary,
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(
        color: textPrimary,
        size: 24.r,
      ),
      actionsIconTheme: IconThemeData(
        color: textPrimary,
        size: 22.r,
      ),
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: textPrimary,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: backgroundDark,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: textDarkPrimary,
        minimumSize: Size(
          double.infinity,
          54.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: BorderSide(
          color: primaryColor,
          width: 1.5.w,
        ),
        minimumSize: Size(
          double.infinity,
          54.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceNavy,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 16.h,
      ),
      hintStyle: GoogleFonts.plusJakartaSans(
        fontSize: 15.sp,
        color: textMuted,
      ),
      labelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 14.sp,
        color: textSecondary,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: borderDark,
          width: 1.2.w,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: primaryColor,
          width: 1.5.w,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: BorderSide(
          color: red,
          width: 1.2.w,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: cardWhite,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: GoogleFonts.plusJakartaSans(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.plusJakartaSans(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16.sp,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14.sp,
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 12.sp,
      ),
    ),
  );
}
