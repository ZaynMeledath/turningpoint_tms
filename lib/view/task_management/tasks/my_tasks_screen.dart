import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/app_controller.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/server_error_widget.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/filter_section.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/task_tab_bar_view.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/tasks_tab_bar.dart';

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
  late final TextEditingController assignedSearchController;
  late final TabController tabController;
  final UserController userController = Get.put(UserController());
  final TasksController tasksController = Get.put(TasksController());
  final FilterController filterController = FilterController();
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
    assignedSearchController = TextEditingController();

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
    lottieController.dispose();
    taskSearchController.dispose();
    categorySearchController.dispose();
    assignedSearchController.dispose();
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
          context: context,
          title: 'My Tasks',
          implyLeading: false,
          profileAvatar: true,
        ),
        body: Obx(
          () {
            final allTasksList = tasksController.myTasksListObs.value;
            final pendingTasksList = tasksController.pendingTaskList.value;
            final inProgressTasksList =
                tasksController.inProgressTaskList.value;
            final completedTasksList = tasksController.completedTaskList.value;
            final overdueTasksList = tasksController.overdueTaskList.value;
            return NestedScrollView(
              // physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 70.h,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      background: filterSection(
                        taskSearchController: taskSearchController,
                        categorySearchController: categorySearchController,
                        assignedSearchController: assignedSearchController,
                        userController: userController,
                        filterController: filterController,
                        tasksController: tasksController,
                      ),
                    ),
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: 50.h,
                    pinned: true,
                    backgroundColor: AppColors.scaffoldBackgroundColor,
                    surfaceTintColor: AppColors.scaffoldBackgroundColor,
                    flexibleSpace: FlexibleSpaceBar(
                      background: tasksTabBar(tabController: tabController),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 10.h),
                    ]),
                  ),
                ];
              },
              body: tasksController.tasksException.value == null
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 65.h),
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          taskTabBarView(
                            tasksList: allTasksList,
                            lottieController: lottieController,
                            tasksController: tasksController,
                          ),
                          taskTabBarView(
                            tasksList: overdueTasksList,
                            lottieController: lottieController,
                            tasksController: tasksController,
                          ),
                          taskTabBarView(
                            tasksList: pendingTasksList,
                            lottieController: lottieController,
                            tasksController: tasksController,
                          ),
                          taskTabBarView(
                            tasksList: inProgressTasksList,
                            lottieController: lottieController,
                            tasksController: tasksController,
                          ),
                          taskTabBarView(
                            tasksList: completedTasksList,
                            lottieController: lottieController,
                            tasksController: tasksController,
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
            );
          },
        ),
      ),
    );
  }
}
