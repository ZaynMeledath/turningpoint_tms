import 'package:flutter/material.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';

Widget titleTextField(TextEditingController titleController) {
  return TextField(
    controller: titleController,
    maxLines: null,
    keyboardAppearance: Brightness.dark,
    cursorOpacityAnimates: true,
    decoration: InputDecoration(
      hintText: 'Title',
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
