part of '../assign_task_screen.dart';

Future<Object?> showReminderBottomSheet({
  required TextEditingController textController,
  required AssignTaskController assignTaskController,
}) async {
  return Get.bottomSheet(
    isScrollControlled: true,
    StatefulBuilder(builder: (context, setState) {
      return bottomSheet(
        textController: textController,
        assignTaskController: assignTaskController,
      );
    }),
  );
}

Widget bottomSheet({
  required TextEditingController textController,
  required AssignTaskController assignTaskController,
}) {
  textController.text = assignTaskController.reminderTime.toString();

  return Material(
    color: Colors.transparent,
    borderRadius: const BorderRadius.vertical(
      top: Radius.circular(12),
    ),
    child: Obx(
      () {
        List<Reminder> reminderList = assignTaskController.reminderList;
        return Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: const BoxDecoration(
            color: AppColors.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          child: Wrap(
            children: [
              Column(
                children: [
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        color: Colors.white54,
                        size: 20.w,
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
                  SizedBox(height: reminderList.isEmpty ? 25.h : 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //====================TextField and Dropdown====================//
                      reminderTextField(textController: textController),
                      SizedBox(width: 10.w),
                      reminderDropdown(
                        assignTaskController: assignTaskController,
                      ),
                      SizedBox(width: 20.w),
                      //====================Plus Button====================//
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          final reminder = Reminder(
                            time: int.parse(textController.text),
                            unit: assignTaskController.reminderUnit.value,
                          );
                          if (!reminderList.contains(reminder)) {
                            reminderList.add(reminder);
                          }
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green.shade900,
                            border: Border.all(
                              color: AppColors.themeGreen,
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 24.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  reminderList.isNotEmpty
                      ? Container(
                          width: double.maxFinite,
                          height: 1,
                          color: Colors.white12,
                        )
                      : SizedBox(height: 10.h),
                  SizedBox(height: 10.h),
                  for (int i = 0; i < reminderList.length; i++)
                    addedReminderSegment(
                      assignTaskController: assignTaskController,
                      reminderIndex: i,
                    ),
                  SizedBox(height: 10.h),
                ],
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget reminderTextField({
  required TextEditingController textController,
}) {
  return SizedBox(
    width: 70.w,
    child: TextField(
      controller: textController,
      textAlign: TextAlign.center,
      maxLength: 2,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        counterText: '',
        fillColor: AppColors.textFieldColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          // vertical: 2.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.themeGreen,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    ),
  );
}

Widget reminderDropdown({
  required AssignTaskController assignTaskController,
}) {
  return Container(
    padding: EdgeInsets.only(
      left: 14.w,
      right: 10.w,
    ),
    decoration: BoxDecoration(
      color: AppColors.textFieldColor,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Obx(
      () => Center(
        child: DropdownButton(
          underline: const SizedBox(),
          dropdownColor: AppColors.textFieldColor,
          borderRadius: BorderRadius.circular(16),
          value: assignTaskController.reminderUnit.value,
          items: const [
            DropdownMenuItem(
              value: 'Minutes',
              child: Text('Minutes'),
            ),
            DropdownMenuItem(
              value: 'Hours',
              child: Text('Hours'),
            ),
            DropdownMenuItem(
              value: 'Days',
              child: Text('Days'),
            ),
          ],
          onChanged: (value) {
            assignTaskController.reminderUnit.value = value as String;
          },
        ),
      ),
    ),
  );
}

Widget addedReminderSegment({
  required AssignTaskController assignTaskController,
  required int reminderIndex,
}) {
  final reminder = assignTaskController.reminderList[reminderIndex];
  return Padding(
    padding: EdgeInsets.only(bottom: 4.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70.w,
          height: 45.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.textFieldColor,
          ),
          child: Center(
            child: Text(
              reminder.time.toString(),
              style: TextStyle(
                fontSize: 16.sp,
                height: 1,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 110.w,
          height: 45.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.textFieldColor,
          ),
          child: Center(
            child: Text(
              reminder.unit.toString(),
              style: TextStyle(
                fontSize: 16.sp,
                height: 1,
              ),
            ),
          ),
        ),
        SizedBox(width: 5.w),
        IconButton(
          onPressed: () {
            assignTaskController.reminderList.removeAt(reminderIndex);
          },
          icon: Icon(
            Icons.close_rounded,
            size: 26.w,
            color: Colors.red.withOpacity(.9),
          ),
        )
      ],
    ),
  );
}
