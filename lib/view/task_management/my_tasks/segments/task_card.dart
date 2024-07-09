part of '../my_tasks_screen.dart';

Widget taskCard() {
  return Card(
    color: const Color.fromRGBO(72, 72, 72, .4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Task Title',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text('Assigned By Zayn Meledath'),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.alarm,
                    size: 18,
                  ),
                  const SizedBox(width: 2),
                  const Text(
                    'Fri, Jun 2 5:00 PM',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.done,
                        size: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
