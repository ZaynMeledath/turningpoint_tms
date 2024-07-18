part of '../assign_task_screen.dart';

Widget priorityTabBar({
  required TabController tabController,
  required TasksController tasksController,
}) {
  return Column(
    children: [
      Row(
        children: [
          SizedBox(height: screenWidth * .025),
          Obx(
            () => Icon(
              Icons.flag,
              color: tasksController.taskPriority.value == TaskPriority.low
                  ? Colors.white.withOpacity(.9)
                  : tasksController.taskPriority.value == TaskPriority.medium
                      ? Colors.orange
                      : Colors.red,
            ),
          ),
          SizedBox(height: screenWidth * .005),
          Text(
            'Priority',
            style: TextStyle(
              fontSize: screenWidth * .04,
            ),
          ),
        ],
      ),
      SizedBox(height: screenHeight * .015),
      Container(
        height: screenHeight * .068,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.withOpacity(.1),
        ),
        child: TabBar(
          onTap: (index) => tasksController.changeTaskPriority(index),
          controller: tabController,
          dividerColor: Colors.transparent,
          enableFeedback: true,
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateColor.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.black87,
          labelStyle: TextStyle(
            fontSize: screenWidth * .035,
            fontFamily: 'Lufga',
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelColor: Colors.white54,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [AppColor.themeGreen, Color.fromRGBO(52, 228, 140, 1)],
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
