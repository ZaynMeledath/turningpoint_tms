import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/exceptions/tms_exceptions.dart';
import 'package:turningpoint_tms/model/all_users_model.dart';
import 'package:turningpoint_tms/model/tasks_model.dart';
import 'package:turningpoint_tms/repository/tasks_repository.dart';
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
  Rx<DateTime> taskDueOrStartDate = DateTime.now().obs;
  Rx<TimeOfDay> taskDueOrStartTime = TimeOfDay.now().obs;
  Rxn<DateTime> taskEndDate = Rxn<DateTime>();
  Rxn<TimeOfDay> taskEndTime = Rxn<TimeOfDay>();

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

  final attachmentsListObs = RxList<Attachment>();

  final RxBool showAssignToEmptyErrorTextObs = false.obs;
  final RxBool showCategoryEmptyErrorTextObs = false.obs;
  final RxBool showDueOrStartDateErrorTextObs = false.obs;
  final RxBool showEndDateErrorTextObs = false.obs;
  final RxBool showRepeatFrequencyErrorTextObs = false.obs;
  final RxBool showWeeklyFrequencyErrorTextObs = false.obs;
  final RxBool showMonthlyFrequencyErrorTextObs = false.obs;

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
    showRepeatFrequencyErrorTextObs.value = false;
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
        final url = await tasksRepository.uploadAttachment(file: file);
        attachmentsListObs
            .removeLast(); //The one used for the loader is removed
        final fileExtension = file.path.split('.').last;
        final fileType = fileExtension == 'mp4' ||
                fileExtension == 'mkv' ||
                fileExtension == 'hevc'
            ? TaskFileType.video
            : fileExtension == 'jpg' ||
                    fileExtension == 'jpeg' ||
                    fileExtension == 'png' ||
                    fileExtension == 'heif'
                ? TaskFileType.image
                : TaskFileType.others;
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
    try {
      //To convert to Local
      final dueOrStartDate = DateTime(
        taskDueOrStartDate.value.year,
        taskDueOrStartDate.value.month,
        taskDueOrStartDate.value.day,
        taskDueOrStartTime.value.hour,
        taskDueOrStartTime.value.minute,
      );

      final endDate = taskEndDate.value != null
          ? DateTime(
              taskEndDate.value!.year,
              taskEndDate.value!.month,
              taskEndDate.value!.day,
              taskEndDate.value!.hour,
              taskEndDate.value!.minute,
            )
          : null;

      if (dueOrStartDate.isBefore(DateTime.now()) ||
          dueOrStartDate.isAtSameMomentAs(DateTime.now())) {
        throw DueOrStartDateTimeErrorException();
      }

      if (endDate != null &&
          (endDate.isBefore(DateTime.now()) ||
              endDate.isAtSameMomentAs(DateTime.now())) &&
          endDate.isBefore(dueOrStartDate)) {
        throw EndDateTimeErrorException();
      }

      if (shouldRepeatTask.value) {
        if (taskRepeatFrequency.value == null) {
          throw RepeatFrequencyNullException();
        }
      }

      final dueOrStartDateString = dueOrStartDate.toIso8601String();
      final endDateString = endDate?.toIso8601String();

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

      final List<Attachment> taskAttachments = [...attachmentsListObs];

      if (voiceRecordUrlObs.value.isNotEmpty) {
        taskAttachments.add(
          Attachment(
            path: voiceRecordUrlObs.value,
            type: TaskFileType.audio,
          ),
        );
      }

      final taskModel = TaskModel(
        title: title,
        description: description,
        category: selectedCategory.value,
        assignedTo: null, // will be added after creating taskModel
        priority: taskPriority.value,
        dueDate: shouldRepeatTask.value ? null : dueOrStartDateString,
        repeat: shouldRepeatTask.value && taskRepeatFrequency.value != null
            ? Repeat(
                startDate:
                    dueOrStartDateString, //due date acts as start date when repeat is turned ON
                frequency: repeatFrequencyEnumToString(
                    repeatFrequency: taskRepeatFrequency.value),
                days: days,
                endDate: endDateString,
                occurrenceCount: 0,
              )
            : null,
        attachments: taskAttachments,
      );

      //assignTo is added before fetching the assign Task API
      assignToMap.forEach(
        (email, assignedToModel) => taskModel.assignedTo == null
            ? taskModel.assignedTo = [assignedToModel]
            : taskModel.assignedTo!.add(assignedToModel),
      );

      await tasksRepository.assignTask(
        taskModel: taskModel,
      );
      if (tasksController.isDelegatedObs.value == true) {
        await tasksController.getDelegatedTasks();
        unawaited(tasksController.getMyTasks());
        unawaited(tasksController.getAllTasks());
      } else if (tasksController.isDelegatedObs.value == false) {
        await tasksController.getMyTasks();
        unawaited(tasksController.getDelegatedTasks());
        unawaited(tasksController.getAllTasks());
      } else {
        await tasksController.getAllTasks();
        unawaited(tasksController.getMyTasks());
        unawaited(tasksController.getDelegatedTasks());
      }
      unawaited(tasksController.getAllUsersPerformanceReport());
      unawaited(tasksController.getMyPerformanceReport());
      unawaited(tasksController.getDelegatedPerformanceReport());
      unawaited(tasksController.getAllTasks());
      unawaited(tasksController.getAllCategoriesPerformanceReport());
    } catch (e) {
      rethrow;
    }
  }

//====================Update Task====================//
  Future<void> updateTask({
    required TaskModel taskModel,
  }) async {
    try {
      //To convert to Local
      final dueOrStartDate = DateTime(
        taskDueOrStartDate.value.year,
        taskDueOrStartDate.value.month,
        taskDueOrStartDate.value.day,
        taskDueOrStartTime.value.hour,
        taskDueOrStartTime.value.minute,
      );

      final endDate = taskEndDate.value != null
          ? DateTime(
              taskEndDate.value!.year,
              taskEndDate.value!.month,
              taskEndDate.value!.day,
              taskEndDate.value!.hour,
              taskEndDate.value!.minute,
            )
          : null;

      if (dueOrStartDate.isBefore(DateTime.now()) ||
          dueOrStartDate.isAtSameMomentAs(DateTime.now())) {
        throw DueOrStartDateTimeErrorException();
      }

      if (endDate != null &&
          (endDate.isBefore(DateTime.now()) ||
              endDate.isAtSameMomentAs(DateTime.now())) &&
          endDate.isBefore(dueOrStartDate)) {
        throw EndDateTimeErrorException();
      }

      if (shouldRepeatTask.value) {
        if (taskRepeatFrequency.value == null) {
          throw RepeatFrequencyNullException();
        }
      }

      final dueOrStartDateString = dueOrStartDate.toIso8601String();
      final endDateString = endDate?.toIso8601String();

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

      final List<Attachment> taskAttachments = [...attachmentsListObs];

      if (voiceRecordUrlObs.value.isNotEmpty) {
        taskAttachments.add(
          Attachment(
            path: voiceRecordUrlObs.value,
            type: TaskFileType.audio,
          ),
        );
      }
      taskModel.category = selectedCategory.value;
      assignToMap.forEach(
        (email, assignedToModel) => taskModel.assignedTo == null
            ? taskModel.assignedTo = [assignedToModel]
            : taskModel.assignedTo?.add(assignedToModel),
      );

      taskModel.priority = taskPriority.value;
      taskModel.dueDate = shouldRepeatTask.value ? null : dueOrStartDateString;
      taskModel.repeat = shouldRepeatTask.value
          ? Repeat(
              startDate:
                  dueOrStartDateString, //due date acts as start date when repeat is turned ON
              frequency: repeatFrequencyEnumToString(
                  repeatFrequency: taskRepeatFrequency.value),
              days: days,
              endDate: endDateString,
              occurrenceCount: 0,
            )
          : null;
      taskModel.attachments =
          (attachmentsListObs.isEmpty && voiceRecordUrlObs.value.isEmpty)
              ? null
              : taskAttachments;

      await tasksRepository.updateTask(taskModel: taskModel);
      if (tasksController.isDelegatedObs.value == true) {
        await tasksController.getDelegatedTasks();
        unawaited(tasksController.getMyTasks());
        unawaited(tasksController.getAllTasks());
      } else if (tasksController.isDelegatedObs.value == false) {
        await tasksController.getMyTasks();
        unawaited(tasksController.getDelegatedTasks());
        unawaited(tasksController.getAllTasks());
      } else {
        await tasksController.getAllTasks();
        unawaited(tasksController.getMyTasks());
        unawaited(tasksController.getDelegatedTasks());
      }
      unawaited(tasksController.getAllUsersPerformanceReport());
      unawaited(tasksController.getMyPerformanceReport());
      unawaited(tasksController.getDelegatedPerformanceReport());
      unawaited(tasksController.getAllTasks());
      unawaited(tasksController.getAllCategoriesPerformanceReport());
      // for (int i = 0; i < tasksController.dashboardTasksListObs.length; i++) {
      //   if (tasksController.dashboardTasksListObs[i].id == taskModel.id) {
      //     tasksController.dashboardTasksListObs[i] = tasksController
      //         .allTasksListObs.value!
      //         .firstWhere((item) => item.id == taskModel.id);
      //     return;
      //   }
      // }
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
  final weekDaysMap = {
    'Sun': 0,
    'Mon': 1,
    'Tue': 2,
    'Wed': 3,
    'Thu': 4,
    'Fri': 5,
    'Sat': 6,
  };
  for (String day in weekDays) {
    weekDaysIndexList.add(weekDaysMap[day]!);
    // switch (day) {
    //   case 'Sun':
    //     weekDaysIndexList.add(0);
    //     break;
    //   case 'Mon':
    //     weekDaysIndexList.add(1);
    //     break;
    //   case 'Tue':
    //     weekDaysIndexList.add(2);
    //     break;
    //   case 'Wed':
    //     weekDaysIndexList.add(3);
    //     break;
    //   case 'Thu':
    //     weekDaysIndexList.add(4);
    //     break;
    //   case 'Fri':
    //     weekDaysIndexList.add(5);
    //     break;
    //   case 'Sat':
    //     weekDaysIndexList.add(6);
    //     break;
    //   default:
    //     break;
    // }
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

//====================Repeat Frequency Enum to String====================//
RepeatFrequency? stringToRepeatFrequencyEnum({
  required String? repeatFrequency,
}) {
  switch (repeatFrequency) {
    case 'Daily':
      return RepeatFrequency.daily;
    case 'Weekly':
      return RepeatFrequency.weekly;
    case 'Monthly':
      return RepeatFrequency.monthly;
    default:
      return null;
  }
}
