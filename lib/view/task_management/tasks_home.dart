import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/view/task_management/assign_task/assign_task_screen.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.code,
                size: 100,
              ),
              onPressed: () {
                Get.to(
                  () => const AssignTaskScreen(),
                  transition: Transition.downToUp,
                );
              },
            ),
            nameLetterAvatar(
              firstName: 'Zayn',
              lastName: 'Meledath',
              circleDiameter: 40,
            ),
          ],
        ),
      ),
    );
  }
}
