import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/server_error_widget.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/task_tab_bar_view.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/tasks_filter_section.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/tasks_tab_bar.dart';

class TasksScreen extends StatefulWidget {
  final String title;
  final bool? avoidTabBar;

  const TasksScreen({
    required this.title,
    this.avoidTabBar,
    super.key,
  });

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with TickerProviderStateMixin {
  late AnimationController lottieController;
  late TextEditingController taskSearchController;
  late TextEditingController categorySearchController;
  late TextEditingController assignedBySearchController;
  late TextEditingController assignedToSearchController;
  late TabController tabController;
  final UserController userController = Get.put(UserController());
  final TasksController tasksController = Get.put(TasksController());
  final FilterController filterController = Get.put(FilterController());

  final AppController appController = AppController();
  int animationCounter = 0;

  @override
  void initState() {
    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    tabController = TabController(
      length: 5,
      vsync: this,
    );
    taskSearchController = TextEditingController();
    categorySearchController = TextEditingController();
    assignedBySearchController = TextEditingController();
    assignedToSearchController = TextEditingController();
    animateLottie();
    super.initState();
  }

  void animateLottie() async {
    try {
      animationCounter++;
      lottieController
        ..reset()
        ..forward();
      await Future.delayed(
        Duration(milliseconds: animationCounter < 2 ? 1500 : 15000),
      );
      if (!lottieController.isDismissed) {
        animateLottie();
      }
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    super.dispose();
    filterController.resetFilters();
    lottieController.dispose();
    taskSearchController.dispose();
    assignedBySearchController.dispose();
    assignedToSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: myAppBar(
          title: widget.title,
          implyLeading: true,
          profileAvatar: true,
        ),
        body: Obx(
          () {
            final allTasksList = tasksController.dashboardTasksListObs;
            final openTasksList = tasksController.dashboardTasksListObs
                .where((taskModel) => taskModel.status == Status.open)
                .toList();
            final inProgressTasksList = tasksController.dashboardTasksListObs
                .where((taskModel) => taskModel.status == Status.inProgress)
                .toList();
            final completedTasksList = tasksController.dashboardTasksListObs
                .where((taskModel) => taskModel.status == Status.completed)
                .toList();
            final overdueTasksList = tasksController.dashboardTasksListObs
                .where((taskModel) => taskModel.status == Status.overdue)
                .toList();

            return Column(
              children: [
                tasksFilterSection(
                    taskSearchController: taskSearchController,
                    categorySearchController: categorySearchController,
                    assignedBySearchController: assignedBySearchController,
                    assignedToSearchController: assignedToSearchController,
                    userController: userController,
                    filterController: filterController,
                    tasksController: tasksController,
                    // avoidFilterButton: true,
                    textFieldOnChanged: (value) {
                      tasksController.dashboardTasksListObs.value =
                          tasksController.dashboardTasksListObs
                              .where((taskModel) =>
                                  taskModel.title!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()) ||
                                  taskModel.description!
                                      .toLowerCase()
                                      .contains(value.toLowerCase()))
                              .toList();
                    }),
                SizedBox(height: 10.h),
                widget.avoidTabBar == true
                    ? const SizedBox()
                    : tasksTabBar(
                        tabController: tabController,
                        allTasksCount: allTasksList.length,
                        overdueTasksCount: overdueTasksList.length,
                        openTasksCount: openTasksList.length,
                        inProgressTasksCount: inProgressTasksList.length,
                        completedTasksCount: completedTasksList.length,
                      ),
                SizedBox(height: 12.h),
                tasksController.tasksException.value == null
                    ? Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            taskTabBarView(
                              tasksList: allTasksList,
                              lottieController: lottieController,
                              tasksController: tasksController,
                              taskSearchController: taskSearchController,
                            ),
                            taskTabBarView(
                              tasksList: overdueTasksList,
                              lottieController: lottieController,
                              tasksController: tasksController,
                              taskSearchController: taskSearchController,
                            ),
                            taskTabBarView(
                              tasksList: openTasksList,
                              lottieController: lottieController,
                              tasksController: tasksController,
                              taskSearchController: taskSearchController,
                            ),
                            taskTabBarView(
                              tasksList: inProgressTasksList,
                              lottieController: lottieController,
                              tasksController: tasksController,
                              taskSearchController: taskSearchController,
                            ),
                            taskTabBarView(
                              tasksList: completedTasksList,
                              lottieController: lottieController,
                              tasksController: tasksController,
                              taskSearchController: taskSearchController,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(height: 90.h),
                          serverErrorWidget(
                            isLoading: appController.isLoadingObs.value,
                            onRefresh: () async {
                              try {
                                appController.isLoadingObs.value = true;
                                // await getData();
                                appController.isLoadingObs.value = false;
                              } catch (_) {
                                appController.isLoadingObs.value = false;
                              }
                            },
                          ),
                        ],
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
