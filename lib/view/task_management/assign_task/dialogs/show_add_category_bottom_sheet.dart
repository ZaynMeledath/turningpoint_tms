part of '../assign_task_screen.dart';

Future<Object?> showAddCategoryBottomSheet({
  required TextEditingController categoryNameController,
  required TasksController tasksController,
}) async {
  return Get.bottomSheet(
    isScrollControlled: true,
    addCategoryBottomSheet(
      categoryNameController: categoryNameController,
      tasksController: tasksController,
    ),
  );
}

Widget addCategoryBottomSheet({
  required TextEditingController categoryNameController,
  required TasksController tasksController,
}) {
  return Container(
    width: double.maxFinite,
    decoration: const BoxDecoration(
      color: AppColors.scaffoldBackgroundColor,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 14.h,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Add Category',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 1,
            color: Colors.white12,
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
            ),
            child: customTextField(
              controller: categoryNameController,
              hintText: 'Category Name',
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                try {
                  await tasksController.addCategory(
                    categoryName: categoryNameController.text.trim(),
                  );
                  Get.back();
                  showGenericDialog(
                    iconPath: 'assets/lotties/success_animation.json',
                    title: 'Category Added',
                    content: 'New category has been added successfully',
                    buttons: {'OK': null},
                  );
                } catch (_) {
                  showGenericDialog(
                    iconPath: 'assets/lotties/server_error_animation.json',
                    title: 'Something Went Wrong',
                    content: 'Something went wrong while adding category',
                    buttons: {'Dismiss': null},
                  );
                }
              },
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
