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
        Row(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                await showFilterBottomSheet();
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.filter_list,
                  color: Color.fromRGBO(36, 196, 123, 1),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: customTextField(
                controller: searchController,
                hintText: 'Search Task',
                userController: userController,
              ),
            ),
          ],
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
                color: Colors.grey.withOpacity(.15),
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
                color: Colors.grey.withOpacity(.15),
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
