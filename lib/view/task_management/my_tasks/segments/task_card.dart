part of '../my_tasks_screen.dart';

Widget taskCard() {
  return Card(
    color: const Color.fromRGBO(72, 72, 72, .4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Task Title',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text.rich(
                    TextSpan(
                      text: 'Assigned By ',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.6),
                      ),
                      children: const [
                        TextSpan(
                          text: 'Zayn Meledath',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 18,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Ajay',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.sell,
                        size: 14,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Marketing',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.flag,
                        size: 14,
                        color: Colors.red,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'High',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 18,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Fri, Jun 2 5:00 PM',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Icon(
                      Icons.check_circle,
                      size: 20,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 3),
                  Text(
                    'Completed',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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













// Expanded(
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     cardActionButton(
//                       title: 'In Progress',
//                       icon: Icons.timelapse_rounded,
//                       iconColor: Colors.orange,
//                     ),
//                     const SizedBox(width: 4),
//                     cardActionButton(
//                       title: 'Complete',
//                       icon: Icons.check_circle,
//                       iconColor: Colors.green,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 14),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     cardActionButton(
//                       title: 'Edit',
//                       icon: Icons.edit,
//                       iconColor: Colors.blue,
//                     ),
//                     const SizedBox(width: 4),
//                     cardActionButton(
//                       title: 'Delete',
//                       icon: Icons.delete,
//                       iconColor: Colors.red,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),