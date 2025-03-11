import 'package:flutter/material.dart';

const Color white = Color(0xFFFFFFFF);
const Color green = Color(0xFF00C853); 
const Color darkGreen = Color(0xFF66BB6A);
const Color stroke = Color(0xFF1E1E1E);
const Color black = Color(0xFF121212); 
const Color gray = Color(0xFFB0BEC5); 
const Color darkBlack = Color(0xFF000000);
const Color darkGray = Color(0xFF78909C); 
const Color kPrimaryColor = Color(0xFF004D40); 
const Color kAccentColor = Color(0xFFFF7043);
const Color kBackgroundColor = Color(0xFF121212); 
const Color kTextColor = Color(0xFFE0E0E0);
const Color kIconHighlightColor = Color(0xFFFFC107); 

final ThemeData darkTheme = ThemeData(
  fontFamily: 'Gilroy',
  brightness: Brightness.dark,
  primaryColor: darkGreen,
  scaffoldBackgroundColor: black,
  canvasColor: stroke,
  appBarTheme: AppBarTheme(
    backgroundColor: darkBlack,
  ),
  textTheme: TextTheme(
    titleLarge:
        TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: white),
    titleMedium:
        TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: gray),
    labelLarge:
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: gray),
    labelMedium:
        TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: white),
    labelSmall:
        TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: gray),
    displayMedium:
        TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: white),
  ),
  iconTheme: IconThemeData(color: gray),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkGreen,
      foregroundColor: black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: stroke,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  ),
  cardTheme: CardTheme(
    color: darkGreen,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);




