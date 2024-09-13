part of '../assign_task_screen.dart';

Widget swipeToAdd({
  required AssignTaskController assignTaskController,
  required String taskTitle,
  required String taskDescription,
  required GlobalKey<FormState> formKey,
  required bool isUpdating,
  required TaskModel? taskModel,
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
          if (assignTaskController.assignToMap.isEmpty ||
              assignTaskController.selectedCategory.value.isEmpty) {
            return showGenericDialog(
              iconPath: 'assets/lotties/fill_details_animation.json',
              title: 'Fill Details',
              content: 'Please fill all the details before creating the task',
              buttons: {'OK': null},
            );
          }

          try {
            if (isUpdating) {
              await assignTaskController.updateTask(
                taskModel: taskModel!,
                title: taskTitle,
                description: taskDescription,
              );
              showGenericDialog(
                iconPath: 'assets/lotties/success_animation.json',
                title: 'Task Updated!',
                content: 'Task updated successfully',
                buttons: {'OK': null},
              );
            } else {
              await assignTaskController.assignTask(
                title: taskTitle,
                description: taskDescription,
              );
              Get.back();
              showGenericDialog(
                iconPath: 'assets/lotties/success_animation.json',
                title: 'Task Created!',
                content: 'Task created successfully',
                buttons: {'OK': null},
              );
            }
          } on DateTimeErrorException {
            return showGenericDialog(
              iconPath: 'assets/lotties/task_Open_animation.json',
              iconWidth: 50.w,
              title: 'Date and time Error',
              content: 'Date and time should be in the future',
              buttons: {'OK': null},
            );
          } catch (_) {
            return showGenericDialog(
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
