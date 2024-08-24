// ignore_for_file: use_build_context_synchronously

part of '../assign_task_screen.dart';

Widget dateAndTimeSegment({
  required BuildContext context,
  required AssignTaskController assignTaskController,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
//====================Date Picker Section====================//
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            //To prevent the keyboard popping glitch
            final currentFocus = FocusScope.of(context);
            if (currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            assignTaskController.isTitleAndDescriptionEnabled.value = false;
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
            );
            if (date != null) {
              assignTaskController.taskDate.value = date;
              assignTaskController.taskTime.value = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ) ??
                  TimeOfDay.now();
            }
            Future.delayed(Duration.zero, () {
              assignTaskController.isTitleAndDescriptionEnabled.value = true;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Row(
              children: [
                Container(
                  width: 61.w,
                  height: 61.w,
                  decoration: const BoxDecoration(
                    color: AppColors.textFieldColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.calendar_month_rounded,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Obx(
                  () => Text(
                    '${assignTaskController.taskDate.value.day} ${DateFormat.MMMM().format(assignTaskController.taskDate.value)}',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Expanded(
          child: SizedBox(),
        ),

//====================Time Picker Section====================//
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () async {
            //To prevent the keyboard popping glitch
            final currentFocus = FocusScope.of(context);
            if (currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }

            assignTaskController.isTitleAndDescriptionEnabled.value = false;
            assignTaskController.taskTime.value = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ) ??
                TimeOfDay.now();
            Future.delayed(Duration.zero, () {
              assignTaskController.isTitleAndDescriptionEnabled.value = true;
            });
          },
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Row(
              children: [
                Container(
                  width: 61.w,
                  height: 61.w,
                  decoration: const BoxDecoration(
                    color: AppColors.textFieldColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.access_time,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Obx(
                  () => Text(
                    assignTaskController.taskTime.value.format(context),
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
