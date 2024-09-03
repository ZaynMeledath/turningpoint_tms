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
    isDismissible: false,
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
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //====================TextField and Dropdown====================//
                      reminderTextField(textController: textController),
                      SizedBox(width: 8.w),
                      reminderDropdown(
                        assignTaskController: assignTaskController,
                      ),
                      SizedBox(width: 20.w),
                      //====================Plus Button====================//
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          reminderList.add(
                            Reminder(
                              time: int.parse(textController.text),
                              unit: assignTaskController.reminderUnit.value,
                            ),
                          );
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.themeGreen,
                          ),
                          child: Icon(
                            Icons.add,
                            size: 24.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: reminderList.isNotEmpty ? 10.h : 30.h),
                  for (int i = 0; i < reminderList.length; i++)
                    addedReminderSegment(),

                  SizedBox(height: 10.h),
                  //====================Add Reminders Button====================//
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      margin: EdgeInsets.only(
                        bottom: 18.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.themeGreen,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Save Reminders',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
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

Widget addedReminderSegment() {
  return Padding(
    padding: EdgeInsets.only(bottom: 4.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.textFieldColor,
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 100.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.textFieldColor,
          ),
        ),
        IconButton(
          onPressed: () {},
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
