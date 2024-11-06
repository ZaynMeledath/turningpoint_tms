// ignore_for_file: use_build_context_synchronously

part of '../assign_task_screen.dart';

Widget dateAndTimeSegment({
  required AssignTaskController assignTaskController,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    child: Column(
      children: [
        Obx(
          () => Row(
            mainAxisAlignment:
                assignTaskController.shouldRepeatTask.value == true
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
            children: [
              buildDueOrStartDateSection(
                  assignTaskController: assignTaskController),
              assignTaskController.shouldRepeatTask.value == true
                  ? buildEndDateSection(
                      assignTaskController: assignTaskController)
                  : const SizedBox()
            ],
          ),
        ),
        Obx(() {
          if (assignTaskController.showDueOrStartDateErrorTextObs.value) {
            return Column(
              children: [
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    !assignTaskController.shouldRepeatTask.value
                        ? 'Select a valid due date'
                        : 'Select a valid start date',
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: Colors.redAccent.shade100,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
        Obx(() {
          if (assignTaskController.showEndDateErrorTextObs.value) {
            return Column(
              children: [
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Select a valid end date',
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      color: Colors.redAccent.shade100,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        }),
      ],
    ),
  );
}

Widget buildDueOrStartDateSection({
  required AssignTaskController assignTaskController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Obx(
          () => Text(
            assignTaskController.shouldRepeatTask.value
                ? 'Start Date'
                : 'Due Date',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      SizedBox(height: 6.h),
      InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          assignTaskController.showDueOrStartDateErrorTextObs.value = false;

          //To prevent the keyboard popping glitch
          final currentFocus = FocusScope.of(Get.context!);
          if (currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }

          assignTaskController.isTitleAndDescriptionEnabled.value = false;
          final date = await showDatePicker(
            context: Get.context!,
            firstDate: DateTime.now(),
            lastDate: DateTime(2030),
          );
          if (date != null) {
            assignTaskController.taskDueOrStartDate.value = date;
            assignTaskController.taskDueOrStartTime.value =
                await showTimePicker(
                      context: Get.context!,
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
              Obx(
                () => Container(
                  width: 61.w,
                  height: 61.w,
                  decoration: BoxDecoration(
                    color: AppColors.textFieldColor,
                    shape: BoxShape.circle,
                    border: assignTaskController
                            .showDueOrStartDateErrorTextObs.value
                        ? Border.all(
                            color: Colors.redAccent,
                          )
                        : null,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.calendar_month,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${assignTaskController.taskDueOrStartDate.value.day} ${DateFormat.MMMM().format(assignTaskController.taskDueOrStartDate.value)}',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      assignTaskController.taskDueOrStartTime.value
                          .format(Get.context!),
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget buildEndDateSection({
  required AssignTaskController assignTaskController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Text(
          'End Date',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SizedBox(height: 6.h),
      InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          assignTaskController.showEndDateErrorTextObs.value = false;

          //To prevent the keyboard popping glitch
          final currentFocus = FocusScope.of(Get.context!);
          if (currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }

          assignTaskController.isTitleAndDescriptionEnabled.value = false;
          final date = await showDatePicker(
            context: Get.context!,
            currentDate: assignTaskController.taskEndDate.value,
            firstDate: DateTime.now(),
            lastDate: DateTime(2030),
          );
          if (date != null) {
            assignTaskController.taskEndDate.value = date;
            assignTaskController.taskEndTime.value = await showTimePicker(
                  context: Get.context!,
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
              Obx(
                () => Container(
                  width: 61.w,
                  height: 61.w,
                  decoration: BoxDecoration(
                    color: AppColors.textFieldColor,
                    shape: BoxShape.circle,
                    border: assignTaskController.showEndDateErrorTextObs.value
                        ? Border.all(
                            color: Colors.redAccent,
                          )
                        : null,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.calendar_month_rounded,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignTaskController.taskEndDate.value != null
                          ? '${assignTaskController.taskEndDate.value!.day} ${DateFormat.MMMM().format(assignTaskController.taskEndDate.value!)}'
                          : '-      ',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      assignTaskController.taskEndTime.value != null
                          ? assignTaskController.taskEndTime.value!
                              .format(Get.context!)
                          : '-      ',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
