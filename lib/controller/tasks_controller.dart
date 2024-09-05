import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/model/all_users_performance_model.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/repository/tasks_repository.dart';

class TasksController extends GetxController {
  TasksController() {
    getCategories();
  }
  final tasksRepository = TasksRepository();

  final tasksException = Rxn<Exception>();

  Rxn<List<TaskModel>?> myTasksListObs = Rxn<List<TaskModel>>();
  Rxn<List<TaskModel>?> delegatedTasksListObs = Rxn<List<TaskModel>>();

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

  Rxn<List<AllUsersPerformanceModel>> allUsersPerformanceModelList =
      Rxn<List<AllUsersPerformanceModel>>();

  final taskUpdateAttachments = <File>[].obs;

//====================Get My Tasks====================//
  Future<void> getMyTasks() async {
    try {
      myTasksListObs.value = await tasksRepository.getMyTasks();

      tasksException.value = null;

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
  Future<void> getDelegatedTasks() async {
    try {
      delegatedTasksListObs.value = await tasksRepository.getDelegatedTasks();

      tasksException.value = null;

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

//====================Get All Users Performance====================//
  Future<void> getAllUsersPerformance() async {
    try {
      allUsersPerformanceModelList.value =
          await tasksRepository.getAllUsersPerformanceReport();
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
  Future<List<File>> fetchMultipleImagesFromStorage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> imageXFileList = await picker.pickMultiImage();
      final imageFileList = <File>[];

      for (XFile imageXFile in imageXFileList) {
        imageFileList.add(
          File(imageXFile.path),
        );
      }
      return imageFileList;
    } catch (_) {
      rethrow;
    }
  }

//====================Add Image to task update attachments====================//
  Future<void> addImageToTaskUpdateAttachments() async {
    taskUpdateAttachments.addAll(await fetchMultipleImagesFromStorage());
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
