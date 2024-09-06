part of '../tasks_dashboard.dart';

Widget dashboardStatusOverviewSection({
  required TasksController tasksController,
}) {
  return Obx(
    () {
      int overdueTasksCount;
      int openTasksCount;
      int inProgressTasksCount;
      int completedTasksCount;
      int onTimeTasksCount;
      int delayedTasksCount;

      final overdueMyTasksCount =
          tasksController.overdueTaskList.value?.length ?? 0;
      final overdueDelegatedTasksCount =
          tasksController.overdueDelegatedTaskList.value?.length ?? 0;

      final openMyTasksCount = tasksController.openTaskList.value?.length ?? 0;
      final openDelegatedTasksCount =
          tasksController.openDelegatedTaskList.value?.length ?? 0;

      final inProgressMyTasksCount =
          tasksController.inProgressTaskList.value?.length ?? 0;
      final inProgressDelegatedTasksCount =
          tasksController.inProgressDelegatedTaskList.value?.length ?? 0;

      final completedMyTasksCount =
          tasksController.completedTaskList.value?.length ?? 0;
      final completedDelegatedTasksCount =
          tasksController.completedDelegatedTaskList.value?.length ?? 0;

      if (tasksController.dashboardTabIndexObs.value == 2) {
        //When My Report tab is selected
        overdueTasksCount = overdueMyTasksCount;
        openTasksCount = openMyTasksCount;
        inProgressTasksCount = inProgressMyTasksCount;
        completedTasksCount = completedMyTasksCount;
        onTimeTasksCount = tasksController.completedOnTimeMyTasksList.length;
        delayedTasksCount = tasksController.completedDelayedMyTasksList.length;
      } else if (tasksController.dashboardTabIndexObs.value == 3) {
        //When Delegated Report tab is selected
        overdueTasksCount = overdueDelegatedTasksCount;
        openTasksCount = openDelegatedTasksCount;
        inProgressTasksCount = inProgressDelegatedTasksCount;
        completedTasksCount = completedDelegatedTasksCount;
        onTimeTasksCount =
            tasksController.completedOnTimeDelegatedTasksList.length;
        delayedTasksCount =
            tasksController.completedDelayedDelegatedTasksList.length;
      } else {
        overdueTasksCount = overdueMyTasksCount + overdueDelegatedTasksCount;
        openTasksCount = openMyTasksCount + openDelegatedTasksCount;
        inProgressTasksCount =
            inProgressMyTasksCount + inProgressDelegatedTasksCount;
        completedTasksCount =
            completedMyTasksCount + completedDelegatedTasksCount;
        onTimeTasksCount = tasksController.completedOnTimeMyTasksList.length +
            tasksController.completedOnTimeDelegatedTasksList.length;
        delayedTasksCount = tasksController.completedDelayedMyTasksList.length +
            tasksController.completedDelayedDelegatedTasksList.length;
      }

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dashboardStatusOverviewContainer(
                status: Status.overdue,
                count: overdueTasksCount,
                icon: StatusIcons.overdue,
                iconColor: Colors.red,
              ),
              dashboardStatusOverviewContainer(
                status: Status.open,
                count: openTasksCount,
                icon: StatusIcons.open,
                iconColor: Colors.orange,
              ),
              dashboardStatusOverviewContainer(
                status: Status.inProgress,
                count: inProgressTasksCount,
                icon: StatusIcons.inProgress,
                iconColor: Colors.blue,
              ),
            ],
          ).animate().slideY(
                begin: -.5,
                delay: const Duration(milliseconds: 40),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
              ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dashboardStatusOverviewContainer(
                status: Status.completed,
                count: completedTasksCount,
                icon: StatusIcons.completed,
                iconColor: AppColors.themeGreen,
              ),
              dashboardStatusOverviewContainer(
                status: 'On Time',
                count: onTimeTasksCount,
                icon: Icons.schedule,
                iconColor: AppColors.themeGreen,
              ),
              dashboardStatusOverviewContainer(
                status: 'Delayed',
                count: delayedTasksCount,
                icon: Icons.schedule,
                iconColor: Colors.red,
              )
            ],
          ).animate().slideY(
                begin: -.5,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
              ),
        ],
      );
    },
  );
}
