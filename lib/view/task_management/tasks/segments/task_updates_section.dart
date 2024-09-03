part of '../task_details_screen.dart';

Widget taskUpdateSection({
  required TaskModel taskModel,
}) {
  final statusChangesList = taskModel.statusChanges ?? [];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Task Updates',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
      SizedBox(height: 12.h),
      for (int i = 0; i < statusChangesList.length; i++)
        Builder(builder: (context) {
          final statusChangesModel = statusChangesList[i];
          return Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(48, 78, 85, .4),
                  Color.fromRGBO(29, 36, 41, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: Colors.grey.withOpacity(.3),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      statusChangesModel.taskUpdatedBy.toString(),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          statusChangesModel.status.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
    ],
  );
}
