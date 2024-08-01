import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/card_action_button.dart';

part 'segments/title_description_container.dart';
part 'segments/task_details_assigned_container.dart';
part 'segments/task_updates_section.dart';

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

    // final creationDate = DateTime.parse(taskModel.createdAt.toString());
    // final month = monthList[creationDate.month - 1];
    // final weekDay = weekList[creationDate.weekday - 1];
    // final date = creationDate.day;

    // final hour24 = creationDate.hour;
    // final hour = hour24 % 12 == 0 ? 12 : hour24 % 12;
    // final minute = creationDate.minute;
    // final period = hour24 >= 12 ? 'PM' : 'AM';
    // final time = '$hour:$minute $period';

    // final creationDateString = '$weekDay, $date $month $time';

    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Task Details',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 14.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleDescriptionContainer(
                taskModel: taskModel,
                dueDateString: dueDateString,
                creationDateString: '',
              ),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  taskDetailsAssignedContainer(
                    name: 'Zayn Meledath',
                    isAssignedBy: true,
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    size: 28.w,
                  ),
                  taskDetailsAssignedContainer(
                    name: 'Ajay',
                    isAssignedBy: false,
                  ),
                ],
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cardActionButton(
                      title: 'In Progress',
                      icon: StatusIcons.inProgress,
                      iconColor: StatusIconColor.inProgress,
                      onTap: () {},
                      containerColor: Colors.grey.withOpacity(.08),
                      containerWidth: 150.w,
                      containerHeight: 40,
                      iconSize: 22.sp,
                      textSize: 14.sp,
                    ),
                    cardActionButton(
                      title: 'Completed',
                      icon: StatusIcons.completed,
                      iconColor: StatusIconColor.completed,
                      onTap: () {},
                      containerColor: Colors.grey.withOpacity(.08),
                      containerWidth: 150.w,
                      containerHeight: 40,
                      iconSize: 22.sp,
                      textSize: 14.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cardActionButton(
                      title: 'Edit',
                      icon: Icons.edit,
                      iconColor: Colors.blueGrey,
                      onTap: () {},
                      containerColor: Colors.grey.withOpacity(.08),
                      containerWidth: 150.w,
                      containerHeight: 40,
                      iconSize: 22.sp,
                      textSize: 14.sp,
                    ),
                    cardActionButton(
                      title: 'Delete',
                      icon: Icons.delete,
                      iconColor: Colors.red,
                      onTap: () {},
                      containerColor: Colors.grey.withOpacity(.08),
                      containerWidth: 150.w,
                      containerHeight: 40,
                      iconSize: 22.sp,
                      textSize: 14.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              // Container(
              //   width: double.maxFinite,
              //   height: 1,
              //   color: Colors.grey.withOpacity(.3),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
