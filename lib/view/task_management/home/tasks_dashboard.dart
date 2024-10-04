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
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/extensions/string_extensions.dart';
import 'package:turning_point_tasks_app/model/all_categories_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/all_users_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/delegated_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/my_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/utils/widgets/server_error_widget.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/home/tasks_screen.dart';

part 'segments/dashboard_status_overview_container.dart';
part 'segments/dashboard_status_overview_section.dart';
part 'segments/shimmer_list_loading.dart';
part 'segments/dashboard_tab_bar.dart';
part 'segments/staff_wise_tab_bar_view.dart';
part 'segments/category_wise_tab_bar_view.dart';
part 'segments/my_report_tab_bar_view.dart';
part 'segments/delegated_report_tab_bar_view.dart';
part 'segments/tasks_status_counter_section.dart';

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

  final staffWiseSearchController = TextEditingController();
  final categoryWiseSearchController = TextEditingController();
  final myReportSearchController = TextEditingController();
  final delegatedSearchController = TextEditingController();

  UserModel? userModel;
  bool isAdminOrLeader = false;

  @override
  void initState() {
    userModel = getUserModelFromHive();
    isAdminOrLeader =
        userModel?.role == Role.admin || userModel?.role == Role.teamLeader;
    tabController = TabController(
      length: isAdminOrLeader ? 4 : 1,
      vsync: this,
    );
    getData();
    tabController.addListener(() {
      tasksController.dashboardTabIndexObs.value = tabController.index;
    });
    super.initState();
  }

  Future<void> getData() async {
    await tasksController.getMyTasks();
    await tasksController.getDelegatedTasks();
    if (isAdminOrLeader) {
      await tasksController.getMyPerformanceReport();
      await tasksController.getDelegatedPerformanceReport();
      await tasksController.getAllTasks();
      await tasksController.getAllUsersPerformanceReport();
      await tasksController.getAllCategoriesPerformanceReport();
    } else {
      await tasksController.getMyPerformanceReport();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: myAppBar(
          title: 'Dashboard',
          implyLeading: false,
          profileAvatar: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: dashboardStatusOverviewSection(
                tasksController: tasksController,
                isAdminOrLeader: isAdminOrLeader,
              ),
            ),
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
            dashboardTabBar(
              tabController: tabController,
              isAdminOrLeader: isAdminOrLeader,
            ),
            Obx(
              () => Expanded(
                child: tasksController.tasksException.value == null
                    ? isAdminOrLeader
                        ? TabBarView(
                            controller: tabController,
                            children: [
                              staffWiseTabBarView(
                                tasksController: tasksController,
                                staffSearchController:
                                    staffWiseSearchController,
                              ),
                              categoryWiseTabBarView(
                                tasksController: tasksController,
                                categorySearchController:
                                    categoryWiseSearchController,
                              ),
                              myReportTabBarView(
                                tasksController: tasksController,
                                myReportSearchController:
                                    myReportSearchController,
                              ),
                              delegatedReportTabBarView(
                                tasksController: tasksController,
                                delegatedSearchController:
                                    delegatedSearchController,
                              ),
                            ],
                          )
                        : TabBarView(
                            controller: tabController,
                            children: [
                              myReportTabBarView(
                                tasksController: tasksController,
                                myReportSearchController:
                                    myReportSearchController,
                              ),
                            ],
                          )
                    : Column(
                        children: [
                          SizedBox(height: 50.h),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
