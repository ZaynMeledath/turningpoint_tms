import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/controller/app_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/dialogs/show_generic_dialog.dart';
import 'package:turning_point_tasks_app/exceptions/tms_exceptions.dart';
import 'package:turning_point_tasks_app/model/all_users_model.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/repository/tasks_repository.dart';
import 'package:path_provider/path_provider.dart' as path;

class AssignTaskController extends GetxController {
  final tasksRepository = TasksRepository();
  final assignTaskException = Rxn<Exception>();

  final appController = Get.put(AppController());
  final tasksController = Get.put(TasksController());

  //Email is the key and Name is the value
  RxMap<String, AssignedTo> assignToMap = RxMap<String, AssignedTo>();
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
  RxBool isRecordingObs = false.obs;
  RxBool isPlayingObs = false.obs;
  RxString voiceRecordPathObs = ''.obs;
  RxString voiceRecordUrlObs = ''.obs;
  RxInt voiceRecordPositionObs = 0.obs;

  final attachmentsFileListObs = RxList<File>();
  final attachmentsListObs = RxList<Attachment>();

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
    required String phone,
  }) {
    assignToMap.addAll({
      email: AssignedTo(
        name: name,
        emailId: email,
        phone: phone,
      ),
    });
  }

//====================Delete user from AssignToList====================//
  void removeFromAssignToList({
    required String email,
  }) {
    assignToMap.remove(email);
  }

//====================Add File Attachments====================//
  Future<void> addFileAttachment() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        attachmentsListObs
            .add(Attachment()); //Used of show the loader on the attachment
        appController.isLoadingObs.value = true;
        attachmentsFileListObs.add(file);
        final url = await tasksRepository.uploadAttachment(file: file);
        attachmentsListObs
            .removeLast(); //The one used for the loader is removed
        final fileExtension = file.path.split('.').last;
        final fileType = fileExtension == 'pdf'
            ? 'pdf'
            : fileExtension == 'jpg' ||
                    fileExtension == 'jpeg' ||
                    fileExtension == 'png' ||
                    fileExtension == 'heif'
                ? 'image'
                : 'application';
        attachmentsListObs.add(
          Attachment(
            path: url,
            type: fileType,
          ),
        );
        appController.isLoadingObs.value = false;
      }
    } catch (_) {
      rethrow;
    }
  }

//====================Record Audio====================//
  Future<void> recordAudio({
    required AudioRecorder recorder,
    required AppController appController,
  }) async {
    try {
      if (isRecordingObs.value) {
        voiceRecordPathObs.value = await recorder.stop() ?? '';
        isRecordingObs.value = false;
        appController.isLoadingObs.value = true;
        voiceRecordUrlObs.value = await tasksRepository.uploadAttachment(
            file: File(voiceRecordPathObs.value));
        appController.isLoadingObs.value = false;
      } else {
        if (await recorder.hasPermission()) {
          final appDir = await path.getApplicationDocumentsDirectory();
          recorder.start(
            const RecordConfig(),
            path: '${appDir.path}/voice_note.wav',
          );
          isRecordingObs.value = true;
        }
        if (!await recorder.hasPermission()) {
          await Permission.microphone.request();
        }
        if (await Permission.microphone.isDenied) {
          showGenericDialog(
            iconPath: 'assets/lotties/microphone_animation.json',
            title: 'Permission Required!',
            content:
                'Please allow the microphone permission in settings to record audio',
            buttons: {
              'OK': null,
            },
          );
        }
      }
    } catch (_) {
      showGenericDialog(
        iconPath: 'assets/lotties/microphone_animation.json',
        title: 'Something went wrong',
        content: 'Something went wrong while recording audio',
        buttons: {
          'OK': null,
        },
      );
    }
  }

//====================Assign Task====================//
  Future<void> assignTask({
    required String title,
    required String description,
  }) async {
    final dueDate = DateTime(
      taskDate.value.year,
      taskDate.value.month,
      taskDate.value.day,
      taskTime.value.hour,
      taskTime.value.minute,
    );

    if (!dueDate.isAfter(DateTime.now())) {
      throw DateTimeErrorException();
    }

    final dueDateString = dueDate.toIso8601String();

    List<int>? days;

    switch (taskRepeatFrequency.value) {
      case RepeatFrequency.daily:
        break;

      case RepeatFrequency.weekly:
        days = weekDaysToIndex(
            weekDays: daysMap.keys.where((key) {
          return daysMap[key] == true;
        }).toList());
        break;

      case RepeatFrequency.monthly:
        days = datesMap.keys.where((key) => datesMap[key] == true).toList();
        break;

      default:
        break;
    }

    attachmentsListObs.add(Attachment(
      path: voiceRecordUrlObs.value,
      type: 'audio',
    ));

    final taskModel = TaskModel(
      title: title,
      description: description,
      category: selectedCategory.value,
      assignedTo: null, // will be added after creating taskModel
      priority: taskPriority.value,
      dueDate: shouldRepeatTask.value ? null : dueDateString,
      repeat: shouldRepeatTask.value
          ? Repeat(
              startDate:
                  dueDateString, //due date acts as start date when repeat is turned ON
              frequency: repeatFrequencyEnumToString(
                  repeatFrequency: taskRepeatFrequency.value),
              days: days)
          : null,
      attachments: attachmentsListObs,
    );

    //assignTo is added before fetching the assign Task API
    assignToMap.forEach(
      (email, assignedToModel) => taskModel.assignedTo == null
          ? taskModel.assignedTo = [assignedToModel]
          : taskModel.assignedTo!.add(assignedToModel),
    );

    try {
      await tasksRepository.assignTask(
        taskModel: taskModel,
      );
      await tasksController.getDelegatedTasks();
    } catch (e) {
      rethrow;
    }
  }

//====================Update Task====================//
  Future<void> updateTask({
    required TaskModel taskModel,
    required String title,
    required String description,
  }) async {
    final dueDate = DateTime(
      taskDate.value.year,
      taskDate.value.month,
      taskDate.value.day,
      taskTime.value.hour,
      taskTime.value.minute,
    );
    if (!dueDate.isAfter(DateTime.now())) {
      throw DateTimeErrorException();
    }
    final dueDateString = dueDate.toIso8601String();
    try {
      List<int>? days;

      switch (taskRepeatFrequency.value) {
        case RepeatFrequency.daily:
          break;

        case RepeatFrequency.weekly:
          days = weekDaysToIndex(
              weekDays: daysMap.keys.where((key) {
            return daysMap[key] == true;
          }).toList());
          break;

        case RepeatFrequency.monthly:
          days = datesMap.keys.where((key) => datesMap[key] == true).toList();
          break;

        default:
          break;
      }

      taskModel.title = title;
      taskModel.description = description;
      taskModel.category = selectedCategory.value;
      assignToMap.forEach(
        (email, assignedToModel) => taskModel.assignedTo == null
            ? taskModel.assignedTo = [assignedToModel]
            : taskModel.assignedTo?.add(assignedToModel),
      );

      taskModel.priority = taskPriority.value;
      taskModel.dueDate = shouldRepeatTask.value ? null : dueDateString;
      taskModel.repeat = shouldRepeatTask.value
          ? Repeat(
              startDate:
                  dueDateString, //due date acts as start date when repeat is turned ON
              frequency: repeatFrequencyEnumToString(
                  repeatFrequency: taskRepeatFrequency.value),
              days: days,
            )
          : null;
      taskModel.attachments =
          attachmentsListObs.isEmpty ? null : attachmentsListObs;

      await tasksRepository.updateTask(taskModel: taskModel);
      if (tasksController.isDelegatedObs.value == true) {
        await tasksController.getDelegatedTasks();
      } else if (tasksController.isDelegatedObs.value == false) {
        await tasksController.getMyTasks();
      } else {
        await tasksController.getAllTasks();
      }
    } catch (e) {
      rethrow;
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

//====================Week Days to Index====================//
List<int> weekDaysToIndex({required List<String> weekDays}) {
  final weekDaysIndexList = <int>[];
  for (String day in weekDays) {
    switch (day) {
      case 'Sun':
        weekDaysIndexList.add(0);
        break;
      case 'Mon':
        weekDaysIndexList.add(1);
        break;
      case 'Tue':
        weekDaysIndexList.add(2);
        break;
      case 'Wed':
        weekDaysIndexList.add(3);
        break;
      case 'Thu':
        weekDaysIndexList.add(4);
        break;
      case 'Fri':
        weekDaysIndexList.add(5);
        break;
      case 'Sat':
        weekDaysIndexList.add(6);
        break;
      default:
        break;
    }
  }
  return weekDaysIndexList;
}

//====================Repeat Frequency Enum to String====================//
String? repeatFrequencyEnumToString({
  required RepeatFrequency? repeatFrequency,
}) {
  switch (repeatFrequency) {
    case RepeatFrequency.once:
      return null;
    case RepeatFrequency.daily:
      return 'Daily';
    case RepeatFrequency.weekly:
      return 'Weekly';
    case RepeatFrequency.monthly:
      return 'Monthly';
    default:
      return null;
  }
}
