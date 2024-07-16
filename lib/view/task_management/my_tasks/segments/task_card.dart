part of '../my_tasks_screen.dart';

Widget taskCard({
  required AnimationController lottieController,
}) {
  return Container(
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(16),
    // ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(72, 72, 72, .3),
          Color.fromRGBO(90, 90, 90, .55),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 13.5,
        vertical: 10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 215,
                    child: Text(
                      'Demo Task Title',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
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
                            fontWeight: FontWeight.w600,
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
                        size: 19,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Ajay',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.sell,
                        size: 15,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Marketing',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.flag,
                        size: 16,
                        color: Colors.red,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'High',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 18,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'Fri, Jun 2 5:00 PM',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Lottie.asset(
                    'assets/lotties/in_progress_animation.json',
                    controller: lottieController,
                    width: 30,
                    // repeat: false,
                  ),
                  const SizedBox(width: 3),
                  const Text(
                    'In Progress',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cardActionButton(
                title: 'In Progress',
                icon: Icons.timelapse,
                iconColor: Colors.blue,
                onTap: () {},
              ),
              cardActionButton(
                title: 'Complete',
                icon: Icons.check_circle,
                iconColor: Colors.green,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cardActionButton(
                title: 'Edit',
                icon: Icons.edit,
                iconColor: Colors.blueGrey,
                onTap: () {},
              ),
              cardActionButton(
                title: 'Delete',
                icon: Icons.delete,
                iconColor: Colors.red,
                onTap: () {},
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
//                 const SizedBox(height: 13.5),
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