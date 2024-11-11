import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/assign_task_controller.dart';
import 'package:turningpoint_tms/exceptions/tms_exceptions.dart';
import 'package:turningpoint_tms/model/all_categories_performance_report_model.dart';
import 'package:turningpoint_tms/model/all_users_performance_report_model.dart';
import 'package:turningpoint_tms/model/delegated_performance_report_model.dart';
import 'package:turningpoint_tms/model/my_performance_report_model.dart';
import 'package:turningpoint_tms/model/personal_reminder_model.dart';
import 'package:turningpoint_tms/model/tasks_model.dart';
import 'package:turningpoint_tms/repository/tasks_repository.dart';

class TasksController extends GetxController {
  TasksController() {
    getCategories();
  }
  final tasksRepository = TasksRepository();

  final tasksException = Rxn<Exception>();
  final categoriesException = Rxn<Exception>();

  final appController = Get.put(AppController());

  final RxnBool isDelegatedObs = RxnBool();

  RxList<TaskModel> dashboardTasksListObs = RxList<TaskModel>();
  RxList<TaskModel> tempDashboardTasksListObs = RxList<TaskModel>();

  Rxn<List<TaskModel>> allTasksListObs = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> tempAllTasksListObs = Rxn<List<TaskModel>>();

  Rxn<List<TaskModel>> myTasksListObs = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>> tempMyTasksListObs = Rxn<List<TaskModel>>();

  Rxn<List<TaskModel>?> delegatedTasksListObs = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> tempDelegatedTasksListObs = Rxn<List<TaskModel>>();

  RxList<String> categoriesList = RxList<String>();

  Rxn<List<TaskModel>?> openTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> inProgressTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> completedTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> overdueTaskList = Rxn<List<TaskModel>>();

  Rxn<List<TaskModel>?> openDelegatedTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> inProgressDelegatedTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> completedDelegatedTaskList = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> overdueDelegatedTaskList = Rxn<List<TaskModel>>();

  Rx<TaskModel> openedTaskModelObs = TaskModel().obs;

  final completedOnTimeMyTasksList = <TaskModel>[].obs;
  final completedDelayedMyTasksList = <TaskModel>[].obs;
  final completedOnTimeDelegatedTasksList = <TaskModel>[].obs;
  final completedDelayedDelegatedTasksList = <TaskModel>[].obs;

  final dashboardTabIndexObs = 0.obs;

  Rxn<List<AllUsersPerformanceReportModel>> allUsersPerformanceReportModelList =
      Rxn<List<AllUsersPerformanceReportModel>>();
  Rxn<List<AllUsersPerformanceReportModel>>
      allUsersPerformanceReportModelSearchList =
      Rxn<List<AllUsersPerformanceReportModel>>();

  Rxn<List<AllCategoriesPerformanceReportModel>>
      allCategoriesPerformanceReportModelList =
      Rxn<List<AllCategoriesPerformanceReportModel>>();
  Rxn<List<AllCategoriesPerformanceReportModel>>
      allCategoriesPerformanceReportModelSearchList =
      Rxn<List<AllCategoriesPerformanceReportModel>>();

  Rxn<List<MyPerformanceReportModel>> myPerformanceReportModelList =
      Rxn<List<MyPerformanceReportModel>>();
  Rxn<List<MyPerformanceReportModel>> myPerformanceReportModelSearchList =
      Rxn<List<MyPerformanceReportModel>>();

  Rxn<List<DelegatedPerformanceReportModel>>
      delegatedPerformanceReportModelList =
      Rxn<List<DelegatedPerformanceReportModel>>();
  Rxn<List<DelegatedPerformanceReportModel>>
      delegatedPerformanceReportModelSearchList =
      Rxn<List<DelegatedPerformanceReportModel>>();

  final taskUpdateAttachmentsFileList = <File>[].obs;
  final taskUpdateAttachmentsMapList = RxList<Map<String, String>>();

  final allPersonalRemindersListObs = Rxn<List<PersonalReminderModel>>();
  final personalRemindersListObs = Rxn<List<PersonalReminderModel>>();

//====================Get All Tasks====================//
  Future<void> getAllTasks({bool? getFromLocalStorage}) async {
    try {
      if (getFromLocalStorage != true) {
        allTasksListObs.value = await tasksRepository.getAllTasks();
        tempAllTasksListObs.value = allTasksListObs.value;

        tasksException.value = null;
      } else {
        myTasksListObs.value = tempAllTasksListObs.value;
      }
    } catch (e) {
      tasksException.value = e as Exception;
    }
  }

  void addToDashboardTasksList({required List<TaskModel> tasksList}) {
    dashboardTasksListObs.value = tasksList;
    tempDashboardTasksListObs.value = tasksList;
  }

  void getDashboardTasksFromStorage() {
    dashboardTasksListObs.value = tempDashboardTasksListObs;
  }

//====================Get My Tasks====================//
  Future<void> getMyTasks({
    bool? getFromLocalStorage,
    bool? filter,
  }) async {
    try {
      //Executes if it's not run for the filter function
      if (filter != true) {
        if (getFromLocalStorage != true) {
          myTasksListObs.value = await tasksRepository.getMyTasks();
          tempMyTasksListObs.value = myTasksListObs.value;

          tasksException.value = null;
        } else {
          myTasksListObs.value = tempMyTasksListObs.value;
        }
      }

      openTaskList.value = myTasksListObs.value!
          .where((item) => item.status == Status.open)
          .toList();
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
  Future<void> getDelegatedTasks({
    bool? getFromLocalStorage,
    bool? filter,
  }) async {
    try {
      //Executes if it's not executed for the filter function.If executed for the filter function, it just filter tasks into respective variables
      if (filter != true) {
        if (getFromLocalStorage != true) {
          delegatedTasksListObs.value =
              await tasksRepository.getDelegatedTasks();
          tempDelegatedTasksListObs.value = delegatedTasksListObs.value;

          tasksException.value = null;
        } else {
          delegatedTasksListObs.value = tempDelegatedTasksListObs.value;
        }
      }

      openDelegatedTaskList.value = delegatedTasksListObs.value!
          .where((item) => item.status == Status.open)
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

//====================Get Categories====================//
  Future<void> getCategories() async {
    try {
      final temp = await tasksRepository.getCategories();
      categoriesException.value = null;
      if (temp != null) {
        categoriesList.clear();
        for (var item in temp) {
          categoriesList.add(item.toString());
        }
      }
    } catch (e) {
      categoriesException.value = e as Exception;
      rethrow;
    }
  }

//====================Add Categories====================//
  Future<void> addCategory({required String categoryName}) async {
    try {
      await tasksRepository.addCategory(categoryName: categoryName);
      await getCategories();
    } catch (_) {
      rethrow;
    }
  }

//====================Get Personal Reminders====================//
  Future<void> getPersonalRemindersList() async {
    try {
      allPersonalRemindersListObs.value =
          await tasksRepository.getPersonalRemindersList();
    } catch (_) {
      rethrow;
    }
  }

//====================Add Personal Reminder====================//
  Future<void> addPersonalReminder({
    required String? taskId,
    required String message,
    required AssignTaskController assignTaskController,
  }) async {
    try {
      final dueDate = DateTime(
        assignTaskController.taskDueOrStartDate.value.year,
        assignTaskController.taskDueOrStartDate.value.month,
        assignTaskController.taskDueOrStartDate.value.day,
        assignTaskController.taskDueOrStartTime.value.hour,
        assignTaskController.taskDueOrStartTime.value.minute,
      );

      if (!dueDate.isAfter(DateTime.now()) ||
          dueDate.isAtSameMomentAs(DateTime.now())) {
        throw DueOrStartDateTimeErrorException();
      }
      final reminderDateString = dueDate.toIso8601String();
      await tasksRepository.addPersonalReminder(
        taskId: taskId,
        message: message,
        reminderDateString: reminderDateString,
      );
    } catch (e) {
      rethrow;
    }
  }

//====================Delete Personal Reminders====================//
  Future<void> deletePersonalReminder({
    required String reminderId,
  }) async {
    try {
      await tasksRepository.deletePersonalReminder(reminderId: reminderId);
      await getPersonalRemindersList();
    } catch (_) {
      rethrow;
    }
  }

//====================Get All Users Performance Report====================//
  Future<void> getAllUsersPerformanceReport() async {
    try {
      allUsersPerformanceReportModelList.value =
          await tasksRepository.getAllUsersPerformanceReport();
      tasksException.value = null;
      if (allUsersPerformanceReportModelList.value != null) {
        for (int i = 0;
            i < (allUsersPerformanceReportModelSearchList.value?.length ?? 0);
            i++) {
          allUsersPerformanceReportModelSearchList.value![i] =
              allUsersPerformanceReportModelList.value!.firstWhere((model) =>
                  model.emailId ==
                  allUsersPerformanceReportModelSearchList.value![i].emailId);
        }
      }
    } catch (e) {
      tasksException.value = e as Exception;
    }
  }

//====================Get All Categories Performance Report====================//
  Future<void> getAllCategoriesPerformanceReport() async {
    try {
      allCategoriesPerformanceReportModelList.value =
          await tasksRepository.getAllCategoriesPerformanceReport();
      tasksException.value = null;
      if (allCategoriesPerformanceReportModelList.value != null) {
        for (int i = 0;
            i <
                (allCategoriesPerformanceReportModelSearchList.value?.length ??
                    0);
            i++) {
          allCategoriesPerformanceReportModelSearchList.value![i] =
              allCategoriesPerformanceReportModelList.value!.firstWhere(
                  (model) =>
                      model.category ==
                      allCategoriesPerformanceReportModelSearchList
                          .value![i].category);
        }
      }
    } catch (e) {
      tasksException.value = e as Exception;
    }
  }

//====================Get My Performance Report====================//
  Future<void> getMyPerformanceReport() async {
    try {
      myPerformanceReportModelList.value =
          await tasksRepository.getMyPerformanceReport();
      if (myPerformanceReportModelList.value != null) {
        for (int i = 0;
            i < (myPerformanceReportModelSearchList.value?.length ?? 0);
            i++) {
          myPerformanceReportModelSearchList.value![i] =
              myPerformanceReportModelList.value!.firstWhere((model) =>
                  model.category ==
                  myPerformanceReportModelSearchList.value![i].category);
        }
      }
      tasksException.value = null;
    } catch (e) {
      tasksException.value = e as Exception;
    }
  }

//====================Get Delegated Performance Report====================//
  Future<void> getDelegatedPerformanceReport() async {
    try {
      delegatedPerformanceReportModelList.value =
          await tasksRepository.getDelegatedPerformanceReport();
      tasksException.value = null;
      if (delegatedPerformanceReportModelList.value != null) {
        for (int i = 0;
            i < (delegatedPerformanceReportModelSearchList.value?.length ?? 0);
            i++) {
          delegatedPerformanceReportModelSearchList.value![i] =
              delegatedPerformanceReportModelList.value!.firstWhere((model) =>
                  model.emailId ==
                  delegatedPerformanceReportModelSearchList.value![i].emailId);
        }
      }
    } catch (e) {
      tasksException.value = e as Exception;
    }
  }

//====================Delete Task====================//
  Future<void> deleteTask({required String taskId}) async {
    try {
      if (Get.currentRoute == '/TaskDetailsScreen') {
        unawaited(tasksRepository.deleteTask(taskId: taskId));
        Get.back();
        Get.back();
      } else {
        await tasksRepository.deleteTask(taskId: taskId);
        Get.back();
      }
    } catch (_) {
      rethrow;
    }
  }

//====================Fetch Image from Storage====================//
  Future<File?> fetchImageFromStorage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? imageXFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (imageXFile != null) {
        return File(imageXFile.path);
      } else {
        return null;
      }
    } catch (_) {
      rethrow;
    }
  }

//====================Add Image to task update attachments====================//
  Future<void> addImageToTaskUpdateAttachments() async {
    final imageFile = await fetchImageFromStorage();
    if (imageFile != null) {
      appController.isLoadingObs.value = true;
      taskUpdateAttachmentsMapList.add({
        'path': await tasksRepository.uploadAttachment(file: imageFile),
        'type': TaskFileType.image,
      });
      taskUpdateAttachmentsFileList.add(imageFile);

      appController.isLoadingObs.value = false;
    }
  }

//====================Add File Attachments====================//
  Future<void> addFileToTaskUpdateAttachments() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        appController.isLoadingObs.value = true;
        final url = await tasksRepository.uploadAttachment(file: file);
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

        taskUpdateAttachmentsMapList.add({
          'path': url,
          'type': fileType,
        });
        taskUpdateAttachmentsFileList.add(file);
        appController.isLoadingObs.value = false;
      }
    } catch (_) {
      rethrow;
    }
  }

//====================Change Task Status====================//
  Future<void> updateTaskStatus({
    required String taskId,
    required String taskStatus,
    required String note,
  }) async {
    try {
      await tasksRepository.updateTaskStatus(
        taskId: taskId,
        taskStatus: taskStatus,
        note: note,
        taskUpdateAttachmentsMapList: taskUpdateAttachmentsMapList,
      );
      tasksException.value = null;
      taskUpdateAttachmentsFileList.clear();
      taskUpdateAttachmentsMapList.clear();
      // if (isDelegatedObs.value == true) {
      //   await getDelegatedTasks();
      //   unawaited(getMyTasks());
      //   unawaited(getAllTasks());
      // } else if (isDelegatedObs.value == false) {
      //   await getMyTasks();
      //   unawaited(getDelegatedTasks());
      //   unawaited(getAllTasks());
      // } else {
      //   await getAllTasks();
      //   unawaited(getMyTasks());
      //   unawaited(getDelegatedTasks());
      // }
      // unawaited(getAllUsersPerformanceReport());
      // unawaited(getMyPerformanceReport());
      // unawaited(getDelegatedPerformanceReport());
      // unawaited(getAllCategoriesPerformanceReport());
    } catch (_) {
      rethrow;
    }
  }

//====================Approve Task====================//
  Future<void> approveTask({
    required String taskId,
  }) async {
    try {
      await tasksRepository.approveTask(taskId: taskId);
      if (isDelegatedObs.value == true) {
        await getDelegatedTasks();
        unawaited(getMyTasks());
        unawaited(getAllTasks());
      } else if (isDelegatedObs.value == false) {
        await getMyTasks();
        unawaited(getDelegatedTasks());
        unawaited(getAllTasks());
      } else {
        await getAllTasks();
        unawaited(getMyTasks());
        unawaited(getDelegatedTasks());
      }
    } catch (_) {
      rethrow;
    }
  }
}

class TaskPriority {
  static const low = 'Low';
  static const medium = 'Medium';
  static const high = 'High';
}

//====================ENUMS====================//
enum RepeatFrequency {
  once,
  daily,
  weekly,
  monthly,
}

extension RepeatFrequencyExtension on RepeatFrequency {
  String? enumToString() {
    switch (this) {
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
}
