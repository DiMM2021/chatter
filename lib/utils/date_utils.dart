import 'package:intl/intl.dart';

String formatChatDate(DateTime date) {
  final now = DateTime.now();
  final yesterday = now.subtract(Duration(days: 1));

  if (DateFormat('yyyyMMdd').format(date) == DateFormat('yyyyMMdd').format(now)) {
    return "Сегодня";
  } else if (DateFormat('yyyyMMdd').format(date) == DateFormat('yyyyMMdd').format(yesterday)) {
    return "Вчера";
  } else {
    return DateFormat('dd.MM.yy').format(date);
  }
}
