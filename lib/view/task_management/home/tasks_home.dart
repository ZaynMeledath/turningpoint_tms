import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';
import 'package:turning_point_tasks_app/view/task_management/assign_task/assign_task_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/my_tasks/my_tasks_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/home/tasks_dashboard.dart';

class TasksHome extends StatefulWidget {
  const TasksHome({super.key});

  @override
  State<TasksHome> createState() => _TasksHomeState();
}

class _TasksHomeState extends State<TasksHome> {
  int activeIndex = 0;

  final widgetList = [
    const TasksDashboard(),
    const TasksDashboard(),
    const MyTasksScreen(),
    const MyTasksScreen(),
  ];

  final titleIconMap = {
    'Dashboard': Icons.dashboard,
    'My Team': Icons.people_alt,
    'Delegated': Icons.double_arrow,
    'My Tasks': Icons.task_alt,
  };

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scaleFactor,
      child: Scaffold(
        extendBody: true,
        body: widgetList[activeIndex],
        floatingActionButton: SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(36, 196, 123, 1),
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
                  color: isActive
                      ? const Color.fromRGBO(36, 196, 123, 1)
                      : Colors.grey,
                ),
                Text(
                  titleIconMap.keys.elementAt(index),
                  style: TextStyle(
                    fontSize: 12.5,
                    color: isActive
                        ? const Color.fromRGBO(36, 196, 123, 1)
                        : Colors.grey,
                  ),
                )
              ],
            );
          },
          backgroundColor: Colors.black,
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
      ),
    );
  }
}
