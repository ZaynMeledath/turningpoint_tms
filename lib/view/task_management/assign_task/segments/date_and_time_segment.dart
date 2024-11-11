// ignore_for_file: use_build_context_synchronously

part of '../assign_task_screen.dart';

Widget dateAndTimeSegment({
  required AssignTaskController assignTaskController,
  required PageController pageController,
  required TextEditingController occurrenceController,
}) {
  return Obx(
    () => Padding(
      padding: EdgeInsets.only(
        left: 4.w,
        right: 4.w,
        bottom: assignTaskController.shouldRepeatTask.value ? 6.w : 0,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 115.w,
            child: Row(
              // mainAxisAlignment:
              //     assignTaskController.shouldRepeatTask.value == true
              //         ? MainAxisAlignment.spaceBetween
              //         : MainAxisAlignment.start,
              children: [
                buildDueOrStartDateSection(
                    assignTaskController: assignTaskController),
                const Expanded(child: SizedBox()),
                if (assignTaskController.shouldRepeatTask.value == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 175.w,
                          // height: 100.w,
                          child: PageView(
                            controller: pageController,
                            // scrollDirection: Axis.vertical,
                            children: [
                              buildEndDateSection(
                                assignTaskController: assignTaskController,
                                occurrenceController: occurrenceController,
                              ),
                              buildOccurrencesSection(
                                assignTaskController: assignTaskController,
                                occurrenceController: occurrenceController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (assignTaskController.shouldRepeatTask.value == true)
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: SmoothPageIndicator(
                            controller: pageController,
                            effect: WormEffect(
                              activeDotColor: AppColors.themeGreen,
                              dotWidth: 12.w,
                              dotHeight: 12.w,
                            ),
                            count: 2,
                          ),
                        ),
                    ],
                  )
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
    ),
  );
}

Widget buildDueOrStartDateSection({
  required AssignTaskController assignTaskController,
}) {
  return Column(
    children: [
      Column(
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
      ),
    ],
  );
}

Widget buildEndDateSection({
  required AssignTaskController assignTaskController,
  required TextEditingController occurrenceController,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Column(
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
              assignTaskController.taskOccurrencesCount.value = 0;
              occurrenceController.clear();
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
                        border:
                            assignTaskController.showEndDateErrorTextObs.value
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
      ),
    ],
  );
}

Widget buildOccurrencesSection({
  required AssignTaskController assignTaskController,
  required TextEditingController occurrenceController,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              'Occurrences',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 14.w),
          SizedBox(
            width: 130.w,
            child: customTextField(
                controller: occurrenceController,
                hintText: 'Occurrence',
                keyboardType: TextInputType.number,
                ignoreValidations: true,
                onChanged: (value) {
                  assignTaskController.taskEndDate.value = null;
                  assignTaskController.taskEndTime.value = null;
                  assignTaskController.taskOccurrencesCount.value =
                      int.tryParse(value.trim()) ?? 0;
                }),
          ),
        ],
      ),
    ],
  );
}
