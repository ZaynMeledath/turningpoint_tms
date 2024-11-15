part of '../task_details_screen.dart';

Widget titleDescriptionContainer({
  required TaskModel taskModel,
}) {
  Color priorityFlagColor = Colors.white.withOpacity(.9);

  switch (taskModel.priority) {
    case 'High':
      priorityFlagColor = Colors.red;
      break;
    case 'Medium':
      priorityFlagColor = Colors.orange;
      break;
    default:
      break;
  }

  String completionDateString = '';

  final String creationDateString = taskModel.createdAt != null
      ? taskModel.createdAt!.dateFormat()
      : 'Invalid Date & Time';

  final String dueDateString = taskModel.dueDate != null
      ? taskModel.dueDate!.dateFormat()
      : 'Invalid Date & Time';

  if (taskModel.status == Status.completed) {
    completionDateString =
        taskModel.updatedAt != null ? taskModel.updatedAt!.dateFormat() : '-';
  }

//Week starts from sunday
  final weekDaysList = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  List<String> repeatWeekDays = [];
  if (taskModel.repeat != null && taskModel.repeat!.frequency == 'Weekly') {
    for (int day in taskModel.repeat!.days!) {
      repeatWeekDays.add(weekDaysList[day]);
    }
  }

  return Hero(
    tag: 'task_card${taskModel.id}',
    child: Material(
      color: const Color.fromRGBO(255, 245, 245, .07),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //--------------------Title Segment--------------------//
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  taskModel.isApproved == true
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 6.h),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 6.w),
                                child: Icon(
                                  Icons.verified,
                                  size: 26.w,
                                  color: Colors.teal,
                                ),
                              ),
                              Text(
                                'Task Approved',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white54,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),

                  //====================Task Title====================//
                  Text(
                    taskModel.title.toString(),
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  //====================Creation Date====================//
                  Row(
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: Text(
                          'Creation',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.w,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      const Text(':'),
                      SizedBox(width: 14.w),
                      Icon(
                        Icons.schedule,
                        size: 17.sp,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        creationDateString,
                        style: TextStyle(
                          fontSize: 14.w,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  //====================Due Date====================//
                  Row(
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: const Text(
                          'Due Date',
                        ),
                      ),
                      SizedBox(width: 6.w),
                      const Text(':'),
                      SizedBox(width: 14.w),
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
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  //====================Completion Date====================//
                  taskModel.status == Status.completed
                      ? Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 90.w,
                                child: const Text(
                                  'Completion',
                                ),
                              ),
                              SizedBox(width: 6.w),
                              const Text(':'),
                              SizedBox(width: 14.w),
                              Icon(
                                Icons.alarm,
                                size: 17.sp,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                completionDateString,
                                style: TextStyle(
                                  color: taskModel.isDelayed == true
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),

//====================Repeat Section====================//
            if (taskModel.repeat != null)
              Container(
                padding: EdgeInsets.all(8.w),
                margin: EdgeInsets.only(top: 8.h),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 245, 245, .06),
                  border: Border.all(
                    color: Colors.white12,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    //====================Repeat Frequency====================//
                    Row(
                      children: [
                        SizedBox(
                          width: 90.w,
                          child: const Text(
                            'Repeat Frequency',
                          ),
                        ),
                        SizedBox(width: 6.w),
                        const Text(':'),
                        SizedBox(width: 14.w),
                        Text(
                          taskModel.repeat!.frequency.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),

                    //====================Repeat Days====================//
                    if (taskModel.repeat!.frequency == 'Monthly' ||
                        taskModel.repeat!.frequency == 'Weekly')
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90.w,
                              child: const Text(
                                'Repeat Days',
                              ),
                            ),
                            SizedBox(width: 6.w),
                            const Text(':'),
                            SizedBox(width: 14.w),
                            Text(
                              taskModel.repeat!.frequency == 'Monthly'
                                  ? taskModel.repeat!.days!.join(', ')
                                  : repeatWeekDays.join(', '),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    SizedBox(height: 8.h),

                    //====================Repeat Start Date====================//
                    Row(
                      children: [
                        SizedBox(
                          width: 90.w,
                          child: const Text(
                            'Start Date',
                          ),
                        ),
                        SizedBox(width: 6.w),
                        const Text(':'),
                        SizedBox(width: 14.w),
                        Text(
                          taskModel.repeat!.startDate!.dateFormat(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                          ),
                        )
                      ],
                    ),

                    //====================Repeat End Date====================//
                    if (taskModel.repeat!.endDate != null)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 90.w,
                              child: const Text(
                                'End Date',
                              ),
                            ),
                            SizedBox(width: 6.w),
                            const Text(':'),
                            SizedBox(width: 14.w),
                            Text(
                              taskModel.repeat!.endDate!.dateFormat(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white70,
                              ),
                            )
                          ],
                        ),
                      ),

                    //====================Repeat Occurrences====================//
                    if (taskModel.repeat!.occurrenceCount != null &&
                        taskModel.repeat!.occurrenceCount! > 0)
                      Row(
                        children: [
                          SizedBox(
                            width: 90.w,
                            child: const Text(
                              'Occurrences',
                            ),
                          ),
                          SizedBox(width: 6.w),
                          const Text(':'),
                          SizedBox(width: 14.w),
                          Text(
                            taskModel.repeat!.occurrenceCount!.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            SizedBox(height: 8.h),

//====================Category====================//
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: const Text(
                          'Category',
                        ),
                      ),
                      SizedBox(width: 6.w),
                      const Text(':'),
                      SizedBox(width: 14.w),
                      Text(
                        taskModel.category.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 8.h),

                  //====================Priority====================//
                  Row(
                    children: [
                      SizedBox(
                        width: 90.w,
                        child: const Text(
                          'Priority',
                        ),
                      ),
                      SizedBox(width: 6.w),
                      const Text(':'),
                      SizedBox(width: 14.w),
                      Icon(
                        Icons.flag,
                        size: 18.sp,
                        color: priorityFlagColor,
                      ),
                      Text(
                        taskModel.priority.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.maxFinite,
                    height: 1,
                    color: Colors.white24,
                  ),
                  SizedBox(height: 14.h),

                  //--------------------Description Segment--------------------//
                  taskModel.description != null &&
                          taskModel.description!.isNotEmpty
                      ? Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white70,
                            decoration: TextDecoration.underline,
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(height: 6.h),
                  Text(
                    taskModel.description.toString(),
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  SizedBox(height: 6.h),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
