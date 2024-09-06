import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/controller/app_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/utils/widgets/server_error_widget.dart';

part 'segments/dashboard_status_overview_container.dart';
part 'segments/dashboard_status_overview_section.dart';
part 'segments/dashboard_tab_bar.dart';
part 'segments/staff_wise_tab_bar_view.dart';
part 'segments/category_wise_tab_bar_view.dart';
part 'segments/shimmer_list_loading.dart';

class TasksDashboard extends StatefulWidget {
  const TasksDashboard({super.key});

  @override
  State<TasksDashboard> createState() => _TasksDashboardState();
}

class _TasksDashboardState extends State<TasksDashboard>
    with SingleTickerProviderStateMixin {
  final tasksController = Get.put(TasksController());
  final appController = Get.put(AppController());
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    getData();
    tabController.addListener(() {
      tasksController.dashboardTabIndexObs.value = tabController.index;
    });
    super.initState();
  }

  Future<void> getData() async {
    await tasksController.getAllUsersPerformance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Dashboard',
        implyLeading: false,
        profileAvatar: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            dashboardStatusOverviewSection(tasksController: tasksController),
            SizedBox(height: 18.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Text(
                  'Report',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 9.h),
            dashboardTabBar(tabController: tabController),
            Obx(
              () => Expanded(
                child: tasksController.allUsersPerformanceModelList.value !=
                            null &&
                        tasksController
                            .allUsersPerformanceModelList.value!.isNotEmpty
                    ? TabBarView(
                        controller: tabController,
                        children: [
                          staffWiseTabBarView(
                            tasksController: tasksController,
                          ),
                          categoryWiseTabBarView(
                              tasksController: tasksController),
                          const Text('Demo'),
                          const Text('Demo'),
                        ],
                      )
                    : tasksController.allUsersPerformanceModelList.value ==
                                null &&
                            tasksController.tasksException.value == null
                        ? shimmerListLoading()
                        : tasksController.tasksException.value != null
                            ? serverErrorWidget(
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
                              )
                            : Column(
                                children: [
                                  SizedBox(height: 50.h),
                                  Lottie.asset(
                                    'assets/lotties/empty_list_animation.json',
                                    width: 150.w,
                                  ),
                                ],
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
