part of '../assign_task_screen.dart';

Widget swipeToAdd() {
  return SlideAction(
    sliderRotate: false,
    text: 'Add Task',
    textStyle: TextStyle(
      fontSize: screenWidth * .041,
    ),
    innerColor: const Color.fromRGBO(36, 196, 123, 1),
    outerColor: const Color.fromRGBO(32, 32, 32, 1),
    sliderButtonIcon: const Icon(
      Icons.arrow_forward,
      color: Color.fromRGBO(50, 50, 50, 1),
    ),
    elevation: 2,
    onSubmit: () async {
      await Future.delayed(const Duration(milliseconds: 800));
      Get.back();
    },
  );
}
