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
      throw Exception;
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
    } catch (e) {
      throw Exception;
    }
  }

//====================Assign Task====================//
  Future<List<dynamic>?> getCategories() async {
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.getCategories,
      requestMethod: RequestMethod.GET,
      data: {},
      isTokenRequired: true,
      fieldNameForFiles: null,
    );
    return response['categories'];
  }

//====================Assign Task====================//
  Future<void> assignTask({
    required String title,
    required String description,
    required String category,
    required List<String> assignTo,
    required String priority,
    required String dueDate,
    required String? reminderFrequency,
    required String? reminderStartDate,
    required String? repeatFrequency,
    required String? repeatUntil,
    required List<dynamic>? attachments,
  }) async {
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
        'reminderFrequency': reminderFrequency,
        'reminderStartDate': reminderStartDate,
        'repeatFrequency': repeatFrequency,
        'repeatUntil': repeatUntil,
        'attachments': attachments,
      },
      fieldNameForFiles: 'attachments',
      isTokenRequired: true,
    );
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
