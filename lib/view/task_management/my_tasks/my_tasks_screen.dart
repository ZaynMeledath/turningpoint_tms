import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';

part 'segments/task_card.dart';
part 'segments/card_action_button.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController lottieController;
  int animationCounter = 0;

  @override
  void initState() {
    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
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
        const Duration(milliseconds: 1000),
      );
    } else {
      await Future.delayed(
        const Duration(seconds: 15),
      );
    }

    animateLottie();
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'My Tasks',
        implyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 65,
              ),
              itemCount: 20,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: taskCard(lottieController: lottieController)
                    .animate()
                    .slideX(
                      begin: index % 2 == 0 ? -.5 : .5,
                      delay: const Duration(milliseconds: 1),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
