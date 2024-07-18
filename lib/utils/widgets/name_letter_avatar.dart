import 'package:flutter/material.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Widget nameLetterAvatar({
  required String firstName,
  required String lastName,
  Color? backgroundColor,
  double? circleDiameter,
}) {
  final firstLetter = firstName.characters.first;
  final secondLetter = lastName.characters.first;

  return Container(
    width: circleDiameter ?? 40,
    height: circleDiameter ?? 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backgroundColor ?? AppColor.themeGreen,
    ),
    child: Center(
      child: Text(
        firstLetter + secondLetter,
        style: TextStyle(
          fontSize: circleDiameter != null ? circleDiameter * .375 : 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
