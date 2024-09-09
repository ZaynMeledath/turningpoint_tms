part of '../assign_task_screen.dart';

Widget swipeToAdd({
  required AssignTaskController assignTaskController,
  required String taskTitle,
  required String taskDescription,
  required GlobalKey<FormState> formKey,
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
      innerColor: AppColors.themeGreen,
      outerColor: AppColors.textFieldColor,
      sliderButtonIcon: const Icon(
        Icons.arrow_forward,
        color: Color.fromRGBO(50, 50, 50, 1),
      ),
      elevation: 2,
      onSubmit: () async {
        if (formKey.currentState!.validate()) {
          if (assignTaskController.assignToList.isEmpty ||
              assignTaskController.selectedCategory.value.isEmpty) {
            return showGenericDialog(
              iconPath: 'assets/lotties/fill_details_animation.json',
              title: 'Fill Details',
              content: 'Please fill all the details before creating the task',
              buttons: {'OK': null},
            );
          }

          try {
            await assignTaskController.assignTask(
              title: taskTitle,
              description: taskDescription,
            );
            Get.back();
          } catch (e) {
            showGenericDialog(
              iconPath: 'assets/lotties/server_error_animation.json',
              title: 'Something went wrong',
              content: 'Something went wrong while creating the task',
              buttons: {'Dismiss': null},
            );
          }
        }
      },
    ),
  );
}
