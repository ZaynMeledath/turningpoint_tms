import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/model/tasks_model.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/server_error_widget.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/task_tab_bar_view.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/tasks_filter_section.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/tasks_tab_bar.dart';

class TasksScreen extends StatefulWidget {
  final String title;
  final TasksListCategory tasksListCategory;
  final String? email;
  final String? category;
  final bool? avoidTabBar;

  const TasksScreen({
    required this.title,
    required this.tasksListCategory,
    this.email,
    this.category,
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

  int tabCount = 1;

  List<TaskModel> allTasksList = [];
  List<TaskModel> openTasksList = [];
  List<TaskModel> inProgressTasksList = [];
  List<TaskModel> completedTasksList = [];
  List<TaskModel> overdueTasksList = [];

  final AppController appController = AppController();
  int animationCounter = 0;

  @override
  void initState() {
    if (widget.tasksListCategory == TasksListCategory.staffWise ||
        widget.tasksListCategory == TasksListCategory.categoryWise ||
        widget.tasksListCategory == TasksListCategory.myReport ||
        widget.tasksListCategory == TasksListCategory.delegatedReport) {
      tabCount = 5;
    }

    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    tabController = TabController(
      length: tabCount,
      vsync: this,
    );
    taskSearchController = TextEditingController();
    categorySearchController = TextEditingController();
    assignedBySearchController = TextEditingController();
    assignedToSearchController = TextEditingController();

    tasksListFilter();
    ever(tasksController.allTasksListObs, (tasksList) {
      tasksListFilter();
    });

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

  void tasksListFilter() {
    switch (widget.tasksListCategory) {
      case TasksListCategory.overdue:
        tasksController.addToDashboardTasksList(
            tasksList: tasksController.allTasksListObs.value!
                .where((taskModel) =>
                    taskModel.isDelayed == true &&
                    taskModel.status != Status.completed)
                .toList());
        break;
      case TasksListCategory.open:
        tasksController.addToDashboardTasksList(
            tasksList: tasksController.allTasksListObs.value!
                .where((taskModel) => taskModel.status == Status.open)
                .toList());
        break;
      case TasksListCategory.inProgress:
        tasksController.addToDashboardTasksList(
            tasksList: tasksController.allTasksListObs.value!
                .where((taskModel) => taskModel.status == Status.inProgress)
                .toList());
        break;
      case TasksListCategory.completed:
        tasksController.addToDashboardTasksList(
            tasksList: tasksController.allTasksListObs.value!
                .where((taskModel) => taskModel.status == Status.completed)
                .toList());
        break;
      case TasksListCategory.onTime:
        tasksController.addToDashboardTasksList(
            tasksList: tasksController.allTasksListObs.value!
                .where((taskModel) =>
                    taskModel.status == Status.completed &&
                    taskModel.isDelayed != true)
                .toList());
        break;
      case TasksListCategory.delayed:
        tasksController.addToDashboardTasksList(
            tasksList: tasksController.allTasksListObs.value!
                .where((taskModel) =>
                    taskModel.status == Status.completed &&
                    taskModel.isDelayed == true)
                .toList());
        break;
      case TasksListCategory.staffWise:
        tasksController.addToDashboardTasksList(
            tasksList:
                tasksController.allTasksListObs.value!.where((taskModel) {
          return taskModel.assignedTo?.first.emailId.toString() == widget.email;
        }).toList());
        break;
      case TasksListCategory.categoryWise:
        tasksController.addToDashboardTasksList(
            tasksList: tasksController.allTasksListObs.value!
                .where((taskModel) => taskModel.category == widget.category)
                .toList());
        break;
      case TasksListCategory.myReport:
        tasksController.addToDashboardTasksList(
            tasksList: tasksController.myTasksListObs.value!
                .where((taskModel) => taskModel.category == widget.category)
                .toList());
        break;
      case TasksListCategory.delegatedReport:
        tasksController.addToDashboardTasksList(
            tasksList: tasksController.delegatedTasksListObs.value!
                .where((item) => item.assignedTo?.first.emailId == widget.email)
                .toList());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(
        () {
          allTasksList = tasksController.dashboardTasksListObs;
          if (widget.avoidTabBar != true) {
            openTasksList = tasksController.dashboardTasksListObs
                .where((taskModel) => taskModel.status == Status.open)
                .toList();
            inProgressTasksList = tasksController.dashboardTasksListObs
                .where((taskModel) => taskModel.status == Status.inProgress)
                .toList();
            completedTasksList = tasksController.dashboardTasksListObs
                .where((taskModel) => taskModel.status == Status.completed)
                .toList();
            overdueTasksList = tasksController.dashboardTasksListObs
                .where((taskModel) =>
                    taskModel.isDelayed == true &&
                    taskModel.status != Status.completed)
                .toList();
          }
          return Scaffold(
            appBar: myAppBar(
              title:
                  '${widget.title} - ${tasksController.dashboardTasksListObs.length}',
              implyLeading: true,
              profileAvatar: true,
            ),
            body: Column(
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
                          tasksController.tempDashboardTasksListObs
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
                        child: tabCount == 5
                            ? TabBarView(
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
                              )
                            : TabBarView(
                                controller: tabController,
                                children: [
                                  taskTabBarView(
                                    tasksList: allTasksList,
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
            ),
          );
        },
      ),
    );
  }
}
