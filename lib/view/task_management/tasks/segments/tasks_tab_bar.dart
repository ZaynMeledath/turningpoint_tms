import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

Widget tasksTabBar({
  required TabController tabController,
}) {
  return TabBar(
    controller: tabController,
    isScrollable: true,
    physics: const BouncingScrollPhysics(),
    labelPadding: EdgeInsets.only(
      bottom: 10.h,
      right: 15.w,
      left: 15.w,
      top: 10.h,
    ),
    splashBorderRadius: BorderRadius.circular(16),
    indicatorPadding: EdgeInsets.only(bottom: 5.h),
    dividerColor: Colors.transparent,
    indicatorColor: AppColor.themeGreen,
    labelColor: AppColor.themeGreen,
    tabs: [
      Row(
        children: [
          Icon(
            Icons.task_alt,
            size: 21.sp,
          ),
          SizedBox(width: 2.w),
          Text(
            'All',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.circle,
            size: 20.sp,
            color: Colors.red,
          ),
          SizedBox(width: 2.w),
          Text(
            'Overdue',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.circle,
            size: 20.sp,
            color: Colors.orange,
          ),
          SizedBox(width: 2.w),
          Text(
            'Pending',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.circle,
            size: 20.sp,
            color: Colors.blue,
          ),
          SizedBox(width: 2.w),
          Text(
            'In Progress',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.circle,
            size: 20.sp,
            color: AppColor.themeGreen,
          ),
          SizedBox(width: 2.w),
          Text(
            'Completed',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    ],
  );
}
