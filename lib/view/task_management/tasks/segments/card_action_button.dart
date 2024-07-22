import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Widget cardActionButton({
  required String title,
  required IconData icon,
  required Color iconColor,
  required void Function()? onTap,
}) {
  Color splashColor = AppColor.themeGreen;

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

    default:
      break;
  }

  return InkWell(
    borderRadius: BorderRadius.circular(8),
    splashColor: splashColor,
    onTap: onTap,
    child: Container(
      width: 108.w,
      height: 38.h,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 20.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
