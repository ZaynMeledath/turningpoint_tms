part of '../../my_tasks_screen.dart';

Widget categoryFilterSegment({
  required TextEditingController categorySearchController,
  required FilterController filterController,
}) {
  return Expanded(
    child: Column(
      children: [
        SizedBox(height: 8.h),
        Flexible(
          child: Transform.scale(
              scale: .94,
              child: customTextField(
                controller: categorySearchController,
                hintText: 'Search Category',
              )),
        )
            .animate(
              key: GlobalKey(),
            )
            .slideX(
              begin: -.06,
              duration: const Duration(milliseconds: 700),
              curve: Curves.elasticOut,
            ),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            itemBuilder: (context, index) {
              final category = categoriesList[index];
              return InkWell(
                onTap: () => filterController.selectOrUnselectCategoryFilter(
                    filterKey: category),
                child: Row(
                  children: [
                    Obx(
                      () => Checkbox.adaptive(
                        value: filterController.categoryFilterModel[category],
                        visualDensity: VisualDensity.compact,
                        fillColor: WidgetStatePropertyAll(
                            filterController.categoryFilterModel[category] ==
                                    true
                                ? AppColor.themeGreen
                                : Colors.transparent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        onChanged: (value) =>
                            filterController.selectOrUnselectCategoryFilter(
                                filterKey: category),
                      ),
                    ),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 15.sp,
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
    ),
  );
}
