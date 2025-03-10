import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatDateDivider extends StatelessWidget {
  final DateTime date;

  const ChatDateDivider({required this.date, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Divider(color: Colors.grey[400], thickness: 1.0)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              DateFormat('dd MMM yyyy').format(date),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[400], thickness: 1.0)),
        ],
      ),
    );
  }
}
