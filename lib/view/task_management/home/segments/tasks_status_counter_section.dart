part of '../tasks_dashboard.dart';

Widget tasksStatusCounterSection({
  required int? overdueCount,
  required int? openCount,
  required int? inProgressCount,
  required int? completedCount,
  required int? onTimeCount,
  required int? delayedCount,
}) {
  return Column(
    children: [
      //====================Overdue, Open and In Progress Row====================//
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                StatusIcons.overdue,
                size: 18.w,
                color: StatusColor.overdue,
              ),
              SizedBox(width: 2.w),
              Text(
                'Overdue: ',
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                '${overdueCount ?? '-'}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                StatusIcons.open,
                size: 18.w,
                color: StatusColor.open,
              ),
              SizedBox(width: 2.w),
              Text(
                'Open: ',
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                '${openCount ?? '-'}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                StatusIcons.inProgress,
                size: 18.w,
                color: StatusColor.inProgress,
              ),
              SizedBox(width: 2.w),
              Text(
                'In Progress: ',
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                '${inProgressCount ?? '-'}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),

      SizedBox(height: 10.h),
      //====================Completed, In Time, and Delayed Row====================//
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                StatusIcons.completed,
                size: 18.w,
                color: StatusColor.completed,
              ),
              SizedBox(width: 2.w),
              Text(
                'Completed: ',
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                '${completedCount ?? '-'}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 18.w,
                color: StatusColor.completed,
              ),
              SizedBox(width: 2.w),
              Text(
                'On Time: ',
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                '${onTimeCount ?? '-'}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 18.w,
                color: StatusColor.overdue,
              ),
              SizedBox(width: 2.w),
              Text(
                'Delayed: ',
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Text(
                '${delayedCount ?? '-'}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
