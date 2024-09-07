import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/model/all_users_model.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/repository/tasks_repository.dart';

class AssignTaskController extends GetxController {
  final tasksRepository = TasksRepository();
  final assignTaskException = Rxn<Exception>();

  //Email is the key and Name is the value
  RxMap<String, String> assignToList = RxMap<String, String>();
  RxString selectedCategory = RxString('');

  RxList<AllUsersModel> assignToSearchList = RxList<AllUsersModel>();
  // Rxn<List<CategoryModel>> categorySearchList = Rxn<List<AllUsersModel>>();

//====================Date and Time====================//
  Rx<DateTime> taskDate = DateTime.now().obs;
  Rx<TimeOfDay> taskTime = TimeOfDay.now().obs;

//====================Reminder====================//
  RxInt reminderTime = DefaultReminder.defaultReminderTime.obs;
  Rx<String> reminderUnit = DefaultReminder.defaultReminderUnit.obs;

  RxList<Reminder> reminderList = RxList<Reminder>();

//====================Priority====================//
  Rx<String> taskPriority = TaskPriority.low.obs;

//====================Repeat Frequency Segment====================//
  RxBool shouldRepeatTask = false.obs;
  Rxn<RepeatFrequency> taskRepeatFrequency = Rxn<RepeatFrequency>();

//====================Voice Recorder====================//
  RxBool isRecording = false.obs;
  RxBool isPlaying = false.obs;
  RxString voiceRecordPath = ''.obs;
  RxInt voiceRecordPosition = 0.obs;

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

//====================Reset Reminder To Default====================//
  void resetReminderToDefault() {
    reminderTime.value = DefaultReminder.defaultReminderTime;
    reminderUnit.value = DefaultReminder.defaultReminderUnit;
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

  //====================Add user to AssignToList====================//
  void addToAssignToList({
    required String name,
    required String email,
  }) {
    assignToList.addAll({email: name});
  }

//====================Delete user from AssignToList====================//
  void removeFromAssignToList({
    required String email,
  }) {
    assignToList.remove(email);
  }

//====================Assign Task====================//
  Future<void> assignTask({
    required String title,
    required String description,
    // required List<dynamic>? attachments,
  }) async {
    try {
      final dueDate = DateTime(
        taskDate.value.year,
        taskDate.value.month,
        taskDate.value.day,
        taskTime.value.hour,
        taskTime.value.minute,
      );
      final dueDateString = dueDate.toUtc().toIso8601String();

      // final taskModel = TaskModel(
      //       title: title,
      //   description: description,
      //   category: selectedCategory.value,
      //   assignedTo: assignToList.keys.toList(),
      //   priority: taskPriority.value,
      //   dueDate: dueDateString,
      //   attachments: null,
      // );

      await tasksRepository.assignTask(
        title: title,
        description: description,
        category: selectedCategory.value,
        assignTo: assignToList.keys.toList(),
        priority: taskPriority.value,
        dueDate: dueDateString,
        repeatFrequency: taskRepeatFrequency.value?.enumToString(),
        repeatUntil: null,
        attachments: null,
      );
    } catch (e) {
      assignTaskException.value = e as Exception;
    }
  }
}

//====================create Date Map====================//
Map<int, bool> createDateMap() {
  Map<int, bool> datesMap = {};

  for (int i = 1; i <= totalDays; i++) {
    datesMap[i] = false;
  }

  return datesMap;
}

// //====================Repeat Frequency Enum to String====================//
// String? repeatFrequencyEnumToString({
//   required RepeatFrequency? repeatFrequency,
// }) {
//   switch (repeatFrequency) {
//     case RepeatFrequency.once:
//       return null;
//     case RepeatFrequency.daily:
//       return 'Daily';
//     case RepeatFrequency.weekly:
//       return 'Weekly';
//     case RepeatFrequency.monthly:
//       return 'Monthly';
//     default:
//       return null;
//   }
// }
