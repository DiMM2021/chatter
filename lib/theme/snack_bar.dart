
import 'package:chatter/theme/theme.dart';
import 'package:flutter/material.dart';

class SnackBarService {
  static const errorColor = kAccentColor;
  static const successColor = kIconHighlightColor;

  static Future<void> showSnackBar(
      BuildContext context, String message, bool error) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.black54)),
      backgroundColor: error ? errorColor : successColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
