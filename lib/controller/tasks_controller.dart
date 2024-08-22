import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/model/all_users_model.dart';
import 'package:turning_point_tasks_app/model/all_users_performance_model.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/repository/tasks_repository.dart';

class TasksController extends GetxController {
  Rxn<List<TaskModel>?> myTasksListObs = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> delegatedTasksListObs = Rxn<List<TaskModel>>();

  //Email is the key and Name is the value
  RxMap<String, String> assignToMap = RxMap<String, String>();
  // Rxn<List<AllUsersModel>> categoryList = Rxn<List<AllUsersModel>>();

  RxList<AllUsersModel> assignToSearchList = RxList<AllUsersModel>();
  // Rxn<List<CategoryModel>> categorySearchList = Rxn<List<AllUsersModel>>();

  Rxn<List<TaskModel>?> pendingTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> inProgressTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> completedTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> overdueTaskList = Rxn<List<TaskModel>>();

  Rxn<List<TaskModel>?> pendingDelegatedTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> inProgressDelegatedTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> completedDelegatedTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> overdueDelegatedTaskList = Rxn<List<TaskModel>>();

  final completedOnTimeMyTasksList = <TaskModel>[].obs;
  final completedDelayedMyTasksList = <TaskModel>[].obs;
  final completedOnTimeDelegatedTasksList = <TaskModel>[].obs;
  final completedDelayedDelegatedTasksList = <TaskModel>[].obs;

  final tasksException = Rxn<Exception>();

  final tasksRepository = TasksRepository();

  Rxn<List<AllUsersPerformanceModel>> allUsersPerformanceModelList =
      Rxn<List<AllUsersPerformanceModel>>();

//====================Date and Time====================//
  Rx<DateTime> taskDate = DateTime.now().obs;
  Rx<TimeOfDay> taskTime = TimeOfDay.now().obs;

//====================Priority====================//
  Rx<String> taskPriority = TaskPriority.low.obs;

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
      tasksException.value = null;
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

      completedOnTimeMyTasksList.value = myTasksListObs.value!
          .where((taskModel) =>
              taskModel.status == Status.completed &&
              taskModel.isDelayed != true)
          .toList();
      completedDelayedMyTasksList.value = myTasksListObs.value!
          .where((taskModel) =>
              taskModel.status == Status.completed &&
              taskModel.isDelayed == true)
          .toList();
    } catch (e) {
      tasksException.value = e as Exception;
    }
  }

//====================Get Delegated Tasks====================//
  Future<void> getDelegatedTasks() async {
    try {
      tasksException.value = null;
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

      completedOnTimeDelegatedTasksList.value = delegatedTasksListObs.value!
          .where((taskModel) =>
              taskModel.status == Status.completed &&
              taskModel.isDelayed != true)
          .toList();
      completedDelayedDelegatedTasksList.value = delegatedTasksListObs.value!
          .where((taskModel) =>
              taskModel.status == Status.completed &&
              taskModel.isDelayed == true)
          .toList();
    } catch (e) {
      tasksException.value = e as Exception;
      return;
    }
  }

//====================Assign Task====================//
  Future<void> assignTask({
    required String title,
    required String description,
    // required String category,
    // required String assignTo,
    // required String priority,
    // required String dueDate,
    // required String? reminderFrequency,
    // required String? reminderStartDate,
    // required String? repeatFrequency,
    // required String? repeatUntil,
    // required List<dynamic>? attachments,
  }) async {
    final dueDate = DateTime(
      taskDate.value.year,
      taskDate.value.month,
      taskDate.value.day,
      taskTime.value.hour,
      taskTime.value.minute,
    );
    final dueDateString = dueDate.toUtc().toIso8601String();
    await tasksRepository.assignTask(
      title: title,
      description: description,
      category: 'IT',
      assignTo: assignToMap.keys.first,
      priority: taskPriority.value,
      dueDate: dueDateString,
      reminderFrequency: null,
      reminderStartDate: null,
      repeatFrequency: null,
      repeatUntil: null,
      attachments: null,
    );
  }

//====================Add user to AssignToList====================//
  void addToAssignToList({
    required String name,
    required String email,
  }) {
    assignToMap.addAll({email: name});
  }

//====================Delete user from AssignToList====================//
  void removeFromAssignToList({
    required String email,
  }) {
    assignToMap.remove(email);
  }

//====================Get All Users Performance====================//
  Future<void> getAllUsersPerformance() async {
    try {
      allUsersPerformanceModelList.value =
          await tasksRepository.getAllUsersPerformanceReport();
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

class TaskPriority {
  static const low = 'Low';
  static const medium = 'Medium';
  static const high = 'High';
}

//====================create Date Map====================//
Map<int, bool> createDateMap() {
  Map<int, bool> datesMap = {};

  for (int i = 1; i <= totalDays; i++) {
    datesMap[i] = false;
  }

  return datesMap;
}
