part of '../assign_task_screen.dart';

Future<Object?> showCategoryDialog({
  required FilterController filterController,
  required TasksController tasksController,
}) async {
  return Get.dialog(
    useSafeArea: true,
    barrierColor: Colors.transparent,
    categoryDialog(
      filterController: filterController,
      tasksController: tasksController,
    ),
    transitionCurve: Curves.easeInOut,
  );
}

Widget categoryDialog({
  required FilterController filterController,
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
        color: AppColor.textFieldColor,
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
                          tasksController.selectedCategory.value = category;
                          Get.back();
                        },
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
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white70,
                                  ),
                                ),
                                child: Center(
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
                              ),
                            ),
                          ],
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
