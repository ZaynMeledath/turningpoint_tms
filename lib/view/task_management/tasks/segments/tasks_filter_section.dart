import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/show_filter_bottom_sheet.dart';

Widget tasksFilterSection({
  required TextEditingController taskSearchController,
  required TextEditingController categorySearchController,
  required TextEditingController? assignedToSearchController,
  required TextEditingController? assignedBySearchController,
  required UserController userController,
  required FilterController filterController,
  required TasksController tasksController,
  required void Function(String) textFieldOnChanged,
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
                            assignedToSearchController:
                                assignedToSearchController,
                            assignedBySearchController:
                                assignedBySearchController,
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
                                        .selectedPriorityList.isNotEmpty ||
                                    filterController.selectedStartDate.value !=
                                        null ||
                                    filterController.selectedEndDate.value !=
                                        null
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
                    textFieldOnChanged(value);
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
