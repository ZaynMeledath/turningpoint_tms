part of '../assign_task_screen.dart';

Widget descriptionTextField({
  required TextEditingController descriptionController,
  required AssignTaskController assingTaskController,
}) {
  return TextFormField(
    controller: descriptionController,
    enabled: assingTaskController.isTitleAndDescriptionEnabled.value,
    style: GoogleFonts.roboto(),
    maxLines: null,
    keyboardAppearance: Brightness.dark,
    cursorOpacityAnimates: true,
    decoration: InputDecoration(
      hintText: 'Description',
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
    ),
    validator: (value) {
      if (value == null) {
        return 'Invalid value';
      }
      if (value.trim().isEmpty) {
        return 'Description cannot be empty';
      }
      if (value.length < 3) {
        return 'Decription length should be atleast 3 characters';
      }
      return null;
    },
  );
}
