import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/exception/user_exceptions.dart';
import 'package:turning_point_tasks_app/model/all_users_model.dart';
import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/preferences/app_preferences.dart';
import 'package:turning_point_tasks_app/repository/user_repository.dart';

class UserController extends GetxController {
  final userException = Rxn<Exception>();

  RxBool isObScure = true.obs;
  final Rxn<List<AllUsersModel>> myTeamList = Rxn<List<AllUsersModel>>();

//====================User Register====================//
  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String department,
    required String role,
    required String password,
  }) async {
    try {
      await UserRepository.register(
        name: name,
        phone: phone,
        email: email,
        department: department,
        role: role,
        password: password,
      );
      userException.value = null;
    } catch (e) {
      userException.value = e as Exception;
    }
  }

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
        userException.value = null;
      } else {
        throw FcmTokenNullException();
      }
    } catch (e) {
      userException.value = e as Exception;
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

//====================Get user from Hive Box====================//
  Future<void> getAllTeamMembers() async {
    try {
      myTeamList.value = await UserRepository.getAllTeamMembers();
      userException.value = null;
    } catch (e) {
      userException.value = e as Exception;
    }
  }
}

// final userController = Get.put(UserController());
