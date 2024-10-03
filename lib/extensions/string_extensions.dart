import 'package:flutter/material.dart';

extension StringExtensions on String {
  String nameFormat() {
    String result = '';
    if (trim().length < 3) {
      return toUpperCase();
    }
    final nameSplittedList = split(' ');
    for (int index = 0; index < nameSplittedList.length; index++) {
      final firstLetter =
          nameSplittedList[index].characters.first.toUpperCase();
      final splittedString = nameSplittedList[index].substring(1);
      result += '$firstLetter$splittedString ';
    }

    return result.trim();
  }

  String dateFormat() {
    final weekList = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    final monthList = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final DateTime dueDate = DateTime.parse(this).toLocal();
    final String month = monthList[dueDate.month - 1];
    final String weekDay = weekList[dueDate.weekday - 1];
    final int date = dueDate.day;

    final int hour24 = dueDate.hour;
    final int hour = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final int minute = dueDate.minute;
    final String period = hour24 >= 12 ? 'PM' : 'AM';
    final String time =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

    final String dueDateString = '$weekDay, $date $month $time';

    return dueDateString;
  }
}
