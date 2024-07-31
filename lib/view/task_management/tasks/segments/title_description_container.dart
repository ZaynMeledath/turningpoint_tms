part of '../task_details_screen.dart';

Widget titleDescriptionContainer({
  required TaskModel taskModel,
  required String dueDateString,
  required String creationDateString,
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

  return Container(
    width: double.maxFinite,
    padding: EdgeInsets.symmetric(
      horizontal: 12.w,
      vertical: 12.h,
    ),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(255, 245, 245, .1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
//--------------------Title Segment--------------------//
        Text(
          'Task Title ',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 195.w,
              child: Text(
                'Creation : Fri, 12 Jun 12:15 AM ',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.w,
                  color: Colors.white70,
                ),
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
                    color:
                        taskModel.isDelayed == true ? Colors.red : Colors.green,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            const Text(
              'Category : ',
            ),
            SizedBox(width: 4.w),
            Text(
              taskModel.category.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.maxFinite,
          height: 1,
          color: Colors.grey,
        ),
        SizedBox(height: 14.h),

//--------------------Description Segment--------------------//
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            taskModel.description != null && taskModel.description!.isNotEmpty
                ? Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white70,
                      decoration: TextDecoration.underline,
                    ),
                  )
                : const SizedBox(),
            Row(
              children: [
                Icon(
                  Icons.flag,
                  size: 18.sp,
                  color: priorityFlagColor,
                ),
                SizedBox(width: 2.w),
                Padding(
                  padding: EdgeInsets.only(
                    right: 6.w,
                  ),
                  child: Text(
                    taskModel.priority.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          taskModel.description.toString(),
          style: TextStyle(fontSize: 15.sp),
        ),
        SizedBox(height: 6.h),
      ],
    ),
  );
}
