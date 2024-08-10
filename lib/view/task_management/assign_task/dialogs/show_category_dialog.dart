part of '../assign_task_screen.dart';

Future<Object?> showCategoryDialog() async {
  return Get.dialog(
    useSafeArea: true,
    barrierColor: Colors.transparent,
    categoryDialog(),
    transitionCurve: Curves.easeInOut,
  );
}

Widget categoryDialog() {
  final filterController = FilterController();

  return Container(
      margin: EdgeInsets.only(
        left: 14.w,
        right: 14.w,
        top: 400.h,
        bottom: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.textFieldColor,
      ),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
              itemBuilder: (context, index) {
                final category = categoriesList[index];
                return GestureDetector(
                  onTap: () => filterController.selectOrUnselectCategoryFilter(
                      filterKey: category),
                  child: Row(
                    children: [
                      Obx(
                        () => Material(
                          color: Colors.transparent,
                          child: Checkbox.adaptive(
                            value:
                                filterController.categoryFilterModel[category],
                            visualDensity: VisualDensity.compact,
                            fillColor: WidgetStatePropertyAll(
                              filterController.categoryFilterModel[category] ==
                                      true
                                  ? AppColor.themeGreen
                                  : Colors.transparent,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            onChanged: (value) =>
                                filterController.selectOrUnselectCategoryFilter(
                                    filterKey: category),
                          ),
                        ),
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                        child: Text(
                          category,
                        ),
                      ),
                    ],
                  )
                      .animate(
                        key: GlobalKey(),
                      )
                      .slideX(
                        begin: -.06,
                        delay: Duration(milliseconds: 30 * (index + 1)),
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.elasticOut,
                      ),
                );
              },
            ),
          ),
        ],
      ));
}
