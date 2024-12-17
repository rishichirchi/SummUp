import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xFF075E54),
  cardColor: const Color(0xFF25D366),
  dialogBackgroundColor: const Color(0xFFECE5DD),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF25D366),
    textTheme: ButtonTextTheme.primary,
  ),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF075E54),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF25D366),
  ),
  textTheme: GoogleFonts.interTextTheme()
);
