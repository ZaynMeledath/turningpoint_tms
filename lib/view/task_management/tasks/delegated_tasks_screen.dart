import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/server_error_widget.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/tasks_filter_section.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/task_tab_bar_view.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/tasks_tab_bar.dart';

class DelegatedTasksScreen extends StatefulWidget {
  const DelegatedTasksScreen({super.key});

  @override
  State<DelegatedTasksScreen> createState() => _DelegatedTasksScreenState();
}

class _DelegatedTasksScreenState extends State<DelegatedTasksScreen>
    with TickerProviderStateMixin {
  late AnimationController lottieController;
  late TextEditingController taskSearchController;
  late TextEditingController categorySearchController;
  late TextEditingController assignedSearchController;
  late TabController tabController;
  final UserController userController = Get.put(UserController());
  final TasksController tasksController = Get.put(TasksController());
  late FilterController filterController = FilterController();
  final AppController appController = AppController();
  int animationCounter = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tasksController.isDelegatedObs.value = true;
    });
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
    getData();
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

  Future<void> getData() async {
    try {
      await tasksController.getDelegatedTasks();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
    tasksController.isDelegatedObs.value = null;
    filterController.resetFilters();
    lottieController.dispose();
    taskSearchController.dispose();
    filterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: myAppBar(
          title: 'Delegated Tasks',
          implyLeading: false,
          profileAvatar: true,
        ),
        body: Obx(
          () {
            final allDelegatedTasksList =
                tasksController.delegatedTasksListObs.value;
            final openDelegatedTasksList =
                tasksController.openDelegatedTaskList.value;
            final inProgressDelegatedTasksList =
                tasksController.inProgressDelegatedTaskList.value;
            final completedDelegatedTasksList =
                tasksController.completedDelegatedTaskList.value;
            final overdueDelegatedTasksList =
                tasksController.overdueDelegatedTaskList.value;
            return Column(
              // physics: const BouncingScrollPhysics(),
              children: [
                tasksFilterSection(
                    taskSearchController: taskSearchController,
                    categorySearchController: categorySearchController,
                    assignedSearchController: assignedSearchController,
                    userController: userController,
                    filterController: filterController,
                    tasksController: tasksController,
                    textFieldOnChanged: (value) {
                      if (tasksController.delegatedTasksListObs.value != null) {
                        tasksController.delegatedTasksListObs.value =
                            tasksController.delegatedTasksListObs.value!
                                .where((taskModel) =>
                                    taskModel.title!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()) ||
                                    taskModel.description!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                .toList();
                        tasksController.getDelegatedTasks(filter: true);
                      }
                    }),
                SizedBox(height: 10.h),
                tasksTabBar(tabController: tabController),
                SizedBox(height: 10.h),
                tasksController.tasksException.value == null
                    ? Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            taskTabBarView(
                              tasksList: allDelegatedTasksList,
                              lottieController: lottieController,
                              tasksController: tasksController,
                              taskSearchController: taskSearchController,
                            ),
                            taskTabBarView(
                              tasksList: overdueDelegatedTasksList,
                              lottieController: lottieController,
                              tasksController: tasksController,
                              taskSearchController: taskSearchController,
                            ),
                            taskTabBarView(
                              tasksList: openDelegatedTasksList,
                              lottieController: lottieController,
                              tasksController: tasksController,
                              taskSearchController: taskSearchController,
                            ),
                            taskTabBarView(
                              tasksList: inProgressDelegatedTasksList,
                              lottieController: lottieController,
                              tasksController: tasksController,
                              taskSearchController: taskSearchController,
                            ),
                            taskTabBarView(
                              tasksList: completedDelegatedTasksList,
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
                                await getData();
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
