part of '../assign_task_screen.dart';

Widget priorityTabBar({
  required TabController tabController,
  required AssignTaskController assignTaskController,
}) {
  return Column(
    children: [
      Row(
        children: [
          SizedBox(height: 10.h),
          Obx(
            () => Icon(
              Icons.flag,
              color: assignTaskController.taskPriority.value == TaskPriority.low
                  ? Colors.white.withOpacity(.9)
                  : assignTaskController.taskPriority.value ==
                          TaskPriority.medium
                      ? Colors.orange
                      : Colors.red,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Priority',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
      SizedBox(height: 14.h),
      Container(
        height: 62.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.textFieldColor,
        ),
        child: TabBar(
          onTap: (index) => assignTaskController.changeTaskPriority(index),
          controller: tabController,
          dividerColor: Colors.transparent,
          enableFeedback: true,
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateColor.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Lufga',
          ),
          unselectedLabelColor: Colors.black54,
          indicator: BoxDecoration(
            color: const Color(0xff5d87ff),
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [AppColors.themeGreen, Color.fromRGBO(52, 228, 140, 1)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          tabs: const [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Low'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Medium'),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('High'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}
