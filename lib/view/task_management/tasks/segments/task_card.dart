import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/card_action_button.dart';

Widget taskCard({
  required AnimationController lottieController,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(48, 78, 85, 0.6),
          Color.fromRGBO(29, 36, 41, 1),
          Color.fromRGBO(90, 90, 90, .5),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 13.5.w,
        vertical: 10.h,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 215.w,
                    child: Text(
                      'Demo Task Title',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 2.w),
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
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 19.sp,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Ajay',
                        style: TextStyle(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Icon(
                        Icons.sell,
                        size: 15.sp,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Marketing',
                        style: TextStyle(
                          fontSize: 13.5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Icon(
                        Icons.flag,
                        size: 16.sp,
                        color: Colors.red,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'High',
                        style: TextStyle(
                          fontSize: 13.5.sp,
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
                iconColor: AppColor.themeGreen,
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
//                      SizedBox(width: 4),
//                     cardActionButton(
//                       title: 'Complete',
//                       icon: Icons.check_circle,
//                       iconColor: Colors.green,
//                     ),
//                   ],
//                 ),
//                  SizedBox(height: 13.5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     cardActionButton(
//                       title: 'Edit',
//                       icon: Icons.edit,
//                       iconColor: Colors.blue,
//                     ),
//                      SizedBox(width: 4),
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