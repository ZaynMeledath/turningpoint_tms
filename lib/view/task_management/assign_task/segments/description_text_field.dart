part of '../assign_task_screen.dart';

Widget descriptionTextField({
  required TextEditingController descriptionController,
  required TasksController tasksController,
}) {
  return TextFormField(
    controller: descriptionController,
    enabled: tasksController.isTitleAndDescriptionEnabled.value,
    style: GoogleFonts.roboto(),
    maxLines: null,
    keyboardAppearance: Brightness.dark,
    cursorOpacityAnimates: true,
    decoration: InputDecoration(
      hintText: 'Description',
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * .034,
        vertical: screenHeight * .015,
      ),
      fillColor: Colors.grey.withOpacity(.1),
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
