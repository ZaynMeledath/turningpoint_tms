import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

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
            Flexible(
              child: SizedBox(
                height: 35.h,
                child: ListView.builder(
                  itemCount: filterList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Chip(
                      backgroundColor: AppColors.bottomSheetColor,
                      side: const BorderSide(
                        color: Colors.white12,
                      ),
                      padding: EdgeInsets.zero,
                      label: Text(
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
          ],
        ),
        SizedBox(height: 6.h),
      ],
    ),
  );
}
