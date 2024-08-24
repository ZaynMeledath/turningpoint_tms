part of '../assign_task_screen.dart';

Future<Object?> showCategoryDialog({
  required FilterController filterController,
  required AssignTaskController assignTaskController,
  required TasksController tasksController,
}) async {
  return Get.dialog(
    useSafeArea: true,
    barrierColor: Colors.transparent,
    categoryDialog(
      filterController: filterController,
      assignTaskController: assignTaskController,
      tasksController: tasksController,
    ),
    transitionCurve: Curves.easeInOut,
  );
}

Widget categoryDialog({
  required FilterController filterController,
  required AssignTaskController assignTaskController,
  required TasksController tasksController,
}) {
  return Container(
      margin: EdgeInsets.only(
        left: 180.w,
        right: 14.w,
        top: 398.h,
        bottom: 78.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.textFieldColor,
      ),
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
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(72, 73, 73, 0.4),
                                Color.fromRGBO(40, 45, 49, 0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
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
                              DefaultTextStyle(
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
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.elasticOut,
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
        ],
      ));
}
