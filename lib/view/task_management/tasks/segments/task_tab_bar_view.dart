import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/task_card.dart';

Widget taskTabBarView({
  required List<TaskModel>? tasksList,
  required AnimationController lottieController,
}) {
  if (tasksList != null && tasksList.isNotEmpty) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: tasksList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: taskCard(
              lottieController: lottieController,
              taskModel: tasksList[index],
              isDelegated: false,
            ).animate().slideX(
                  begin: index.isEven ? -.4 : .4,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.elasticOut,
                ),
          );
        });
  } else if (tasksList == null) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  } else {
    return Column(
      children: [
        SizedBox(height: 70.h),
        Lottie.asset(
          'assets/lotties/empty_list_animation.json',
          width: 250.w,
        ),
      ],
    );
  }
}
