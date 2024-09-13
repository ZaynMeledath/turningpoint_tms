import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:turning_point_tasks_app/controller/filter_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/shimmer_tasks_list_loading.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/task_card.dart';

Widget taskTabBarView({
  required List<TaskModel>? tasksList,
  required AnimationController lottieController,
  required TasksController tasksController,
  required FilterController filterController,
  required TextEditingController taskSearchController,
}) {
  if (tasksList != null && tasksList.isNotEmpty) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: tasksList.length,
      itemBuilder: (context, index) {
        final taskModel = tasksList[index];

        return Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            bottom: index == (tasksList.length - 1) ? 70.h : 10.h,
          ),
          child: taskCard(
            lottieController: lottieController,
            taskModel: taskModel,
            tasksController: tasksController,
          ).animate().slideX(
                begin: index.isEven ? -.4 : .4,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
              ),
        );
      },
    );
  } else if (tasksList == null) {
    return shimmerTasksListLoading();
  } else {
    return Column(
      children: [
        SizedBox(height: 100.h),
        Lottie.asset(
          'assets/lotties/empty_list_animation.json',
          width: 180.w,
        ),
      ],
    );
  }
}
