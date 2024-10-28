import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_reminders_list_dialog.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/server_error_widget.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/tasks_filter_section.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/task_tab_bar_view.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/tasks_tab_bar.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen>
    with TickerProviderStateMixin {
  late final AnimationController lottieController;
  late final TextEditingController taskSearchController;
  late final TextEditingController categorySearchController;
  late final TextEditingController assignedBySearchController;
  late final TabController tabController;
  final UserController userController = Get.put(UserController());
  final TasksController tasksController = Get.put(TasksController());
  final FilterController filterController = FilterController();
  final AppController appController = AppController();
  int animationCounter = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      tasksController.isDelegatedObs.value = false;
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
    assignedBySearchController = TextEditingController();

    getData();
    animateLottie();
    super.initState();
  }

  Future<void> getData() async {
    await tasksController.getMyTasks();
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
    tasksController.isDelegatedObs.value = null;
    appController.isLoadingObs.value = false;
    filterController.resetFilters();
    lottieController.dispose();
    taskSearchController.dispose();
    categorySearchController.dispose();
    assignedBySearchController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: myAppBar(
          title: 'My Tasks',
          implyLeading: false,
          profileAvatar: true,
          trailingIcons: [
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () {
                showRemindersListDialog();
              },
              icon: Icon(
                Icons.alarm,
                size: 24.w,
              ),
            ),
          ],
        ),
        body: Obx(
          () {
            final allTasksList = tasksController.myTasksListObs.value;
            final openTasksList = tasksController.openTaskList.value;
            final inProgressTasksList =
                tasksController.inProgressTaskList.value;
            final completedTasksList = tasksController.completedTaskList.value;
            final overdueTasksList = tasksController.overdueTaskList.value;
            return Column(
              children: [
                tasksFilterSection(
                    taskSearchController: taskSearchController,
                    categorySearchController: categorySearchController,
                    assignedBySearchController: assignedBySearchController,
                    assignedToSearchController: null,
                    userController: userController,
                    filterController: filterController,
                    tasksController: tasksController,
                    textFieldOnChanged: (value) {
                      if (tasksController.myTasksListObs.value != null) {
                        tasksController.myTasksListObs.value = tasksController
                            .myTasksListObs.value!
                            .where((taskModel) =>
                                taskModel.title!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                taskModel.description!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                            .toList();
                        tasksController.getMyTasks(filter: true);
                      }
                    }),
                SizedBox(height: 10.h),
                tasksTabBar(
                  tabController: tabController,
                  allTasksCount: allTasksList?.length,
                  overdueTasksCount: overdueTasksList?.length,
                  openTasksCount: openTasksList?.length,
                  inProgressTasksCount: inProgressTasksList?.length,
                  completedTasksCount: completedTasksList?.length,
                ),
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
