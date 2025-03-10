
import 'package:chatter/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomInputDecoration {
  static InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: kBackgroundColor),
      filled: true, // Включаем заливку
      fillColor: kPrimaryColor, 
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBackgroundColor, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: kBackgroundColor),
      ),
    );
  }
}
