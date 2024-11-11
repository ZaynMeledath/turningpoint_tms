import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';

Widget tasksTabBar({
  required TabController tabController,
  required int? allTasksCount,
  int? unapprovedCount,
  required int? overdueTasksCount,
  required int? openTasksCount,
  required int? inProgressTasksCount,
  required int? completedTasksCount,
  required int? recurringTasksCount,
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
    padding: EdgeInsets.only(bottom: 4.h),
    splashBorderRadius: BorderRadius.circular(16),
    indicatorPadding: EdgeInsets.only(bottom: 2.h),
    // dividerColor: AppColor.themeGreen.withOpacity(.2),
    indicatorColor: AppColors.themeGreen,
    labelColor: AppColors.themeGreen,
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateColor.transparent,
    tabs: [
      if (unapprovedCount != null)
        Row(
          children: [
            Icon(
              Icons.task_alt,
              size: 21.sp,
            ),
            SizedBox(width: 2.w),
            Text(
              'Unapproved - $unapprovedCount',
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      Row(
        children: [
          Icon(
            Icons.task_alt,
            size: 21.sp,
          ),
          SizedBox(width: 2.w),
          Text(
            'All - ${allTasksCount ?? 0}',
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
            color: StatusColor.overdue,
          ),
          SizedBox(width: 2.w),
          Text(
            '${Status.overdue} - ${overdueTasksCount ?? 0}',
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
            color: StatusColor.open,
          ),
          SizedBox(width: 2.w),
          Text(
            '${Status.open} - ${openTasksCount ?? 0}',
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
            color: StatusColor.inProgress,
          ),
          SizedBox(width: 2.w),
          Text(
            '${Status.inProgress} - ${inProgressTasksCount ?? 0}',
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
            color: StatusColor.completed,
          ),
          SizedBox(width: 2.w),
          Text(
            '${Status.completed} - ${completedTasksCount ?? 0}',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Icon(
            Icons.repeat,
            size: 20.sp,
            color: StatusColor.completed,
          ),
          SizedBox(width: 2.w),
          Text(
            'Recurring - ${recurringTasksCount ?? 0}',
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
