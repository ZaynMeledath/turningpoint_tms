import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';

part 'segments/task_card.dart';
part 'segments/card_action_button.dart';

class MyTasksScreen extends StatelessWidget {
  const MyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'My Tasks',
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              itemCount: 8,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: taskCard().animate().slideY(
                      begin: index % 2 == 0 ? -1 : 1,
                      delay: const Duration(milliseconds: 1),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
