// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';

// Map<int, Color> color = const {
//   50: Color.fromRGBO(255, 244, 149, .1),
//   100: Color.fromRGBO(255, 244, 149, .2),
//   200: Color.fromRGBO(255, 244, 149, .3),
//   300: Color.fromRGBO(255, 244, 149, .4),
//   400: Color.fromRGBO(255, 244, 149, .5),
//   500: Color.fromRGBO(255, 244, 149, .6),
//   600: Color.fromRGBO(255, 244, 149, .7),
//   700: Color.fromRGBO(255, 244, 149, .8),
//   800: Color.fromRGBO(255, 244, 149, .9),
//   900: Color.fromRGBO(255, 244, 149, 1),
// };
// MaterialColor colorCustom = MaterialColor(0XFFFFF495, color);

// class CustomTheme {
//   static ThemeData light = ThemeData(
//     fontFamily: "Montserrat",
//     brightness: Brightness.light,
//     useMaterial3: true,
//     scaffoldBackgroundColor: backgroundLight,
//     hintColor: Colors.grey[700],
//     primarySwatch: colorCustom,
//     canvasColor: secondaryColor,
//     primaryColorLight: secondaryColor,
//     splashColor: secondaryColor,
//     shadowColor: Colors.grey[600],
//     cardColor: Colors.grey[100],
//     primaryColor: primaryColor,
//     dividerColor: Colors.grey[600],
//     primaryColorDark: Colors.black,
//     colorScheme: ColorScheme(
//       brightness: Brightness.light,
//       primary: primaryColor,
//       onPrimary: Colors.white,
//       secondary: secondaryColor,
//       onSecondary: Colors.black,
//       error: const Color(0xFFCF6679),
//       onError: const Color(0xFFCF6679),
//       background: backgroundLight,
//       onBackground: Colors.black,
//       surface: backgroundLight,
//       onSurface: Colors.black,
//     ),
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.transparent,
//       actionsIconTheme: IconThemeData(
//         color: black,
//       ),
//       iconTheme: IconThemeData(
//         color: black,
//       ),
//       systemOverlayStyle: SystemUiOverlayStyle(
//         // Status bar color
//         statusBarColor: primaryColor,
//         // Status bar brightness (optional)
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.light,
//       ),
//     ),
//     typography: Typography.material2021(),
//     textTheme: TextTheme(
//       // Buttons / labels
//       labelLarge: GoogleFonts.openSans(
//         fontWeight: FontWeight.w500,
//         color: textSecondary,
//         fontSize: 14,
//       ),

//       // Large headings (screen titles)
//       headlineLarge: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w800,
//       ),

//       headlineMedium: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w700,
//       ),

//       headlineSmall: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600,
//       ),

//       // Big display text / hero banners
//       displayLarge: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w800,
//       ),

//       displayMedium: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w700,
//       ),

//       displaySmall: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600,
//       ),

//       // AppBar / section titles
//       titleLarge: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w800,
//       ),

//       titleMedium: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w700,
//       ),

//       titleSmall: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w600,
//       ),

//       // Main app content
//       bodyLarge: GoogleFonts.manrope(
//         fontWeight: FontWeight.w600,
//       ),

//       bodyMedium: GoogleFonts.manrope(
//         fontWeight: FontWeight.w500,
//       ),

//       bodySmall: GoogleFonts.manrope(
//         fontWeight: FontWeight.w400,
//       ),
//     ),
//   );
//   static ThemeData dark = ThemeData(
//     brightness: Brightness.dark,
//     useMaterial3: true,
//     scaffoldBackgroundColor: backgroundDark,
//     hintColor: Colors.grey[700],
//     primarySwatch: colorCustom,
//     canvasColor: secondaryColor,
//     primaryColorLight: secondaryColor,
//     splashColor: secondaryColor,
//     shadowColor: Colors.black45,
//     cardColor: Colors.grey[800],
//     primaryColor: primaryColor,
//     dividerColor: Colors.grey[200],
//     primaryColorDark: Colors.white,
//     colorScheme: ColorScheme(
//       brightness: Brightness.dark,
//       primary: primaryColor,
//       onPrimary: Colors.white,
//       secondary: secondaryColor,
//       onSecondary: Colors.black,
//       error: const Color(0xFFCF6679),
//       onError: const Color(0xFFCF6679),
//       background: backgroundDark,
//       onBackground: Colors.white,
//       surface: backgroundDark,
//       onSurface: Colors.white,
//     ),
//     appBarTheme: AppBarTheme(
//       backgroundColor: primaryColor,
//       actionsIconTheme: IconThemeData(
//         color: backgroundLight,
//       ),
//       iconTheme: IconThemeData(
//         color: backgroundLight,
//       ),
//       systemOverlayStyle: const SystemUiOverlayStyle(
//         // Status bar color
//         statusBarColor: primaryColor,
//         // Status bar brightness (optional)
//         statusBarIconBrightness: Brightness.light,
//         statusBarBrightness: Brightness.light,
//       ),
//     ),
//     typography: Typography.material2021(),
//     textTheme: TextTheme(
//       labelLarge: GoogleFonts.openSans(
//         fontWeight: FontWeight.w400,
//         color: textSecondary,
//         fontSize: 14.0,
//       ),
//       headlineLarge: GoogleFonts.openSans(),
//       headlineMedium: GoogleFonts.openSans(),
//       headlineSmall: GoogleFonts.openSans(),
//       displayLarge: GoogleFonts.openSans(),
//       displayMedium: GoogleFonts.openSans(),
//       displaySmall: GoogleFonts.openSans(),
//       titleLarge: GoogleFonts.openSans(),
//       titleMedium: GoogleFonts.openSans(),
//       titleSmall: GoogleFonts.openSans(),
//       bodyLarge: GoogleFonts.openSans(),
//       bodyMedium: GoogleFonts.openSans(),
//       bodySmall: GoogleFonts.openSans(),
//     ),
//   );
// }

import 'package:flutter/material.dart';

class AppColors {
  // ============================================================
  // BRAND / GOLD
  // ============================================================

  static const Color primaryGold = Color(0xFFF5BA42);
  static const Color primaryGoldDark = Color(0xFFE5A93C);
  static const Color primaryGoldLight = Color(0xFFFFD56B);

  static const Color goldSurfaceTint = Color(0xFFFEF3D6);

  // ============================================================
  // DARK BACKGROUND
  // ============================================================

  static const Color background = Color(0xFF040E22);
  static const Color surfaceNavy = Color(0xFF091327);
  static const Color surfaceCard = Color(0xFF0D2040);

  static const Color surfaceContainerLow = Color(0xFF121B30);
  static const Color surfaceContainerBright = Color(0xFF30394F);

  // ============================================================
  // LIGHT CARDS
  // ============================================================

  static const Color surfaceLightCard = Color(0xFFFFFFFF);
  static const Color surfaceLightCardSubtle = Color(0xFFF8FAFC);

  // ============================================================
  // TEXT
  // ============================================================

  static const Color textLightPrimary = Color(0xFFF8FAFC);
  static const Color textLightSecondary = Color(0xFF94A3B8);
  static const Color textLightMuted = Color(0xFF64748B);

  static const Color textDarkPrimary = Color(0xFF0F172A);
  static const Color textDarkSecondary = Color(0xFF475569);
  static const Color textDarkMuted = Color(0xFF94A3B8);

  // ============================================================
  // STATUS
  // ============================================================

  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // ============================================================
  // BORDERS
  // ============================================================

  static const Color borderDark = Color(0xFF1E293B);
  static const Color borderLight = Color(0xFFE2E8F0);

  // ============================================================
  // GRADIENTS
  // ============================================================

  static const LinearGradient goldGradient = LinearGradient(
    colors: [
      primaryGoldLight,
      primaryGold,
      primaryGoldDark,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardDarkGradient = LinearGradient(
    colors: [
      Color(0xFF0D2040),
      Color(0xFF091327),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}