import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';

part 'segments/tasks_details_title_content.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Task Title',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            taskDetailsTitleContent(
              title: 'Description',
              content:
                  'Task Description sdoflsjdflj asdlflsdjfl aldflsdjflsjdf alfsjdfljlf adlsjdfljdl lasdjfljsdlfjl',
            ),
            SizedBox(height: 20.h),
            taskDetailsTitleContent(
              title: 'Assigned By',
              content: 'Nilesh Gala',
              addAvatar: true,
            ),
            SizedBox(height: 20.h),
            taskDetailsTitleContent(
              title: 'Assigned To',
              content: 'Zayn Meledath',
              addAvatar: true,
            ),
            SizedBox(height: 20.h),
            taskDetailsTitleContent(
              title: 'Created At',
              content: 'Sat, Jun 29 - 20:04PM',
              iconWidget: Icon(
                Icons.schedule,
                size: 20.sp,
              ),
            ),
            SizedBox(height: 20.h),
            taskDetailsTitleContent(
              title: 'Due Date',
              content: 'Sat, Jun 30 - 20:04PM',
              iconWidget: Icon(
                Icons.alarm,
                size: 20.sp,
              ),
            ),
            SizedBox(height: 20.h),
            taskDetailsTitleContent(
              title: 'Status',
              content: 'Completed',
              iconWidget: Icon(
                Icons.check_circle,
                size: 20.sp,
                color: AppColor.themeGreen,
              ),
            ),
            SizedBox(height: 20.h),
            taskDetailsTitleContent(
              title: 'Category',
              content: 'Automation',
            ),
            SizedBox(height: 20.h),
            taskDetailsTitleContent(
              title: 'Priority',
              content: 'Medium',
              iconWidget: Icon(
                Icons.flag,
                size: 20.sp,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
