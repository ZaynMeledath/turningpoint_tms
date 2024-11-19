import 'package:flutter/material.dart';

extension StringExtensions on String {
  String nameFormat() {
    String result = '';
    if (trim().length < 3) {
      return toUpperCase();
    }
    final nameSplittedList = split(' ');
    for (int index = 0; index < nameSplittedList.length; index++) {
      if (nameSplittedList[index].isNotEmpty) {
        final firstLetter =
            nameSplittedList[index].characters.first.toUpperCase();
        final splittedString = nameSplittedList[index].substring(1);
        result += '$firstLetter$splittedString ';
      }
    }

    return result.trim();
  }

  String dateFormat() {
    //Week starts from monday to support the DateTime class
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
    final String date = dueDate.day.toString().padLeft(2, '0');

    final int hour24 = dueDate.hour;
    final int hour = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final int minute = dueDate.minute;
    final String period = hour24 >= 12 ? 'PM' : 'AM';
    final String time =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

    final String dateString = '$weekDay, $date $month $time';

    return dateString;
  }

  String dateFormatWithYear() {
    //Week starts from monday to support the DateTime class
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
    final String year = dueDate.year.toString();
    final String month = monthList[dueDate.month - 1];
    final String weekDay = weekList[dueDate.weekday - 1];
    final String date = dueDate.day.toString().padLeft(2, '0');

    final int hour24 = dueDate.hour;
    final int hour = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final int minute = dueDate.minute;
    final String period = hour24 >= 12 ? 'PM' : 'AM';
    final String time =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';

    final String dateString = '$weekDay, $date $month $year  $time';

    return dateString;
  }

  String getFirstLettersOfName() {
    final nameSplitArray = split(' ');
    final firstName = nameSplitArray.first;
    String lastName = nameSplitArray.last;
    if (nameSplitArray.length > 1) {
      lastName = nameSplitArray[1];
    }
    final firstLetter = firstName.characters.first.toUpperCase();
    final secondLetter = firstName == lastName
        ? lastName.characters.elementAt(1).toUpperCase()
        : lastName.characters.first.toUpperCase();

    return '$firstLetter$secondLetter';
  }
}
