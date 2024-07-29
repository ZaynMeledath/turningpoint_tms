part of '../assign_task_screen.dart';

Widget titleTextField({
  required TextEditingController titleController,
  required TasksController tasksController,
}) {
  return TextFormField(
    controller: titleController,
    enabled: tasksController.isTitleAndDescriptionEnabled.value,
    maxLines: null,
    keyboardAppearance: Brightness.dark,
    cursorOpacityAnimates: true,
    decoration: InputDecoration(
      hintText: 'Title',
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 13.5.h,
      ),
      fillColor: AppColor.textFieldColor,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color.fromRGBO(52, 228, 140, .18),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}
