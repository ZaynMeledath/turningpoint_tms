part of '../tasks_dashboard.dart';

Widget staffWiseTabBarView({
  required TasksController tasksController,
}) {
  final userController = Get.put(UserController());
  final userModel = userController.getUserModelFromHive();
  return ListView.builder(
    itemCount: 5,
    itemBuilder: (context, index) {
      return Container(
        width: double.maxFinite,
        height: 80.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(48, 78, 85, .4),
              Color.fromRGBO(29, 36, 41, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
//====================Avatar, Name and Progress Indicator====================//
            Row(
              children: [
                nameLetterAvatar(
                  name: '${userModel?.name}',
                  circleDiameter: 34.w,
                ),
                SizedBox(width: 6.w),
                Text(
                  '${userModel?.name}',
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  StatusIcons.overdue,
                  size: 18.w,
                  color: StatusColor.overdue,
                ),
                Text(
                  'Overdue',
                  style: TextStyle(
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
