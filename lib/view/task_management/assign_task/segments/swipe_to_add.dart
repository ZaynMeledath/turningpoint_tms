import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';

Widget swipeToAdd() {
  return SlideAction(
    sliderRotate: false,
    text: 'Add Task',
    textStyle: TextStyle(
      fontSize: screenWidth * .041,
    ),
    innerColor: const Color.fromRGBO(36, 196, 123, 1),
    outerColor: Colors.grey.withOpacity(.15),
    sliderButtonIcon: const Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(50, 50, 50, 1),
    ),
    elevation: 2,
  );
}
