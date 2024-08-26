import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/view/task_management/assign_task/assign_task_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/my_team/my_team_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/delegated_tasks_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/my_tasks_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/home/tasks_dashboard.dart';

class TasksHome extends StatefulWidget {
  const TasksHome({super.key});

  @override
  State<TasksHome> createState() => _TasksHomeState();
}

class _TasksHomeState extends State<TasksHome> {
  int activeIndex = 3;

  final tasksController = TasksController();
  final userController = UserController();

  final widgetList = [
    const TasksDashboard(),
    const MyTeamScreen(),
    const DelegatedTasksScreen(),
    const MyTasksScreen(),
  ];

  final titleIconMap = {
    'Dashboard': Icons.dashboard,
    'My Team': Icons.people_alt,
    'Delegated': Icons.double_arrow,
    'My Tasks': Icons.task_alt,
  };

  @override
  void initState() {
    // getData();
    super.initState();
  }

  void getData() async {
    await userController.getAllTeamMembers();
    await tasksController.getMyTasks();
    await tasksController.getDelegatedTasks();
    await tasksController.getAllUsersPerformance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widgetList[activeIndex],
      floatingActionButton: SizedBox(
        width: 50.w,
        height: 50.w,
        child: FloatingActionButton(
          backgroundColor: AppColors.themeGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () {
            Get.to(
              () => const AssignTaskScreen(),
              transition: Transition.downToUp,
            );
          },
          child: Icon(
            Icons.add_task,
            color: Colors.white.withOpacity(.85),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: titleIconMap.length,
        tabBuilder: (index, isActive) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                titleIconMap.values.elementAt(index),
                color: isActive ? AppColors.themeGreen : Colors.grey,
              ),
              Text(
                titleIconMap.keys.elementAt(index),
                style: TextStyle(
                  fontSize: 12.5.sp,
                  color: isActive ? AppColors.themeGreen : Colors.grey,
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
          activeIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
