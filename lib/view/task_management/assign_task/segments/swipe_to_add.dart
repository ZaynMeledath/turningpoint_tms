part of '../assign_task_screen.dart';

Widget swipeToAdd({
  required AssignTaskController assignTaskController,
  required TextEditingController titleController,
  required TextEditingController descriptionController,
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
        color: Colors.white,
      ),
      elevation: 2,
      onSubmit: () async {
        if (formKey.currentState!.validate()) {
          if (assignTaskController.assignToMap.isEmpty ||
              assignTaskController.selectedCategory.value.isEmpty) {
            if (assignTaskController.assignToMap.isEmpty) {
              assignTaskController.showAssignToEmptyErrorTextObs.value = true;
            }
            if (assignTaskController.selectedCategory.value.isEmpty) {
              assignTaskController.showCategoryEmptyErrorTextObs.value = true;
            }
            return 0;
          }

          if (assignTaskController.shouldRepeatTask.value == true) {
            if (assignTaskController.taskRepeatFrequency.value ==
                RepeatFrequency.weekly) {
              final selectedList = assignTaskController.daysMap.values
                  .where((value) => value == true);

              if (selectedList.isEmpty) {
                assignTaskController.showWeeklyFrequencyErrorTextObs.value =
                    true;
                return 0;
              }
            } else if (assignTaskController.taskRepeatFrequency.value ==
                RepeatFrequency.monthly) {
              final selectedList = assignTaskController.datesMap.values
                  .where((value) => value == true);

              if (selectedList.isEmpty) {
                assignTaskController.showMonthlyFrequencyErrorTextObs.value =
                    true;
                return 0;
              }
            }
          }

          try {
            if (isUpdating) {
              taskModel!.title = titleController.text.trim();
              taskModel.description = descriptionController.text.trim();
              await assignTaskController.updateTask(
                taskModel: taskModel,
              );
              Get.back();
              showGenericDialog(
                iconPath: 'assets/lotties/success_animation.json',
                title: 'Task Updated!',
                content: 'Task updated successfully',
                buttons: {'OK': null},
              );
            } else {
              await assignTaskController.assignTask(
                title: titleController.text.trim(),
                description: descriptionController.text.trim(),
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
            assignTaskController.showTimeErrorTextObs.value = true;
            return 0;
          } on RepeatFrequencyNullException {
            assignTaskController.showRepeatFrequencyErrorTextObs.value = true;
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
