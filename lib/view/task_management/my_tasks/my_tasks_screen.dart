import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

part 'segments/filter_section.dart';
part 'segments/task_card.dart';
part 'segments/card_action_button.dart';
part 'dialogs/show_filter_bottom_sheet.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController lottieController;
  late final TextEditingController searchController;
  final userController = Get.put(UserController());
  int animationCounter = 0;

  @override
  void initState() {
    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    searchController = TextEditingController();
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: filterSection(
                searchController: searchController,
                userController: userController,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    left: 10,
                    right: 10,
                  ),
                  child: taskCard(lottieController: lottieController)
                      .animate()
                      .slideX(
                        begin: index % 2 == 0 ? -.5 : .5,
                        delay: const Duration(milliseconds: 1),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 65),
            ]),
          ),
        ],
      ),
    );
  }
}
