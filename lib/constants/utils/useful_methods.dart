import 'package:intl/intl.dart';

class UsefulMethods {
  static formatDate({required value, bool showTime = false}) {
    var month = DateFormat.MMMd()
        .format(DateTime.parse(value ?? DateTime.now().toString()));
    var year = DateFormat.y()
        .format(DateTime.parse(value ?? DateTime.now().toString()));
    var time = DateFormat.jm()
        .format(DateTime.parse(value ?? DateTime.now().toString()));
    if (showTime) {
      return '$month $year $time';
    } else {
      return '$month $year';
    }
  }
}
