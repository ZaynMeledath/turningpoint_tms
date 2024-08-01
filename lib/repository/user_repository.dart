import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/service/api/api_endpoints.dart';
import 'package:turning_point_tasks_app/service/api/api_service.dart';

Future<void> addUserModelToHive({
  required dynamic userModelResponseJson,
}) async {
  final userBox = Hive.box(AppConstants.appDb);
  userBox.put(AppConstants.userModelStorageKey, userModelResponseJson);
}

class UserRepository {
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
}
