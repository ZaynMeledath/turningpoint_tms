part of '../my_tasks_screen.dart';

Future<Object?> showFilterBottomSheet() async {
  return Get.bottomSheet(
    filterBottomSheet(),
  );
}

Widget filterBottomSheet() {
  return Container(
    height: 500,
    decoration: const BoxDecoration(
      color: Color.fromRGBO(50, 50, 50, 1),
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
  );
}
