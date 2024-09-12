import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Widget nameLetterAvatar({
  required String name,
  Color? backgroundColor,
  double? circleDiameter,
}) {
  final nameSplitArray = name.split(' ');
  final firstName = nameSplitArray.first;
  String lastName = nameSplitArray.last;
  if (nameSplitArray.length > 1) {
    lastName = nameSplitArray[1];
  }
  final firstLetter = firstName.characters.first.toUpperCase();
  final secondLetter = firstName == lastName
      ? lastName.characters.elementAt(1).toUpperCase()
      : lastName.characters.first.toUpperCase();

  return Container(
    width: circleDiameter ?? 38.w,
    height: circleDiameter ?? 38.w,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backgroundColor?.withOpacity(.65) ??
          AppColors.themeGreen.withOpacity(.65),
      border: Border.all(
        color: backgroundColor ?? AppColors.themeGreen,
        width: (circleDiameter ?? 38) / 35,
      ),
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
