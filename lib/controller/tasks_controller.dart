import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';

class TasksController extends GetxController {
  Rx<DateTime> taskDate = DateTime.now().obs;
  Rx<TimeOfDay> taskTime = TimeOfDay.now().obs;

  Rx<TaskPriority> taskPriority = TaskPriority.low.obs;

  RxBool shouldRepeatTask = false.obs;

  Rxn<RepeatFrequency?> taskRepeatFrequency = Rxn<RepeatFrequency>();

  RxMap<String, bool> daysMap = {
    'Sun': false,
    'Mon': false,
    'Tue': false,
    'Wed': false,
    'Thu': false,
    'Fri': false,
    'Sat': false,
  }.obs;

  RxMap<int, bool> datesMap = createDateMap().obs;

  //To block the keyboard from popping up on dismissing the selectDate or selectTime dialog
  Rx<bool> isTitleAndDescriptionEnabled = true.obs;

  void resetDaysMap() {
    for (String i in daysMap.keys) {
      daysMap[i] = false;
    }
  }

  void resetDatesMap() {
    for (int i = 1; i <= 31; i++) {
      datesMap[i] = false;
    }
  }
}

enum RepeatFrequency {
  once,
  daily,
  weekly,
  monthly,
}

enum TaskPriority {
  low,
  medium,
  high,
}

Map<int, bool> createDateMap() {
  Map<int, bool> datesMap = {};

  for (int i = 1; i <= 31; i++) {
    datesMap[i] = false;
  }

  return datesMap;
}

final tasksController = Get.put(TasksController());
