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

  return Hero(
    tag: 'task_card${taskModel.id}',
    child: Material(
      color: const Color.fromRGBO(255, 245, 245, .07),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 12.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //--------------------Title Segment--------------------//
            Text(
              taskModel.title.toString(),
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                SizedBox(
                  width: 72.w,
                  child: Text(
                    'Creation',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.w,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const Text(':'),
                SizedBox(width: 12.w),
                Icon(
                  Icons.schedule,
                  size: 17.sp,
                  color: Colors.white70,
                ),
                SizedBox(width: 3.w),
                Text(
                  dueDateString,
                  style: TextStyle(
                    fontSize: 14.w,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SizedBox(
                  width: 72.w,
                  child: const Text(
                    'Due Date',
                  ),
                ),
                const Text(':'),
                SizedBox(width: 12.w),
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
            SizedBox(height: 8.h),
            Row(
              children: [
                SizedBox(
                  width: 72.w,
                  child: const Text(
                    'Category',
                  ),
                ),
                const Text(':'),
                SizedBox(width: 12.w),
                Text(
                  taskModel.category.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SizedBox(
                  width: 72.w,
                  child: const Text(
                    'Priority',
                  ),
                ),
                const Text(':'),
                SizedBox(width: 12.w),
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
            SizedBox(height: 6.h),
            Text(
              taskModel.description.toString(),
              style: TextStyle(fontSize: 15.sp),
            ),
            SizedBox(height: 6.h),
          ],
        ),
      ),
    ),
  );
}
