import 'package:turningpoint_tms/model/all_categories_performance_report_model.dart';
import 'package:turningpoint_tms/model/all_users_performance_report_model.dart';
import 'package:turningpoint_tms/model/delegated_performance_report_model.dart';
import 'package:turningpoint_tms/model/my_performance_report_model.dart';
import 'package:turningpoint_tms/model/personal_reminder_model.dart';
import 'package:turningpoint_tms/model/tasks_model.dart';
import 'package:turningpoint_tms/service/api/api_endpoints.dart';
import 'package:turningpoint_tms/service/api/api_service.dart';

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

//====================Assign Task====================//
  Future<void> assignTask({
    required TaskModel taskModel,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.assignTask,
        requestMethod: RequestMethod.POST,
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
        requestMethod: RequestMethod.PATCH,
        data: taskModel.toJson(),
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Delete Task====================//
  Future<void> deleteTask({
    required String taskId,
    required String? groupId,
  }) async {
    try {
      await ApiService().sendRequest(
        url: groupId != null
            ? '${ApiEndpoints.assignTask}/repeat/$groupId/$taskId'
            : '${ApiEndpoints.assignTask}/$taskId',
        requestMethod: RequestMethod.DELETE,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (e) {
      rethrow;
    }
  }

//====================Change Task Status====================//
  Future<void> updateTaskStatus({
    required String taskId,
    required String taskStatus,
    required String note,
    required List<Map<String, String>> taskUpdateAttachmentsMapList,
  }) async {
    try {
      await ApiService().sendRequest(
        url: '${ApiEndpoints.assignTask}/$taskId/status',
        requestMethod: RequestMethod.PUT,
        data: {
          'newStatus': taskStatus,
          'note': note,
          'changesAttachments': taskUpdateAttachmentsMapList.isNotEmpty
              ? taskUpdateAttachmentsMapList
              : null,
        },
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (e) {
      rethrow;
    }
  }

//====================Approve Task====================//
  Future<void> approveTask({
    required String taskId,
  }) async {
    try {
      await ApiService().sendRequest(
        url: '${ApiEndpoints.approveTask}/$taskId',
        requestMethod: RequestMethod.PATCH,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Get Personal Reminders====================//
  Future<List<PersonalReminderModel>?> getPersonalRemindersList() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.personalReminder,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );

      return PersonalReminderModelResponse.fromJson(response).reminders;
    } catch (_) {
      rethrow;
    }
  }

//====================Add Personal Reminder====================//
  Future<void> addPersonalReminder({
    required String? taskId,
    required String message,
    required String reminderDateString,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.personalReminder,
        requestMethod: RequestMethod.POST,
        data: {
          'taskId': taskId,
          'message': message,
          'reminderDate': reminderDateString,
        },
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Delete Personal Reminder====================//
  Future<void> deletePersonalReminder({
    required String reminderId,
  }) async {
    try {
      await ApiService().sendRequest(
        url: '${ApiEndpoints.personalReminder}/$reminderId',
        requestMethod: RequestMethod.DELETE,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (_) {
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
