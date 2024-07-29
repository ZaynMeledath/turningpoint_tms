import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/filter_section.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/task_card.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/tasks_tab_bar.dart';

class DelegatedTasksScreen extends StatefulWidget {
  const DelegatedTasksScreen({super.key});

  @override
  State<DelegatedTasksScreen> createState() => _DelegatedTasksScreenState();
}

class _DelegatedTasksScreenState extends State<DelegatedTasksScreen>
    with TickerProviderStateMixin {
  late final AnimationController lottieController;
  late final TextEditingController taskSearchController;
  late final TextEditingController categorySearchController;
  late final TextEditingController assignedSearchController;
  late final TabController tabController;
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

    animateLottie();
    super.initState();
  }

  void animateLottie() async {
    animationCounter++;
    lottieController
      ..reset()
      ..forward();
    if (animationCounter < 2) {
      await Future.delayed(
        const Duration(milliseconds: 1500),
      );
    } else {
      await Future.delayed(
        const Duration(seconds: 15),
      );
    }
    getData();
    animateLottie();
  }

  Future<void> getData() async {
    await tasksController.getDelegatedTasks();
  }

  @override
  void dispose() {
    lottieController
      ..reset()
      ..dispose();
    taskSearchController.dispose();

    filterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(
          context: context,
          title: 'Delegated Tasks',
          implyLeading: false,
          profileAvatar: true,
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 106.h,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: filterSection(
                  taskSearchController: taskSearchController,
                  categorySearchController: categorySearchController,
                  assignedSearchController: assignedSearchController,
                  userController: userController,
                  filterController: filterController,
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
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: tasksController.myTasksListObs.value?.length ?? 0,
                (context, index) {
                  return Obx(() {
                    final delegatedTasksList =
                        tasksController.delegatedTasksListObs.value;
                    if (delegatedTasksList != null &&
                        delegatedTasksList.isNotEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        child: taskCard(
                          lottieController: lottieController,
                          taskModel: delegatedTasksList[index],
                          isDelegated: false,
                        ).animate().slideX(
                              begin: index.isEven ? -.4 : .4,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.elasticOut,
                            ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 65.h),
                ],
              ),
            ),
          ],
        )
        // .animate().slideY(
        //       begin: .2,
        //       duration: const Duration(milliseconds: 1200),
        //       curve: Curves.elasticOut,
        //     ),
        );
  }
}
