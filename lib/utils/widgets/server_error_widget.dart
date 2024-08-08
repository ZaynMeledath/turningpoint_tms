import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Widget serverErrorWidget({
  required void Function() onRefresh,
}) {
  return Column(
    children: [
      Lottie.asset(
        'assets/lotties/server_error_animation.json',
        width: 200.w,
      ),
      Text(
        'Something Went Wrong',
        style: TextStyle(
          fontSize: 20.sp,
        ),
      ),
      SizedBox(height: 24.h),
      InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onRefresh,
        child: Container(
          width: 90.w,
          height: 35.w,
          decoration: BoxDecoration(
            color: AppColor.themeGreen.withOpacity(.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              'Try Again',
              style: TextStyle(
                fontSize: 14.w,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
