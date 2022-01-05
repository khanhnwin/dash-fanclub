import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData myDashTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: Color.fromRGBO(0, 169, 224, 1.0),
    primaryVariant: Color.fromRGBO(0, 119, 200, 1.0),
    secondary: Color.fromRGBO(29, 79, 145, 1.0),
    secondaryVariant: Color.fromRGBO(198, 218, 231, 1.0),
    error: Color(0xb71c1cff),
    surface: Color.fromRGBO(255, 255, 255, 1.0),
    onPrimary: Color.fromRGBO(255, 255, 255, 1.0),
    background: Color.fromRGBO(198, 218, 231, 1.0),
    onSecondary: Color.fromRGBO(255, 255, 255, 1.0),
    onError: Color.fromRGBO(255, 255, 255, 1.0),
    brightness: Brightness.light,
    onBackground: Color(0x000000FF),
    onSurface: Color(0x000000FF),
  ),
  textTheme: GoogleFonts.robotoTextTheme(),
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.patuaOne(
      fontSize: 28,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(0, 169, 224, 1.0),
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(0, 169, 224, 1.0),
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(0, 169, 224, 1.0),
      ),
    ),
  ),
);
