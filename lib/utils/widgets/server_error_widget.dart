import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Widget serverErrorWidget({
  required void Function() onRefresh,
  required bool isLoading,
}) {
  return Column(
    children: [
      Lottie.asset(
        'assets/lotties/server_error_animation.json',
        width: 160.w,
      ),
      Text(
        'Something Went Wrong!',
        style: TextStyle(
          fontSize: 18.sp,
        ),
      ),
      SizedBox(height: 20.h),
      InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onRefresh,
        child: Container(
          width: 90.w,
          height: 35.w,
          decoration: BoxDecoration(
            color: AppColors.themeGreen.withOpacity(.9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: isLoading
                ? SpinKitWave(
                    color: Colors.white70,
                    size: 14.w,
                  )
                : Text(
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
