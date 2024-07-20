part of '../my_tasks_screen.dart';

Future<Object?> showFilterBottomSheet({
  required TextEditingController categorySearchController,
  required TextEditingController assignedSearchController,
  required TasksController tasksController,
  required FilterController filterController,
}) async {
  tasksController.selectFilterOption(key: 'category');
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
            filterController.selectedUsersList.isNotEmpty
                ? selectedFilter(
                    title: 'Assigned',
                    filterList: filterController.selectedUsersList,
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
                          onTap: () => tasksController.selectFilterOption(
                            key: 'category',
                          ),
                          child: filterItem(
                            title: 'Category',
                            isActive: tasksController
                                .filterOptionSelectedMap['category']!,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        InkWell(
                          onTap: () => tasksController.selectFilterOption(
                            key: 'assigned',
                          ),
                          child: filterItem(
                            title: 'Assigned By',
                            isActive: tasksController
                                .filterOptionSelectedMap['assigned']!,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        InkWell(
                          onTap: () => tasksController.selectFilterOption(
                            key: 'frequency',
                          ),
                          child: filterItem(
                            title: 'Frequency',
                            isActive: tasksController
                                .filterOptionSelectedMap['frequency']!,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        InkWell(
                          onTap: () => tasksController.selectFilterOption(
                            key: 'priority',
                          ),
                          child: filterItem(
                            title: 'Priority',
                            isActive: tasksController
                                .filterOptionSelectedMap['priority']!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //--------------------Filter Value Part--------------------//
                  tasksController.selectedFilterOptionKey == 'category'
                      ? categoryFilterSegment(
                          categorySearchController: categorySearchController,
                          filterController: filterController,
                        )
                      : tasksController.selectedFilterOptionKey == 'assigned'
                          ? assignedFilterSegment(
                              assignedSearchController:
                                  assignedSearchController,
                              filterController: filterController,
                            )
                          : tasksController.selectedFilterOptionKey ==
                                  'frequency'
                              ? frequencyFilterSegment(
                                  filterController: filterController,
                                )
                              : priorityFilterSegment(
                                  filterController: filterController,
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
