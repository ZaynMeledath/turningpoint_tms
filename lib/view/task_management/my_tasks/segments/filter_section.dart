part of '../my_tasks_screen.dart';

Widget filterSection({
  required TextEditingController searchController,
  required UserController userController,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      children: [
        const SizedBox(height: 6),
        customTextField(
          controller: searchController,
          hintText: 'Search Task',
          userController: userController,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 110,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(75, 75, 75, .6),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Range',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
            Container(
              width: 110,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color.fromRGBO(75, 75, 75, .6),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
