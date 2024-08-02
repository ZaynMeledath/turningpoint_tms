import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/repository/tasks_repository.dart';

class TasksController extends GetxController {
  Rxn<List<TaskModel>?> myTasksListObs = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> delegatedTasksListObs = Rxn<List<TaskModel>>();

  Rxn<List<TaskModel>?> pendingTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> inProgressTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> completedTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> overdueTaskList = Rxn<List<TaskModel>>();

  final pendingDelegatedTaskList = <TaskModel>[].obs;
  final inProgressDelegatedTaskList = <TaskModel>[].obs;
  final completedDelegatedTaskList = <TaskModel>[].obs;
  final overdueDelegatedTaskList = <TaskModel>[].obs;

  final tasksRepository = TasksRepository();

//====================Date and Time====================//
  Rx<DateTime> taskDate = DateTime.now().obs;
  Rx<TimeOfDay> taskTime = TimeOfDay.now().obs;

//====================Priority====================//
  Rx<TaskPriority> taskPriority = TaskPriority.low.obs;

//====================Repeat Frequency Segment====================//
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

  //To animate the entry of the Weekly and Monthly frequencies segments
  Rx<bool> scaleWeekly = false.obs;
  Rx<bool> scaleMonthly = false.obs;

//====================Change Task Priority====================//
  void changeTaskPriority(int index) {
    switch (index) {
      case 0:
        taskPriority.value = TaskPriority.low;
        break;
      case 1:
        taskPriority.value = TaskPriority.medium;
        break;
      case 2:
        taskPriority.value = TaskPriority.high;
        break;
    }
  }

//====================Reset Days Map====================//
  void resetDaysMap() {
    for (String i in daysMap.keys) {
      daysMap[i] = false;
    }
  }

//====================Reset Dates Map====================//
  void resetDatesMap() {
    for (int i = 1; i <= totalDays; i++) {
      datesMap[i] = false;
    }
  }

//====================Repeat Check Box OnChanged Method====================//
  void repeatCheckBoxOnChanged(bool? value) {
    shouldRepeatTask.value = value ?? shouldRepeatTask.value;
    taskRepeatFrequency.value = null;
    scaleWeekly.value = false;
    resetDaysMap();
    resetDatesMap();
  }

//====================Repeat Frequency DropDown onChanged Method====================//
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

//====================Get My Tasks====================//
  Future<void> getMyTasks() async {
    try {
      myTasksListObs.value = await tasksRepository.getMyTasks();
      pendingTaskList.value =
          myTasksListObs.value!.where((item) => item.status == 'Open').toList();
      inProgressTaskList.value = myTasksListObs.value!
          .where((item) => item.status == Status.inProgress)
          .toList();
      completedTaskList.value = myTasksListObs.value!
          .where((item) => item.status == Status.completed)
          .toList();
      overdueTaskList.value = myTasksListObs.value!
          .where((item) =>
              item.isDelayed == true && item.status != Status.completed)
          .toList();
    } catch (e) {
      rethrow;
    }
  }

//====================Get Delegated Tasks====================//
  Future<void> getDelegatedTasks() async {
    try {
      delegatedTasksListObs.value = await tasksRepository.getDelegatedTasks();

      pendingDelegatedTaskList.value = delegatedTasksListObs.value!
          .where((item) => item.status == 'Open')
          .toList();
      inProgressDelegatedTaskList.value = delegatedTasksListObs.value!
          .where((item) => item.status == Status.inProgress)
          .toList();
      completedDelegatedTaskList.value = delegatedTasksListObs.value!
          .where((item) => item.status == Status.completed)
          .toList();
      overdueDelegatedTaskList.value = delegatedTasksListObs.value!
          .where((item) =>
              item.isDelayed == true && item.status != Status.completed)
          .toList();
    } catch (e) {
      rethrow;
    }
  }

//====================Filter Tasks List====================//
  // void filterList({required List<TaskModel> list}) {
  //   final filteredList = list.where(
  //     (element) {
  //       element.category =
  //     },
  //   );
  // }
}

//====================ENUMS====================//
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

//====================create Date Map====================//
Map<int, bool> createDateMap() {
  Map<int, bool> datesMap = {};

  for (int i = 1; i <= totalDays; i++) {
    datesMap[i] = false;
  }

  return datesMap;
}
