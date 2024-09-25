import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/controller/app_controller.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/server_error_widget.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/task_tab_bar_view.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/tasks_tab_bar.dart';

class TasksScreen extends StatefulWidget {
  final String title;
  final List<TaskModel> tasksList;
  final bool? avoidTabBar;

  const TasksScreen({
    required this.title,
    required this.tasksList,
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
  late TextEditingController assignedSearchController;
  late TabController tabController;
  final UserController userController = Get.put(UserController());
  final TasksController tasksController = Get.put(TasksController());
  final FilterController filterController = Get.put(FilterController());

  final AppController appController = AppController();
  int animationCounter = 0;

  @override
  void initState() {
    tasksController.isDelegatedObs.value = true;
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
    assignedSearchController = TextEditingController();
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
    lottieController.dispose();
    taskSearchController.dispose();
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
            final allTasksList = widget.tasksList;
            final openTasksList = widget.tasksList
                .where((taskModel) => taskModel.status == Status.open)
                .toList();
            final inProgressTasksList = widget.tasksList
                .where((taskModel) => taskModel.status == Status.inProgress)
                .toList();
            final completedTasksList = widget.tasksList
                .where((taskModel) => taskModel.status == Status.completed)
                .toList();
            final overdueTasksList = widget.tasksList
                .where((taskModel) => taskModel.status == Status.overdue)
                .toList();

            return Column(
              children: [
                // filterSection(
                //   taskSearchController: taskSearchController,
                //   categorySearchController: categorySearchController,
                //   assignedSearchController: assignedSearchController,
                //   userController: userController,
                //   filterController: filterController,
                //   tasksController: tasksController,
                //   avoidFilterButton: true,
                // ),
                // SizedBox(height: 10.h),
                widget.avoidTabBar == true
                    ? const SizedBox()
                    : tasksTabBar(tabController: tabController),
                SizedBox(height: 10.h),
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
