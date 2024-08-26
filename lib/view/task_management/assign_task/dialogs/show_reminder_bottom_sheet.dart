part of '../assign_task_screen.dart';

Future<Object?> showReminderBottomSheet({
  required TextEditingController textController,
  required AssignTaskController assignTaskController,
}) async {
  return Get.bottomSheet(
    bottomSheet(
      textController: textController,
      assignTaskController: assignTaskController,
    ),
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
    child: Container(
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
                  assignTaskController.reminderList.add(
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
          const Expanded(
            child: SizedBox(),
          ),
//====================Add Reminders Button====================//
          InkWell(
            borderRadius: BorderRadius.circular(100),
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
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Add Reminders',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget reminderTextField({
  required TextEditingController textController,
}) {
  return SizedBox(
    width: 70,
    child: TextField(
      controller: textController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
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
    padding: const EdgeInsets.only(
      left: 14,
      right: 10,
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
