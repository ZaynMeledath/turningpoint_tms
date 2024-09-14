part of '../assign_task_screen.dart';

Future<Object?> showCategoryDialog({
  required FilterController filterController,
  required AssignTaskController assignTaskController,
  required TasksController tasksController,
  required TextEditingController categoryNameController,
}) async {
  return Get.dialog(
    useSafeArea: true,
    barrierColor: Colors.transparent,
    categoryDialog(
      filterController: filterController,
      assignTaskController: assignTaskController,
      tasksController: tasksController,
      categoryNameController: categoryNameController,
    ),
    transitionCurve: Curves.easeInOut,
  );
}

Widget categoryDialog({
  required FilterController filterController,
  required AssignTaskController assignTaskController,
  required TasksController tasksController,
  required TextEditingController categoryNameController,
}) {
  return Container(
    margin: EdgeInsets.only(
      left: 180.w,
      right: 14.w,
      top: 398.h,
      bottom: 75.h,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: AppColors.textFieldColor,
    ),
    child: Material(
      borderRadius: BorderRadius.circular(16),
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(height: 4.h),
          Obx(
            () {
              final categoriesList = tasksController.categoriesList;
              return Expanded(
                child: ListView.builder(
                  itemCount: categoriesList.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  itemBuilder: (context, index) {
                    final category = categoriesList[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.h,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          assignTaskController.selectedCategory.value =
                              category;
                          Get.back();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.blueGrey.withOpacity(.4),
                            ),
                          ),
                          child: Row(
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: 18.sp,
                                ),
                                child: const Text(
                                  '⦿',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              SizedBox(
                                width: 150.w,
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                  ),
                                  child: Text(
                                    category,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                                    .animate(
                                      key: GlobalKey(),
                                    )
                                    .slideX(
                                      begin: -.06,
                                      delay: Duration(
                                          milliseconds: 30 * (index + 1)),
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.elasticOut,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => showAddCategoryBottomSheet(
                categoryNameController: categoryNameController,
                tasksController: tasksController,
              ),
              child: Container(
                width: 120.w,
                height: 38.h,
                decoration: BoxDecoration(
                  color: AppColors.themeGreen.withOpacity(.65),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    width: 1.5.w,
                    color: AppColors.themeGreen,
                  ),
                ),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                    child: const Text(
                      'Add Category',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
