import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/dialogs/show_filter_bottom_sheet.dart';

Widget tasksFilterSection({
  required TextEditingController taskSearchController,
  required TextEditingController categorySearchController,
  required TextEditingController assignedSearchController,
  required UserController userController,
  required FilterController filterController,
  required TasksController tasksController,
  bool? avoidFilterButton,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        const SizedBox(height: 6),
        Row(
          children: [
            avoidFilterButton == true
                ? const SizedBox()
                : Row(
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () async {
                          await showFilterBottomSheet(
                            categorySearchController: categorySearchController,
                            assignedSearchController: assignedSearchController,
                            filterController: filterController,
                            tasksController: tasksController,
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
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
                            filterController.selectedCategoryList.isNotEmpty ||
                                    filterController
                                        .selectedAssignedByList.isNotEmpty ||
                                    filterController
                                        .selectedAssignedToList.isNotEmpty ||
                                    filterController
                                        .selectedFrequencyList.isNotEmpty ||
                                    filterController
                                        .selectedPriorityList.isNotEmpty
                                ? Positioned(
                                    right: 2.w,
                                    top: 2.w,
                                    child: Container(
                                      width: 11.w,
                                      height: 11.w,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.themeGreen,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
            Flexible(
              child: customTextField(
                  controller: taskSearchController,
                  hintText: 'Search Task',
                  onChanged: (value) {
                    //FilterTasks() also helps to reset the tasksList to ensure seamless search result
                    filterController.filterTasks();

                    if (tasksController.isDelegatedObs.value == true) {
                      if (tasksController.delegatedTasksListObs.value != null) {
                        tasksController.delegatedTasksListObs.value =
                            tasksController.delegatedTasksListObs.value!
                                .where((taskModel) =>
                                    taskModel.title!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    taskModel.description!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                .toList();
                        tasksController.getDelegatedTasks(filter: true);
                      }
                    } else if (tasksController.isDelegatedObs.value == false) {
                      if (tasksController.myTasksListObs.value != null) {
                        tasksController.myTasksListObs.value = tasksController
                            .myTasksListObs.value!
                            .where((taskModel) =>
                                taskModel.title!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                taskModel.description!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                            .toList();
                        tasksController.getMyTasks(filter: true);
                      }
                    } else {
                      tasksController.dashboardTasksListObs.value =
                          tasksController.dashboardTasksListObs
                              .where((taskModel) =>
                                  taskModel.title!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  taskModel.description!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                              .toList();
                    }
                  }),
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
