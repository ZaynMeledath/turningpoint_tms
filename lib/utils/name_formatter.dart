import 'package:flutter/material.dart';

String nameFormatter({
  required String name,
}) {
  String result = '';
  final nameList = name.split(' ');
  for (int index = 0; index < nameList.length; index++) {
    final firstLetter = nameList[index].characters.first.toUpperCase();
    final splittedString = nameList[index].substring(1);
    result += '$firstLetter$splittedString ';
  }

  return result;
}
