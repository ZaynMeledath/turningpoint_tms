import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';

Widget selectedFilter({
  required String title,
  required List filterList,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$title : ',
              style: TextStyle(
                fontSize: 14.5.sp,
                color: AppColors.themeGreen,
              ),
            ),
            SizedBox(width: 4.w),
            Flexible(
              child: SizedBox(
                height: 35.h,
                child: ListView.builder(
                  itemCount: filterList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.bottomSheetColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white12,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          filterList[index],
                          style: TextStyle(
                            fontSize: 14.5.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
      ],
    ),
  ).animate().fadeIn(
        begin: 0,
      );
}
