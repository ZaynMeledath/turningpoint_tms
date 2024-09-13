import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/controller/app_controller.dart';
import 'package:turning_point_tasks_app/model/all_categories_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/all_users_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/delegated_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/my_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/repository/tasks_repository.dart';

class TasksController extends GetxController {
  TasksController() {
    getCategories();
  }
  final tasksRepository = TasksRepository();

  final tasksException = Rxn<Exception>();

  final appController = Get.put(AppController());

  final RxBool isDelegatedObs = false.obs;

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

  final completedOnTimeMyTasksList = <TaskModel>[].obs;
  final completedDelayedMyTasksList = <TaskModel>[].obs;
  final completedOnTimeDelegatedTasksList = <TaskModel>[].obs;
  final completedDelayedDelegatedTasksList = <TaskModel>[].obs;

  final dashboardTabIndexObs = 0.obs;

  Rxn<List<AllUsersPerformanceReportModel>> allUsersPerformanceReportModelList =
      Rxn<List<AllUsersPerformanceReportModel>>();

  Rxn<List<AllCategoriesPerformanceReportModel>>
      allCategoriesPerformanceReportModelList =
      Rxn<List<AllCategoriesPerformanceReportModel>>();

  Rxn<List<MyPerformanceReportModel>> myPerformanceReportModelList =
      Rxn<List<MyPerformanceReportModel>>();

  Rxn<List<DelegatedPerformanceReportModel>>
      delegatedPerformanceReportModelList =
      Rxn<List<DelegatedPerformanceReportModel>>();

  final taskUpdateAttachments = <File>[].obs;
  final taskUpdateAttachmentsUrl = RxList<String>();

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

      openTaskList.value =
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
  Future<void> getDelegatedTasks({
    bool? getFromLocalStorage,
    bool? filter,
  }) async {
    try {
      //Executes if it's not run for the filter function
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
  void getCategories() async {
    try {
      final temp = await tasksRepository.getCategories();
      if (temp != null) {
        for (var item in temp) {
          categoriesList.add(item.toString());
        }
      }
    } catch (e) {
      rethrow;
    }
  }

//====================Get All Users Performance Report====================//
  Future<void> getAllUsersPerformanceReport() async {
    try {
      allUsersPerformanceReportModelList.value =
          await tasksRepository.getAllUsersPerformanceReport();
      tasksException.value = null;
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
    } catch (e) {
      tasksException.value = e as Exception;
    }
  }

//====================Get My Performance Report====================//
  Future<void> getMyPerformanceReport() async {
    try {
      myPerformanceReportModelList.value =
          await tasksRepository.getMyPerformanceReport();
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
    } catch (e) {
      tasksException.value = e as Exception;
    }
  }

//====================Edit Task====================//
  Future<void> editTask({required String taskId}) async {
    try {
      await tasksRepository.editTask(taskId: taskId);
      tasksException.value = null;
      await getDelegatedTasks();
    } catch (_) {
      rethrow;
    }
  }

//====================Delete Task====================//
  Future<void> deleteTask({required String taskId}) async {
    try {
      await tasksRepository.deleteTask(taskId: taskId);
      tasksException.value = null;
      await getDelegatedTasks();
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
      );
      tasksException.value = null;
      await getMyTasks();
      await getDelegatedTasks();
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
      taskUpdateAttachments.add(imageFile);
      appController.isLoadingObs.value = true;

      for (File file in taskUpdateAttachments) {
        taskUpdateAttachmentsUrl
            .add(await tasksRepository.uploadAttachment(file: file));
      }
      appController.isLoadingObs.value = false;
    }
  }

//====================Reset Task Controller====================//
  void resetTasksController() {}
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
