import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';

Widget cardActionButton({
  required String title,
  required IconData icon,
  required Color iconColor,
  required void Function()? onTap,
  Color? containerColor,
  double? containerWidth,
  double? containerHeight,
  double? iconSize,
  double? textSize,
}) {
  Color splashColor = AppColors.themeGreen;

  switch (title) {
    case 'In Progress':
      splashColor = Colors.blue;
      break;

    case 'Edit':
      splashColor = Colors.blueGrey;
      break;

    case 'Delete':
      splashColor = Colors.red;
      break;

    case 'Re Open':
      splashColor = Colors.orange;
      break;

    case 'Approve':
      splashColor = Colors.teal;

    default:
      break;
  }

  return InkWell(
    borderRadius: BorderRadius.circular(8),
    splashColor: splashColor,
    onTap: onTap,
    child: Container(
      width: containerWidth ?? 112.w,
      height: containerHeight ?? 38.h,
      decoration: BoxDecoration(
        color: containerColor ?? Colors.black.withOpacity(.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: iconSize ?? 20.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              title,
              style: TextStyle(
                fontSize: textSize ?? 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
