part of '../assign_task_screen.dart';

Future<Object?> showReminderBottomSheet() async {
  return Get.bottomSheet(
    bottomSheet(),
    isDismissible: false,
  );
}

Widget bottomSheet() {
  return Container(
    width: double.maxFinite,
    height: 220.h,
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    decoration: const BoxDecoration(
      color: AppColors.scaffoldBackgroundColor,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    child: Column(
      children: [
        SizedBox(height: 10.h),
        Row(
          children: [
            Icon(
              Icons.alarm,
              color: Colors.white54,
              size: 22.w,
            ),
            const SizedBox(width: 2),
            Text(
              'Add Task Reminders',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.blueGrey[400],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            reminderDropdown(),
          ],
        ),
      ],
    ),
  );
}

Widget reminderTextField() {
  return Container();
}

Widget reminderDropdown() {
  return Container(
    padding: const EdgeInsets.only(
      left: 8,
      right: 4,
    ),
    decoration: BoxDecoration(
      color: AppColors.textFieldColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: DropdownButton(
        underline: Container(),
        value: 'minutes',
        items: const [
          DropdownMenuItem(
            value: 'minutes',
            child: Text('Minutes'),
          ),
          DropdownMenuItem(
            value: 'hours',
            child: Text('Hours'),
          ),
          DropdownMenuItem(
            value: 'days',
            child: Text('Days'),
          ),
        ],
        onChanged: (value) {},
      ),
    ),
  );
}
