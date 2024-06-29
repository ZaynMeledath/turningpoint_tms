part of '../assign_task_screen.dart';

Future<Object?> showLinkDialog() async {
  return Get.dialog(
    dialog(),
    transitionCurve: Curves.easeInOut,
  );
}

Widget dialog() {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text('Add Links for your Tasks'),
          ],
        ),
      ),
    ],
  );
}
