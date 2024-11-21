import 'dart:developer';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_enable_notification_permission_dialog.dart';
import 'package:turningpoint_tms/model/user_model.dart';
import 'package:turningpoint_tms/preferences/app_preferences.dart';
import 'package:turningpoint_tms/view/task_management/assign_task/assign_task_screen.dart';
import 'package:turningpoint_tms/view/task_management/my_team/my_team_screen.dart';
import 'package:turningpoint_tms/view/task_management/tasks/delegated_tasks_screen.dart';
import 'package:turningpoint_tms/view/task_management/tasks/my_tasks_screen.dart';
import 'package:turningpoint_tms/view/task_management/home/tasks_dashboard.dart';

class TasksHome extends StatefulWidget {
  const TasksHome({super.key});

  @override
  State<TasksHome> createState() => _TasksHomeState();
}

class _TasksHomeState extends State<TasksHome> {
  int activeIndex = 1;
  StatefulWidget? activeWidget;
  UserModel? user;

  final tasksController = TasksController();
  final userController = Get.put(UserController());
  bool isAdminOrLeader = false;

  List<StatefulWidget> widgetList = [
    const MyTeamScreen(),
    const MyTasksScreen(),
  ];

  Map<String, IconData> titleIconMap = {
    'My Team': Icons.people_alt,
    'My Tasks': Icons.task_alt,
  };

  @override
  void initState() {
    user = getUserModelFromHive();
    final token = AppPreferences.getValueShared(AppConstants.authTokenKey);
    log('TOKEN : $token');
    getData();

    if (user != null &&
        (user!.role == Role.admin || user!.role == Role.teamLeader)) {
      isAdminOrLeader = true;
      activeIndex = 0;
      titleIconMap = {
        'Dashboard': Icons.dashboard,
        'My Team': Icons.people_alt,
        'Delegated': Icons.double_arrow,
        'My Tasks': Icons.task_alt,
      };

      widgetList = [
        const TasksDashboard(),
        const MyTeamScreen(),
        const DelegatedTasksScreen(),
        const MyTasksScreen(),
      ];
    }
    super.initState();
  }

  Future<void> getData() async {
    await userController.getUserById();
    await userController.getAssignTaskUsers();
  }

  void handleNotificationDialog() async {
    if (!await Permission.notification.isGranted) {
      showEnableNotificationPermissionDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    // handleNotificationDialog();
    return Scaffold(
      extendBody: true,
      body: activeWidget ?? widgetList[activeIndex],
      floatingActionButton: SizedBox(
        width: 50.w,
        height: 50.w,
        child: FloatingActionButton(
          backgroundColor: AppColors.themeGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () {
            if (isAdminOrLeader) {
              Get.to(
                () => const AssignTaskScreen(),
                transition: Transition.downToUp,
              );
            } else {
              activeWidget = const TasksDashboard();
              setState(() {});
            }
          },
          child: Icon(
            isAdminOrLeader ? Icons.add_task : Icons.dashboard,
            color: Colors.white.withOpacity(.85),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: 56.w,
        itemCount: titleIconMap.length,
        tabBuilder: (index, isActive) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                titleIconMap.values.elementAt(index),
                color: isActive && activeWidget == null
                    ? AppColors.themeGreen
                    : Colors.grey,
              ),
              Text(
                titleIconMap.keys.elementAt(index),
                style: TextStyle(
                  fontSize: 12.5.sp,
                  color: isActive && activeWidget == null
                      ? AppColors.themeGreen
                      : Colors.grey,
                ),
              )
            ],
          );
        },
        backgroundColor: const Color.fromARGB(255, 23, 29, 32),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        activeIndex: activeIndex,
        onTap: (index) {
          activeWidget = null;
          activeIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
