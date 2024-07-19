part of '../my_tasks_screen.dart';

Widget filterSection({
  required TextEditingController taskSearchController,
  required TextEditingController categorySearchController,
  required TextEditingController assignedSearchController,
  required UserController userController,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        const SizedBox(height: 6),
        Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                await showFilterBottomSheet(
                  categorySearchController: categorySearchController,
                  assignedSearchController: assignedSearchController,
                );
              },
              child: Container(
                width: 45.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.filter_list,
                  color: AppColor.themeGreen,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: customTextField(
                controller: taskSearchController,
                hintText: 'Search Task',
                userController: userController,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 110.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.withOpacity(.15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Range',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            Container(
              width: 110.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.withOpacity(.15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 16.sp,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}