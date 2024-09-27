part of '../tasks_dashboard.dart';

Widget dashboardStatusOverviewSection({
  required TasksController tasksController,
  required bool isAdminOrLeader,
}) {
  int overdueTasksCount;
  int openTasksCount;
  int inProgressTasksCount;
  int completedTasksCount;
  int onTimeTasksCount;
  int delayedTasksCount;
  return Obx(
    () {
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

      if (!isAdminOrLeader) {
        overdueTasksCount = overdueMyTasksCount;
        openTasksCount = openMyTasksCount;
        inProgressTasksCount = inProgressMyTasksCount;
        completedTasksCount = completedMyTasksCount;
        onTimeTasksCount = tasksController.completedOnTimeMyTasksList.length;
        delayedTasksCount = tasksController.completedDelayedMyTasksList.length;
      } else if (tasksController.dashboardTabIndexObs.value == 2) {
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
        overdueTasksCount = tasksController.allTasksListObs.value
                ?.where((taskModel) => taskModel.status == Status.overdue)
                .length ??
            0;
        openTasksCount = tasksController.allTasksListObs.value
                ?.where((taskModel) => taskModel.status == Status.open)
                .length ??
            0;
        inProgressTasksCount = tasksController.allTasksListObs.value
                ?.where((taskModel) => taskModel.status == Status.inProgress)
                .length ??
            0;
        completedTasksCount = tasksController.allTasksListObs.value
                ?.where((taskModel) => taskModel.status == Status.completed)
                .length ??
            0;
        onTimeTasksCount = tasksController.allTasksListObs.value
                ?.where((taskModel) =>
                    taskModel.status == Status.completed &&
                    taskModel.isDelayed != true)
                .length ??
            0;
        delayedTasksCount = tasksController.allTasksListObs.value
                ?.where((taskModel) =>
                    taskModel.status == Status.completed &&
                    taskModel.isDelayed == true)
                .length ??
            0;
      }

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
//====================OverDue Tasks====================//
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  tasksController.addToDashboardTasksList(
                      tasksList: tasksController.allTasksListObs.value!
                          .where(
                              (taskModel) => taskModel.status == Status.overdue)
                          .toList());
                  Get.to(() => const TasksScreen(
                        title: 'Overdue Tasks',
                        avoidTabBar: true,
                      ));
                },
                child: dashboardStatusOverviewContainer(
                  status: Status.overdue,
                  count: overdueTasksCount,
                  icon: StatusIcons.overdue,
                  iconColor: Colors.red,
                ),
              ),

//====================Open Tasks====================//
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  tasksController.addToDashboardTasksList(
                      tasksList: tasksController.allTasksListObs.value!
                          .where((taskModel) => taskModel.status == Status.open)
                          .toList());
                  Get.to(() => const TasksScreen(
                        title: 'Open Tasks',
                        avoidTabBar: true,
                      ));
                },
                child: dashboardStatusOverviewContainer(
                  status: Status.open,
                  count: openTasksCount,
                  icon: StatusIcons.open,
                  iconColor: Colors.orange,
                ),
              ),

//====================In Progress Tasks====================//
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  tasksController.addToDashboardTasksList(
                      tasksList: tasksController.allTasksListObs.value!
                          .where((taskModel) =>
                              taskModel.status == Status.inProgress)
                          .toList());
                  Get.to(() => const TasksScreen(
                        title: 'In Progress Tasks',
                        avoidTabBar: true,
                      ));
                },
                child: dashboardStatusOverviewContainer(
                  status: Status.inProgress,
                  count: inProgressTasksCount,
                  icon: StatusIcons.inProgress,
                  iconColor: Colors.blue,
                ),
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
//====================Completed Tasks====================//
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  tasksController.addToDashboardTasksList(
                      tasksList: tasksController.allTasksListObs.value!
                          .where((taskModel) =>
                              taskModel.status == Status.completed)
                          .toList());
                  Get.to(() => const TasksScreen(
                        title: 'Completed Tasks',
                        avoidTabBar: true,
                      ));
                },
                child: dashboardStatusOverviewContainer(
                  status: Status.completed,
                  count: completedTasksCount,
                  icon: StatusIcons.completed,
                  iconColor: AppColors.themeGreen,
                ),
              ),

//====================On Time Tasks====================//
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  tasksController.addToDashboardTasksList(
                      tasksList: tasksController.allTasksListObs.value!
                          .where((taskModel) =>
                              taskModel.status == Status.completed &&
                              taskModel.isDelayed != true)
                          .toList());
                  Get.to(() => const TasksScreen(
                        title: 'On Time Tasks',
                        avoidTabBar: true,
                      ));
                },
                child: dashboardStatusOverviewContainer(
                  status: 'On Time',
                  count: onTimeTasksCount,
                  icon: Icons.schedule,
                  iconColor: AppColors.themeGreen,
                ),
              ),

//====================Delayed Tasks====================//
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  tasksController.addToDashboardTasksList(
                      tasksList: tasksController.allTasksListObs.value!
                          .where((taskModel) =>
                              taskModel.status == Status.completed &&
                              taskModel.isDelayed == true)
                          .toList());
                  Get.to(() => const TasksScreen(
                        title: 'Delayed Tasks',
                        avoidTabBar: true,
                      ));
                },
                child: dashboardStatusOverviewContainer(
                  status: 'Delayed',
                  count: delayedTasksCount,
                  icon: Icons.schedule,
                  iconColor: Colors.red,
                ),
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
