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
      color: Color.fromRGBO(29, 36, 41, 1),
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    child: Column(
      children: [
        const Text('Filter Task'),
        const SizedBox(height: 10),
        Expanded(
          child: Row(
            children: [
              Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(30, 30, 30, 1),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
