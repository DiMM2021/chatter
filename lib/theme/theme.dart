import 'package:flutter/material.dart';

const Color white = Color(0xFFFFFFFF);
const Color green = Color(0xFF3CED78);
const Color darkGreen = Color(0xFF00521C);
const Color stroke = Color(0xFFEDF2F6);
const Color black = Color(0xFF2B333E);
const Color gray = Color(0xFF9DB7CB);
const Color darkBlack = Color(0xFF000000);
const Color darkGray = Color(0xFF5E7A90);

final ThemeData chatTheme = ThemeData(
  fontFamily: 'Gilroy',
  brightness: Brightness.light,
  primaryColor: green,
  scaffoldBackgroundColor: white,
  canvasColor: stroke,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    titleLarge:
        TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: black),
    titleMedium:
        TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: white),
    labelLarge:
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: gray),
    labelMedium:
        TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: darkBlack),
    labelSmall:
        TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: darkGray),
  ),
  iconTheme: IconThemeData(color: black),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: stroke,
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
    color: green,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
);
