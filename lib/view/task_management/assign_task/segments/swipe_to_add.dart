part of '../assign_task_screen.dart';

Widget swipeToAdd({
  required TasksController tasksController,
  required String taskTitle,
  required String taskDescription,
}) {
  return Container(
    height: 85.h,
    padding: EdgeInsets.symmetric(
      horizontal: 12.w,
    ),
    child: SlideAction(
      height: 65.h,
      sliderRotate: false,
      borderRadius: 50,
      text: 'Add Task',
      textStyle: TextStyle(
        fontSize: 16.sp,
      ),
      innerColor: AppColor.themeGreen,
      outerColor: AppColor.textFieldColor,
      sliderButtonIcon: const Icon(
        Icons.arrow_forward,
        color: Color.fromRGBO(50, 50, 50, 1),
      ),
      elevation: 2,
      onSubmit: () async {
        try {
          await tasksController.assignTask(
            title: taskTitle,
            description: taskDescription,
          );
          Get.back();
        } catch (e) {
          Get.back();
        }
      },
    ),
  );
}
