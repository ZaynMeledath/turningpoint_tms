import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/segments/assigned_filter_segment.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/segments/category_filter_segment.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/segments/date_range_filter.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/segments/filter_item.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/segments/frequency_filter_segment.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/segments/priority_filter_segment.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/segments/selected_filter.dart';

part 'segments/filter_reset_segment.dart';

Future<Object?> showFilterBottomSheet({
  required TextEditingController categorySearchController,
  required TextEditingController? assignedBySearchController,
  required TextEditingController? assignedToSearchController,
  required FilterController filterController,
  required TasksController tasksController,
  bool? isAllTasks,
}) async {
  int categoryAnimationFlag = -1;
  int assignedByAnimationFlag = -1;
  int assignedToAnimationFlag = -1;
  int frequencyAnimationFlag = -1;
  int priorityAnimationFlag = -1;
  int dateRangeAnimationFlag = -1;
  filterController.selectFilterOption(filterOption: FilterOptions.category);
  return Get.bottomSheet(
    Obx(
      () {
        //Used to disable the entry animation after the first time
        switch (filterController.selectedFilterOption.value) {
          case FilterOptions.category:
            categoryAnimationFlag++;
            assignedByAnimationFlag = -1;
            assignedToAnimationFlag = -1;
            frequencyAnimationFlag = -1;
            priorityAnimationFlag = -1;
            break;

          case FilterOptions.assignedBy:
            assignedByAnimationFlag++;
            categoryAnimationFlag = -1;
            assignedToAnimationFlag = -1;
            frequencyAnimationFlag = -1;
            priorityAnimationFlag = -1;
            break;

          case FilterOptions.assignedTo:
            assignedToAnimationFlag++;
            categoryAnimationFlag = -1;
            assignedByAnimationFlag = -1;
            frequencyAnimationFlag = -1;
            priorityAnimationFlag = -1;
            break;

          case FilterOptions.frequency:
            frequencyAnimationFlag++;
            categoryAnimationFlag = -1;
            assignedByAnimationFlag = -1;
            assignedToAnimationFlag = -1;
            priorityAnimationFlag = -1;
            break;

          case FilterOptions.priority:
            priorityAnimationFlag++;
            categoryAnimationFlag = -1;
            assignedByAnimationFlag = -1;
            assignedToAnimationFlag = -1;
            frequencyAnimationFlag = -1;
            break;

          case FilterOptions.dateRange:
            dateRangeAnimationFlag++;
            priorityAnimationFlag = -1;
            categoryAnimationFlag = -1;
            assignedByAnimationFlag = -1;
            assignedToAnimationFlag = -1;
            frequencyAnimationFlag = -1;
            break;
        }
        return Container(
          // height: 480.h,
          decoration: const BoxDecoration(
            color: AppColors.bottomSheetColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  child: Text(
                    'Filter Task',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              //--------------------Selected Filters are displayed here--------------------//
              filterController.selectedCategoryList.isNotEmpty
                  ? selectedFilter(
                      title: 'Category',
                      filterList: filterController.selectedCategoryList,
                    )
                  : const SizedBox(),
              filterController.selectedAssignedByList.isNotEmpty
                  ? selectedFilter(
                      title: 'Assigned By',
                      filterList: filterController.selectedAssignedByList,
                    )
                  : const SizedBox(),
              filterController.selectedAssignedToList.isNotEmpty
                  ? selectedFilter(
                      title: 'Assigned To',
                      filterList: filterController.selectedAssignedToList,
                    )
                  : const SizedBox(),
              filterController.selectedFrequencyList.isNotEmpty
                  ? selectedFilter(
                      title: 'Frequency',
                      filterList: filterController.selectedFrequencyList,
                    )
                  : const SizedBox(),
              filterController.selectedPriorityList.isNotEmpty
                  ? selectedFilter(
                      title: 'Priority',
                      filterList: filterController.selectedPriorityList,
                    )
                  : const SizedBox(),
              Container(
                width: double.maxFinite,
                height: 1,
                color: Colors.grey.withOpacity(.1),
              ),
              Expanded(
                child: Row(
                  children: [
                    //--------------------Filter Key Part--------------------//
                    Container(
                      width: 140.w,
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.15),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => filterController.selectFilterOption(
                              filterOption: FilterOptions.category,
                            ),
                            child: filterItem(
                              title: 'Category',
                              isActive:
                                  filterController.selectedFilterOption.value ==
                                      FilterOptions.category,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          isAllTasks != true &&
                                  tasksController.isDelegatedObs.value != true
                              ? InkWell(
                                  onTap: () =>
                                      filterController.selectFilterOption(
                                    filterOption: FilterOptions.assignedBy,
                                  ),
                                  child: filterItem(
                                    title: 'Assigned By',
                                    isActive: filterController
                                            .selectedFilterOption.value ==
                                        FilterOptions.assignedBy,
                                  ),
                                )
                              : const SizedBox(),
                          isAllTasks == true ||
                                  tasksController.isDelegatedObs.value ==
                                      true ||
                                  tasksController.isDelegatedObs.value == null
                              ? InkWell(
                                  onTap: () =>
                                      filterController.selectFilterOption(
                                    filterOption: FilterOptions.assignedTo,
                                  ),
                                  child: filterItem(
                                    title: 'Assigned To',
                                    isActive: filterController
                                            .selectedFilterOption.value ==
                                        FilterOptions.assignedTo,
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(height: 6.h),
                          InkWell(
                            onTap: () => filterController.selectFilterOption(
                              filterOption: FilterOptions.frequency,
                            ),
                            child: filterItem(
                              title: 'Frequency',
                              isActive:
                                  filterController.selectedFilterOption.value ==
                                      FilterOptions.frequency,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          InkWell(
                            onTap: () => filterController.selectFilterOption(
                              filterOption: FilterOptions.priority,
                            ),
                            child: filterItem(
                              title: 'Priority',
                              isActive:
                                  filterController.selectedFilterOption.value ==
                                      FilterOptions.priority,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //--------------------Filter Value Part--------------------//
                    Expanded(
                      child: Column(
                        children: [
                          filterController.selectedFilterOption.value ==
                                  FilterOptions.category
                              ? categoryFilterSegment(
                                  categorySearchController:
                                      categorySearchController,
                                  filterController: filterController,
                                  tasksController: tasksController,
                                  animationFlag: categoryAnimationFlag,
                                )
                              : filterController.selectedFilterOption.value ==
                                      FilterOptions.assignedBy
                                  ? assignedFilterSegment(
                                      assignedSearchController:
                                          assignedBySearchController!,
                                      filterController: filterController,
                                      isAssignedBy: true,
                                      animationFlag: assignedByAnimationFlag,
                                    )
                                  : filterController
                                              .selectedFilterOption.value ==
                                          FilterOptions.assignedTo
                                      ? assignedFilterSegment(
                                          assignedSearchController:
                                              assignedToSearchController!,
                                          filterController: filterController,
                                          isAssignedBy: false,
                                          animationFlag:
                                              assignedToAnimationFlag,
                                        )
                                      : filterController
                                                  .selectedFilterOption.value ==
                                              FilterOptions.frequency
                                          ? frequencyFilterSegment(
                                              filterController:
                                                  filterController,
                                              animationFlag:
                                                  frequencyAnimationFlag,
                                            )
                                          : filterController
                                                      .selectedFilterOption
                                                      .value ==
                                                  FilterOptions.priority
                                              ? priorityFilterSegment(
                                                  filterController:
                                                      filterController,
                                                  animationFlag:
                                                      priorityAnimationFlag,
                                                )
                                              : dateRangeFilter(
                                                  filterController:
                                                      filterController,
                                                  animationFlag:
                                                      dateRangeAnimationFlag,
                                                ),
                          filterResetSegment(
                            filterController: filterController,
                            categorySearchController: categorySearchController,
                            assignedBySearchController:
                                assignedBySearchController,
                            assignedToSearchController:
                                assignedToSearchController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
