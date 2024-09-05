import 'package:turning_point_tasks_app/model/all_users_performance_model.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/service/api/api_endpoints.dart';
import 'package:turning_point_tasks_app/service/api/api_service.dart';

class TasksRepository {
//====================Get My Tasks====================//
  Future<List<TaskModel>?> getMyTasks() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.getMyTasks,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
      return TasksModelResponse.fromJson(response).tasks;
    } catch (e) {
      rethrow;
    }
  }

//====================Get Delegated Tasks====================//
  Future<List<TaskModel>?> getDelegatedTasks() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.getDelegatedTasks,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
      return TasksModelResponse.fromJson(response).tasks;
    } catch (_) {
      rethrow;
    }
  }

//====================Assign Task====================//
  Future<List<dynamic>?> getCategories() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.getCategories,
        requestMethod: RequestMethod.GET,
        data: {},
        isTokenRequired: true,
        fieldNameForFiles: null,
      );
      return response['categories'];
    } catch (_) {
      rethrow;
    }
  }

//====================Assign Task====================//
  Future<void> assignTask({
    required String title,
    required String description,
    required String category,
    required List<String> assignTo,
    required String priority,
    required String dueDate,
    required String? repeatFrequency,
    required String? repeatUntil,
    required List<dynamic>? attachments,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.assignTask,
        requestMethod: RequestMethod.POST,
        data: {
          'title': title,
          'description': description,
          'category': category,
          'assignTo': assignTo,
          'priority': priority,
          'dueDate': dueDate,
          'repeatFrequency': repeatFrequency,
          'repeatUntil': repeatUntil,
          'attachments': attachments,
        },
        fieldNameForFiles: 'attachments',
        isTokenRequired: true,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Edit Task====================//
  Future<void> editTask({required String taskId}) async {
    try {
      await ApiService().sendRequest(
        url: '${ApiEndpoints.assignTask}/$taskId',
        requestMethod: RequestMethod.PATCH,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
      await getDelegatedTasks();
      // await getMyTasks();
    } catch (e) {
      rethrow;
    }
  }

//====================Delete Task====================//
  Future<void> deleteTask({required String taskId}) async {
    try {
      await ApiService().sendRequest(
        url: '${ApiEndpoints.assignTask}/$taskId',
        requestMethod: RequestMethod.DELETE,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
      await getDelegatedTasks();
      // await getMyTasks();
    } catch (e) {
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
      await ApiService().sendRequest(
        url: '${ApiEndpoints.assignTask}/$taskId/status',
        requestMethod: RequestMethod.PUT,
        data: {
          'newStatus': taskStatus,
          'reason': note,
          'changesAttachments': null,
        },
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (e) {
      rethrow;
    }
  }

//====================Get All Users Performance Report====================//
  Future<List<AllUsersPerformanceModel>?> getAllUsersPerformanceReport() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.allUsersPerformanceReport,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );

      final allUsersPerformanceModelResponse =
          AllUsersPerformanceModelResponse.fromJson(response);
      return allUsersPerformanceModelResponse.usersPerformanceModel;
    } catch (e) {
      rethrow;
    }
  }
}
