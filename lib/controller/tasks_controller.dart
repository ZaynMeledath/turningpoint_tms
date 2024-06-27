import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';

class TasksController extends GetxController {
  Rx<DateTime> taskDate = DateTime.now().obs;
  Rx<TimeOfDay> taskTime = TimeOfDay.now().obs;

  Rx<TaskPriority> taskPriority = TaskPriority.low.obs;

  RxBool shouldRepeatTask = false.obs;

  Rxn<RepeatFrequency> taskRepeatFrequency = Rxn<RepeatFrequency>();

  RxMap<String, bool> days = {
    'Sun': false,
    'Mon': false,
    'Tue': false,
    'Wed': false,
    'Thu': false,
    'Fri': false,
    'Sat': false,
  }.obs;

  //To block the keyboard from popping up on dismissing the selectDate or selectTime dialog
  Rx<bool> isTitleAndDescriptionEnabled = true.obs;
}

enum RepeatFrequency {
  daily,
  weekly,
  monthly,
}

enum TaskPriority {
  low,
  medium,
  high,
}

final tasksController = Get.put(TasksController());
