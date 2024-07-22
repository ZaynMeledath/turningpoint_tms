import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Widget filterItem({
  required String title,
  required bool isActive,
}) {
  return AnimatedContainer(
    width: double.maxFinite,
    height: 45.h,
    duration: const Duration(milliseconds: 300),
    color: isActive ? Colors.grey.withOpacity(.15) : Colors.transparent,
    child: Row(
      children: [
        // isActive ?
        AnimatedContainer(
          width: 10.w,
          height: double.maxFinite,
          duration: const Duration(milliseconds: 300),
          color: isActive ? AppColor.themeGreen : Colors.transparent,
        ),
        // : const SizedBox(),
        SizedBox(width: 10.w),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
