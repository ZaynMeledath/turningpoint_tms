import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';

part 'segments/tasks_details_title_content.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskModel taskModel;
  final String dueDateString;

  const TaskDetailsScreen({
    required this.taskModel,
    required this.dueDateString,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final weekList = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    final monthList = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final creationDate = DateTime.parse(taskModel.createdAt.toString());
    final month = monthList[creationDate.month - 1];
    final weekDay = weekList[creationDate.weekday - 1];
    final date = creationDate.day;

    final hour24 = creationDate.hour;
    final hour = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = creationDate.minute;
    final period = hour24 >= 12 ? 'PM' : 'AM';
    final time = '$hour:$minute $period';

    final creationDateString = '$weekDay, $date $month $time';

    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Task Details',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              height: 190.h,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 245, 245, .23),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Task Title',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            size: 17.sp,
                            color: Colors.white70,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            dueDateString,
                            style: TextStyle(
                              color: taskModel.isDelayed == true
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    'Creation date : $creationDateString',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
