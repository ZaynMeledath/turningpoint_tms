import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';

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

  Rx<bool> scaleWeekly = false.obs;
  Rx<bool> scaleMonthly = false.obs;

  void resetDaysMap() {
    for (String i in daysMap.keys) {
      daysMap[i] = false;
    }
  }

  void resetDatesMap() {
    for (int i = 1; i <= totalDays; i++) {
      datesMap[i] = false;
    }
  }

  void repeatCheckBoxOnChanged(bool? value) {
    shouldRepeatTask.value = value ?? shouldRepeatTask.value;
    taskRepeatFrequency.value = null;
    scaleWeekly.value = false;
    resetDaysMap();
    resetDatesMap();
  }

  void repeatFrequencyOnChanged(RepeatFrequency? repeatFrequency) {
    taskRepeatFrequency.value = repeatFrequency;
    if (repeatFrequency == RepeatFrequency.weekly) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scaleWeekly.value = true;
        scaleMonthly.value = false;
      });
    } else if (repeatFrequency == RepeatFrequency.monthly) {
      Future.delayed(const Duration(milliseconds: 100), () {
        scaleMonthly.value = true;
        scaleWeekly.value = false;
      });
    } else {
      scaleMonthly.value = false;
      scaleWeekly.value = false;
    }
    resetDaysMap();
    resetDatesMap();
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

  for (int i = 1; i <= totalDays; i++) {
    datesMap[i] = false;
  }

  return datesMap;
}
