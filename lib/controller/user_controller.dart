import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/exception/user_exceptions.dart';
import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/preferences/app_preferences.dart';
import 'package:turning_point_tasks_app/repository/user_repository.dart';

class UserController extends GetxController {
  RxBool isObScure = true.obs;

//====================User Login====================//
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        final userModelResponse = await UserRepository.login(
          email: email,
          password: password,
          fcmToken: fcmToken,
        );
        AppPreferences.addSharedPreference(
          key: AppConstants.authTokenKey,
          value: userModelResponse.token,
        );
      } else {
        throw FcmTokenNullException();
      }
    } catch (e) {
      rethrow;
    }
  }

//====================Get user from Hive Box====================//
  UserModel? getUserModelFromHive() {
    final userBox = Hive.box(AppConstants.appDb);
    final userModelResponseJson = userBox.get(AppConstants.userModelStorageKey);
    if (userModelResponseJson != null) {
      final userModelResponse =
          UserModelResponse.fromJson(jsonDecode(userModelResponseJson));
      return userModelResponse.user;
    } else {
      return null;
    }
  }
}

// final userController = Get.put(UserController());
