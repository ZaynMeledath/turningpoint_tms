import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/model/all_users_model.dart';
import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/service/api/api_endpoints.dart';
import 'package:turning_point_tasks_app/service/api/api_service.dart';

Future<void> addUserModelToHive({
  required dynamic userModelResponseJson,
}) async {
  final userBox = Hive.box(AppConstants.appDb);
  userBox.delete(AppConstants.userModelStorageKey);
  userBox.put(AppConstants.userModelStorageKey, userModelResponseJson);
}

class UserRepository {
//====================User Register====================//
  static Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String department,
    required String password,
    required String role,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.register,
        requestMethod: RequestMethod.POST,
        data: {
          'userName': name,
          'phone': phone,
          'emailID': email,
          'department': department,
          'role': role,
          'password': password,
        },
        fieldNameForFiles: null,
        isTokenRequired: false,
      );
    } catch (e) {
      rethrow;
    }
  }

//====================User Login====================//
  static Future<UserModelResponse> login({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.login,
        requestMethod: RequestMethod.POST,
        data: {
          'emailID': email,
          'password': password,
          // 'fcmToken': fcmToken,
        },
        fieldNameForFiles: null,
        isTokenRequired: false,
      );

      addUserModelToHive(userModelResponseJson: jsonEncode(response));
      return UserModelResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

//====================Get All Team Members====================//
  static Future<List<AllUsersModel>?> getAllTeamMembers() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.getAllTeamMembers,
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );

      final allUsersModelResponse = AllUsersModelResponse.fromJson(response);

      return allUsersModelResponse.users;
    } catch (e) {
      rethrow;
    }
  }

//====================Delete a Team Member====================//
  static Future<List<AllUsersModel>?> deleteTeamMember({
    required String memberId,
  }) async {
    try {
      final response = await ApiService().sendRequest(
        url: '${ApiEndpoints.getAllTeamMembers}/$memberId',
        requestMethod: RequestMethod.DELETE,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );

      final allUsersModelResponse = AllUsersModelResponse.fromJson(response);

      return allUsersModelResponse.users;
    } catch (e) {
      rethrow;
    }
  }
}
