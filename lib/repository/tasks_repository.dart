import 'dart:io';

import 'package:turning_point_tasks_app/model/all_categories_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/all_users_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/delegated_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/my_performance_report_model.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/service/api/api_endpoints.dart';
import 'package:turning_point_tasks_app/service/api/api_service.dart';

class TasksRepository {
//====================Get All Tasks====================//
  Future<List<TaskModel>?> getAllTasks() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.getAllTasks,
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

//====================Get Categories====================//
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

//====================Add Categories====================//
  Future<void> addCategory({required String categoryName}) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.addCategory,
        requestMethod: RequestMethod.POST,
        data: {
          'name': categoryName,
        },
        isTokenRequired: true,
        fieldNameForFiles: null,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Upload Attachment====================//
  Future<String> uploadAttachment({required File file}) async {
    final response = await ApiService().sendRequest(
      url: ApiEndpoints.uploadFile,
      requestMethod: RequestMethod.POST,
      data: file,
      fieldNameForFiles: 'attachments',
      isTokenRequired: true,
    );
    return response.first as String;
  }

//====================Assign Task====================//
  Future<void> assignTask({
    // required String title,
    // required String description,
    // required String category,
    // required List<String> assignTo,
    // required String priority,
    // required String dueDate,
    // required String? repeatFrequency,
    // required String? repeatUntil,
    // required List<String>? attachments,
    required TaskModel taskModel,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.assignTask,
        requestMethod: RequestMethod.POST,
        // data: {
        //   'title': title,
        //   'description': description,
        //   'category': category,
        //   'assignTo': assignTo,
        //   'priority': priority,
        //   'dueDate': dueDate,
        //   'repeatFrequency': repeatFrequency,
        //   'repeatUntil': repeatUntil,
        //   'attachments': attachments,
        // },
        data: taskModel.toJson(),
        fieldNameForFiles: 'attachments',
        isTokenRequired: true,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Update Task====================//
  Future<void> updateTask({
    required TaskModel taskModel,
  }) async {
    try {
      await ApiService().sendRequest(
        url: '${ApiEndpoints.assignTask}/${taskModel.id}',
        requestMethod: RequestMethod.POST,
        data: taskModel.toJson(),
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
          'note': note,
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
  Future<List<AllUsersPerformanceReportModel>?>
      getAllUsersPerformanceReport() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.allUsersPerformanceReport,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );

      final allUsersPerformanceModelResponse =
          AllUsersPerformanceReportModelResponse.fromJson(response);
      return allUsersPerformanceModelResponse.usersPerformanceModelList;
    } catch (e) {
      rethrow;
    }
  }

//====================Get All Categories Performance Report====================//
  Future<List<AllCategoriesPerformanceReportModel>?>
      getAllCategoriesPerformanceReport() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.allCategoriesPerformanceReport,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );

      final allCategoriesPerformanceModelResponse =
          AllCategoriesPerformanceReportModelResponse.fromJson(response);
      return allCategoriesPerformanceModelResponse
          .categoriesPerformanceReportModelList;
    } catch (e) {
      rethrow;
    }
  }

//====================Get My Performance Report====================//
  Future<List<MyPerformanceReportModel>?> getMyPerformanceReport() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.myPerformanceReport,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );

      final myPerformanceModelResponse =
          MyPerformanceReportModelResponse.fromJson(response);
      return myPerformanceModelResponse.myPerformanceModelList;
    } catch (e) {
      rethrow;
    }
  }

//====================Get Delegated Performance Report====================//
  Future<List<DelegatedPerformanceReportModel>?>
      getDelegatedPerformanceReport() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.delegatedPerformanceReport,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );

      final delegatedPerformanceModelResponse =
          DelegatedPerformanceReportModelResponse.fromJson(response);
      return delegatedPerformanceModelResponse
          .delegatedPerformanceReportModelList;
    } catch (e) {
      rethrow;
    }
  }
}
