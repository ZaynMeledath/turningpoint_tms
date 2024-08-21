import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/filter_section.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/task_tab_bar_view.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/tasks_tab_bar.dart';

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

  void animateLottie() async {
    if (!lottieController.isDismissed) {
      try {
        animationCounter++;
        lottieController
          ..reset()
          ..forward();
        await Future.delayed(
          Duration(milliseconds: animationCounter < 2 ? 1500 : 15000),
        );
        animateLottie();
      } catch (e) {
        animateLottie();
      }
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
          context: context,
          title: 'Delegated Tasks',
          implyLeading: false,
          profileAvatar: true,
        ),
        body: Obx(
          () {
            final allDelegatedTasksList =
                tasksController.delegatedTasksListObs.value;
            final pendingDelegatedTasksList =
                tasksController.pendingDelegatedTaskList.value;
            final inProgressDelegatedTasksList =
                tasksController.inProgressDelegatedTaskList.value;
            final completedDelegatedTasksList =
                tasksController.completedDelegatedTaskList.value;
            final overdueDelegatedTasksList =
                tasksController.overdueDelegatedTaskList.value;
            return NestedScrollView(
              // physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    // expandedHeight: 106.h,
                    expandedHeight: 70.h,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      background: filterSection(
                        taskSearchController: taskSearchController,
                        categorySearchController: categorySearchController,
                        assignedSearchController: assignedSearchController,
                        userController: userController,
                        filterController: filterController,
                        isDelegated: true,
                      ),
                    ),
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: 50.h,
                    pinned: true,
                    backgroundColor: AppColor.scaffoldBackgroundColor,
                    surfaceTintColor: AppColor.scaffoldBackgroundColor,
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
              body: TabBarView(
                controller: tabController,
                children: [
                  taskTabBarView(
                    tasksList: allDelegatedTasksList,
                    lottieController: lottieController,
                    isDelegated: true,
                  ),
                  taskTabBarView(
                    tasksList: overdueDelegatedTasksList,
                    lottieController: lottieController,
                    isDelegated: true,
                  ),
                  taskTabBarView(
                    tasksList: pendingDelegatedTasksList,
                    lottieController: lottieController,
                    isDelegated: true,
                  ),
                  taskTabBarView(
                    tasksList: inProgressDelegatedTasksList,
                    lottieController: lottieController,
                    isDelegated: true,
                  ),
                  taskTabBarView(
                    tasksList: completedDelegatedTasksList,
                    lottieController: lottieController,
                    isDelegated: true,
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

        // .animate().slideY(
        //       begin: .2,
        //       duration: const Duration(milliseconds: 1200),
        //       curve: Curves.elasticOut,
        //     ),