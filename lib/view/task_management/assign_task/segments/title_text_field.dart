part of '../assign_task_screen.dart';

Widget titleTextField({
  required TextEditingController titleController,
  required AssignTaskController assignTaskController,
}) {
  return TextFormField(
    controller: titleController,
    enabled: assignTaskController.isTitleAndDescriptionEnabled.value,
    maxLines: null,
    cursorOpacityAnimates: true,
    decoration: InputDecoration(
      hintText: 'Title',
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 13.5.h,
      ),
      fillColor: AppColors.textFieldColor,
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
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    ),
    onChanged: (value) {
      log(value);
    },
    validator: (value) {
      if (value == null) {
        return 'Invalid value';
      }
      if (value.trim().isEmpty) {
        return 'Title cannot be empty';
      }
      if (value.length < 3) {
        return 'Title length should be atleast 3 characters';
      }
      return null;
    },
  );
}
