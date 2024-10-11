import 'dart:developer' show log;
import 'dart:convert';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/model/all_users_model.dart';
import 'package:turningpoint_tms/model/user_model.dart';
import 'package:turningpoint_tms/service/api/api_endpoints.dart';
import 'package:turningpoint_tms/service/api/api_service.dart';

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
    log('FCM TOKEN: $fcmToken');
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.login,
        requestMethod: RequestMethod.POST,
        data: {
          'emailID': email,
          'password': password,
          'fcmToken': fcmToken,
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

//====================Get User By ID====================//
  static Future<UserModel?> getUserById({
    required String userId,
  }) async {
    try {
      final response = await ApiService().sendRequest(
        url: '${ApiEndpoints.users}/$userId',
        requestMethod: RequestMethod.GET,
        data: {},
        fieldNameForFiles: null,
        isTokenRequired: true,
      );

      addUserModelToHive(userModelResponseJson: jsonEncode(response));
      final userModelResponse = UserModelResponse.fromJson(response);

      return userModelResponse.user;
    } catch (e) {
      rethrow;
    }
  }

//====================Update Profile====================//
  static Future<void> updateProfile({
    required UserModel userModel,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.updateProfile,
        requestMethod: RequestMethod.PUT,
        data: userModel.toJson(),
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Change Password====================//
  static Future<void> changePassword({
    required String newPassword,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.updateProfile,
        requestMethod: RequestMethod.PUT,
        data: {
          'password': newPassword,
        },
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (_) {
      rethrow;
    }
  }

//====================Get All Team Members====================//
  static Future<List<AllUsersModel>?> getAllTeamMembers() async {
    try {
      final response = await ApiService().sendRequest(
        url: ApiEndpoints.users,
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

//====================Add a Team Member====================//
  static Future<void> addTeamMember({
    required AllUsersModel userModel,
  }) async {
    try {
      await ApiService().sendRequest(
        url: ApiEndpoints.users,
        requestMethod: RequestMethod.POST,
        data: userModel.toJson(),
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
    } catch (e) {
      rethrow;
    }
  }

//====================Update Team Member====================//
  static Future<void> updateTeamMember({
    required AllUsersModel userModel,
  }) async {
    try {
      await ApiService().sendRequest(
        url: '${ApiEndpoints.users}/${userModel.id}',
        requestMethod: RequestMethod.PUT,
        data: userModel.toJson(),
        fieldNameForFiles: null,
        isTokenRequired: true,
      );
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
        url: '${ApiEndpoints.users}/$memberId',
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
