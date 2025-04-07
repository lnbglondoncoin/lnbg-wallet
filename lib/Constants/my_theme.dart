import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      bodyMedium: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
      titleLarge: GoogleFonts.urbanist(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.orange),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.orange),
      trackColor: WidgetStateProperty.all(Colors.orange.withValues(alpha:0.5)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.urbanist(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      bodyMedium: GoogleFonts.urbanist(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
      titleLarge: GoogleFonts.urbanist(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.orange),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.orange),
      trackColor: WidgetStateProperty.all(Colors.orange.withValues(alpha:0.5)),
    ),
  );
}
