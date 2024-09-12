import 'package:flutter/material.dart';

// String nameFormatter({
//   required String name,
// }) {
//   String result = '';
//   final nameList = name.split(' ');
//   for (int index = 0; index < nameList.length; index++) {
//     final firstLetter = nameList[index].characters.first.toUpperCase();
//     final splittedString = nameList[index].substring(1);
//     result += '$firstLetter$splittedString ';
//   }

//   return result;
// }

extension StringExtensions on String {
  String nameFormat() {
    String result = '';
    if (trim().length < 2) {
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
    final dueDate = DateTime.parse(this);
    final month = monthList[dueDate.month - 1];
    final weekDay = weekList[dueDate.weekday - 1];
    final date = dueDate.day;

    final hour24 = dueDate.hour;
    final hour = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = dueDate.minute;
    final period = hour24 >= 12 ? 'PM' : 'AM';
    final time =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

    final dueDateString = '$weekDay, $date $month $time';

    return dueDateString;
  }
}
