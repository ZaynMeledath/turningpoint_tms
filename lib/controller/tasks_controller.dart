import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';

class TasksController extends GetxController {
  Rx<DateTime> taskDate = DateTime.now().obs;
  Rx<TimeOfDay> taskTime = TimeOfDay.now().obs;

  Rx<TaskPriority> taskPriority = TaskPriority.low.obs;

  Rx<bool> shouldRepeatTask = false.obs;

  Rx<RepeatFrequency?> taskRepeatFrequency = null.obs;

  //To block the keyboard from popping up on dismissing the selectDate or selectTime dialog
  Rx<bool> isTitleAndDescriptionEnabled = true.obs;
}

final tasksController = Get.put(TasksController());
