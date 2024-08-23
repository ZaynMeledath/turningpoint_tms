part of '../tasks_dashboard.dart';

Widget dashboardStatusOverviewSection({
  required TasksController tasksController,
}) {
  return Obx(
    () {
      final overdueMyTasksCount =
          tasksController.overdueTaskList.value?.length ?? 0;
      final overdueDelegatedTasksCount =
          tasksController.overdueDelegatedTaskList.value?.length ?? 0;

      final pendingMyTasksCount =
          tasksController.pendingTaskList.value?.length ?? 0;
      final pendingDelegatedTasksCount =
          tasksController.pendingDelegatedTaskList.value?.length ?? 0;

      final inProgressMyTasksCount =
          tasksController.inProgressTaskList.value?.length ?? 0;
      final inProgressDelegatedTasksCount =
          tasksController.inProgressDelegatedTaskList.value?.length ?? 0;

      final completedMyTasksCount =
          tasksController.completedTaskList.value?.length ?? 0;
      final completedDelegatedTasksCount =
          tasksController.completedDelegatedTaskList.value?.length ?? 0;

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dashboardStatusOverviewContainer(
                status: Status.overdue,
                count: overdueMyTasksCount + overdueDelegatedTasksCount,
                icon: StatusIcons.overdue,
                iconColor: Colors.red,
              ),
              dashboardStatusOverviewContainer(
                status: Status.pending,
                count: pendingMyTasksCount + pendingDelegatedTasksCount,
                icon: StatusIcons.pending,
                iconColor: Colors.orange,
              ),
              dashboardStatusOverviewContainer(
                status: Status.inProgress,
                count: inProgressMyTasksCount + inProgressDelegatedTasksCount,
                icon: StatusIcons.inProgress,
                iconColor: Colors.blue,
              ),
            ],
          ).animate().slideY(
                begin: .5,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
              ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dashboardStatusOverviewContainer(
                status: Status.completed,
                count: completedMyTasksCount + completedDelegatedTasksCount,
                icon: StatusIcons.completed,
                iconColor: AppColors.themeGreen,
              ),
              dashboardStatusOverviewContainer(
                status: 'On Time',
                count: tasksController.completedOnTimeMyTasksList.length +
                    tasksController.completedOnTimeDelegatedTasksList.length,
                icon: Icons.schedule,
                iconColor: AppColors.themeGreen,
              ),
              dashboardStatusOverviewContainer(
                status: 'Delayed',
                count: tasksController.completedDelayedMyTasksList.length +
                    tasksController.completedDelayedDelegatedTasksList.length,
                icon: Icons.schedule,
                iconColor: Colors.red,
              )
            ],
          ).animate().slideY(
                begin: .5,
                delay: const Duration(milliseconds: 40),
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
              ),
        ],
      );
    },
  );
}
