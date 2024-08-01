import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/dialogs/segments/assigned_filter_segment.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/dialogs/segments/category_filter_segment.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/dialogs/segments/filter_item.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/dialogs/segments/frequency_filter_segment.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/dialogs/segments/priority_filter_segment.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/dialogs/segments/selected_filter.dart';

Future<Object?> showFilterBottomSheet({
  required TextEditingController categorySearchController,
  required TextEditingController assignedSearchController,
  required FilterController filterController,
  bool? isAllTasks,
  bool? isDelegated,
}) async {
  filterController.selectFilterOption(key: 'category');
  return Get.bottomSheet(
    Obx(
      () => Container(
        // height: 480.h,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(29, 36, 41, 1),
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
                    filterList: filterController.selectedAssignedByList,
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
                            key: 'category',
                          ),
                          child: filterItem(
                            title: 'Category',
                            isActive: filterController
                                .filterOptionSelectedMap['category']!,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        InkWell(
                          onTap: () => filterController.selectFilterOption(
                            key: 'assignedBy',
                          ),
                          child: filterItem(
                            title: 'Assigned By',
                            isActive: filterController
                                .filterOptionSelectedMap['assignedBy']!,
                          ),
                        ),
                        isAllTasks == true || isDelegated == true
                            ? InkWell(
                                onTap: () =>
                                    filterController.selectFilterOption(
                                  key: 'assignedTo',
                                ),
                                child: filterItem(
                                  title: 'Assigned To',
                                  isActive: filterController
                                      .filterOptionSelectedMap['assignedTo']!,
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(height: 6.h),
                        InkWell(
                          onTap: () => filterController.selectFilterOption(
                            key: 'frequency',
                          ),
                          child: filterItem(
                            title: 'Frequency',
                            isActive: filterController
                                .filterOptionSelectedMap['frequency']!,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        InkWell(
                          onTap: () => filterController.selectFilterOption(
                            key: 'priority',
                          ),
                          child: filterItem(
                            title: 'Priority',
                            isActive: filterController
                                .filterOptionSelectedMap['priority']!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //--------------------Filter Value Part--------------------//
                  Expanded(
                    child: Column(
                      children: [
                        filterController.selectedFilterOptionKey == 'category'
                            ? categoryFilterSegment(
                                categorySearchController:
                                    categorySearchController,
                                filterController: filterController,
                              )
                            : filterController.selectedFilterOptionKey ==
                                    'assignedBy'
                                ? assignedFilterSegment(
                                    assignedSearchController:
                                        assignedSearchController,
                                    filterController: filterController,
                                    isAssignedBy: true,
                                  )
                                : filterController.selectedFilterOptionKey ==
                                        'assignedTo'
                                    ? assignedFilterSegment(
                                        assignedSearchController:
                                            assignedSearchController,
                                        filterController: filterController,
                                        isAssignedBy: false,
                                      )
                                    : filterController
                                                .selectedFilterOptionKey ==
                                            'frequency'
                                        ? frequencyFilterSegment(
                                            filterController: filterController,
                                          )
                                        : priorityFilterSegment(
                                            filterController: filterController,
                                          ),
                        Container(
                          height: 50.h,
                          color: Colors.black26,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //--------------------Reset Filter Button--------------------//
                                InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    filterController.resetFilters();
                                  },
                                  child: Container(
                                    width: 100.w,
                                    height: 38.h,
                                    margin: EdgeInsets.only(
                                      right: 14.w,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.withOpacity(.2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Reset',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                //--------------------Filter Button--------------------//
                                Container(
                                  width: 100.w,
                                  height: 38.h,
                                  margin: EdgeInsets.only(
                                    right: 14.w,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColor.themeGreen,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Filter',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
