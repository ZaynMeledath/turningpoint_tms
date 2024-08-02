import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';

part 'segments/dashboard_status_overview_container.dart';
part 'segments/dashboard_status_overview_section.dart';
part 'segments/dashboard_tab_bar.dart';

class TasksDashboard extends StatefulWidget {
  const TasksDashboard({super.key});

  @override
  State<TasksDashboard> createState() => _TasksDashboardState();
}

class _TasksDashboardState extends State<TasksDashboard>
    with SingleTickerProviderStateMixin {
  final tasksController = Get.put(TasksController());
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
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
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  Text('Demo'),
                  Text('Demo'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
