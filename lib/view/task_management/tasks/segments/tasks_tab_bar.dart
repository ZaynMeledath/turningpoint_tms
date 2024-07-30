import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';

Widget tasksTabBar({
  required TabController tabController,
}) {
  return TabBar(
    controller: tabController,
    isScrollable: true,
    physics: const BouncingScrollPhysics(),
    labelPadding: EdgeInsets.only(
      bottom: 6.h,
      right: 15.w,
      left: 15.w,
      top: 10.h,
    ),
    splashBorderRadius: BorderRadius.circular(16),
    indicatorPadding: EdgeInsets.only(bottom: 2.h),
    // dividerColor: AppColor.themeGreen.withOpacity(.2),
    indicatorColor: AppColor.themeGreen,
    labelColor: AppColor.themeGreen,
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateColor.transparent,
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
            Status.overdue,
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
            Status.pending,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.incomplete_circle,
            size: 20.sp,
            color: Colors.blue,
          ),
          SizedBox(width: 2.w),
          Text(
            Status.inProgress,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 20.sp,
            color: AppColor.themeGreen,
          ),
          SizedBox(width: 2.w),
          Text(
            Status.completed,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    ],
  ).animate().slideX(
        begin: .4,
        curve: Curves.elasticOut,
        duration: const Duration(milliseconds: 900),
      );
}
