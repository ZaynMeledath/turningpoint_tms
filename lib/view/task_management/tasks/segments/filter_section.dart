import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/dialogs/show_filter_bottom_sheet.dart';

Widget filterSection({
  required TextEditingController taskSearchController,
  required TextEditingController categorySearchController,
  required TextEditingController assignedSearchController,
  required UserController userController,
  required FilterController filterController,
  required TasksController tasksController,
  bool? isDelegated,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        const SizedBox(height: 6),
        Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                await showFilterBottomSheet(
                  categorySearchController: categorySearchController,
                  assignedSearchController: assignedSearchController,
                  filterController: filterController,
                  tasksController: tasksController,
                  isDelegated: isDelegated,
                );
              },
              child: Container(
                width: 45.w,
                height: 42.w,
                decoration: const BoxDecoration(
                  color: AppColors.textFieldColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.filter_list,
                  color: AppColors.themeGreen,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: customTextField(
                controller: taskSearchController,
                hintText: 'Search Task',
                userController: userController,
              ),
            ),
          ],
        ),
        // SizedBox(height: 8.h),
        // Container(
        //   width: 110.w,
        //   height: 40.h,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(16),
        //     color: AppColor.textFieldColor,
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'Today',
        //         style: TextStyle(
        //           fontSize: 16.sp,
        //         ),
        //       ),
        //       const Icon(Icons.arrow_drop_down)
        //     ],
        //   ),
        // ),
      ],
    ),
  ).animate().scaleX(
        duration: const Duration(milliseconds: 1200),
        curve: Curves.elasticOut,
      );
}
