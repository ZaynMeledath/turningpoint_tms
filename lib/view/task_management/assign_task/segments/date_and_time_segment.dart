// ignore_for_file: use_build_context_synchronously

part of '../assign_task_screen.dart';

Widget dateAndTimeSegment({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: screenWidth * .015),
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

            tasksController.isTitleAndDescriptionEnabled.value = false;
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
            );
            if (date != null) {
              tasksController.taskDate.value = date;
              tasksController.taskTime.value = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ) ??
                  TimeOfDay.now();
            }
            Future.delayed(Duration.zero, () {
              tasksController.isTitleAndDescriptionEnabled.value = true;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  width: screenWidth * .15,
                  height: screenWidth * .15,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.calendar_month_rounded,
                    ),
                  ),
                ),
                Gap(screenWidth * .02),
                Obx(
                  () => Text(
                    '${tasksController.taskDate.value.day} ${DateFormat.MMMM().format(tasksController.taskDate.value)}',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: screenWidth * .036,
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

            tasksController.isTitleAndDescriptionEnabled.value = false;
            tasksController.taskTime.value = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                ) ??
                TimeOfDay.now();
            Future.delayed(Duration.zero, () {
              tasksController.isTitleAndDescriptionEnabled.value = true;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  width: screenWidth * .15,
                  height: screenWidth * .15,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.access_time,
                    ),
                  ),
                ),
                Gap(screenWidth * .02),
                Obx(
                  () => Text(
                    tasksController.taskTime.value.format(context),
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: screenWidth * .036,
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
