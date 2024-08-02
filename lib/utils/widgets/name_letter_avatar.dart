import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Widget nameLetterAvatar({
  required String name,
  Color? backgroundColor,
  double? circleDiameter,
}) {
  final firstName = name.split(' ').first;
  final lastName = name.split(' ').last;
  final firstLetter = firstName.characters.first.toUpperCase();
  final secondLetter = firstName == lastName
      ? lastName.characters.elementAt(1).toUpperCase()
      : lastName.characters.first.toUpperCase();

  return Container(
    width: circleDiameter ?? 38.w,
    height: circleDiameter ?? 38.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backgroundColor ?? AppColor.themeGreen,
    ),
    child: Center(
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: circleDiameter != null ? circleDiameter * .375 : 15,
          fontWeight: FontWeight.w600,
        ),
        child: Text(
          firstLetter + secondLetter,
        ),
      ),
    ),
  );
}
