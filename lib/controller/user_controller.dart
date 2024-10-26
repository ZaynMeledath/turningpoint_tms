import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/exception/user_exceptions.dart';
import 'package:turningpoint_tms/model/all_users_model.dart';
import 'package:turningpoint_tms/model/user_model.dart';
import 'package:turningpoint_tms/preferences/app_preferences.dart';
import 'package:turningpoint_tms/repository/user_repository.dart';

class UserController extends GetxController {
  final userException = Rxn<Exception>();

  RxBool isObScure = true.obs;
  final Rxn<List<AllUsersModel>> myTeamList = Rxn<List<AllUsersModel>>();
  RxList<AllUsersModel> myTeamSearchList = <AllUsersModel>[].obs;

  Rxn<List<AllUsersModel>> assignTaskUsersList = Rxn<List<AllUsersModel>>();
  RxList<AllUsersModel> assignTaskUsersSearchList = <AllUsersModel>[].obs;

//====================My Team====================//
  final roleObs = RxnString();
  final reportingManagerObs = RxnString();
  final departmentObs = RxnString();

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
      rethrow;
    }
  }

//====================Get User By ID====================//
  Future<void> getUserById({required String userId}) async {
    try {
      await UserRepository.getUserById(userId: userId);
    } catch (e) {
      userException.value = e as Exception;
    }
  }

//====================Update Profile====================//
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
  }) async {
    try {
      final userModel = getUserModelFromHive()!;
      userModel.name = name;
      userModel.phone = phone;
      userModel.emailId = email;
      await UserRepository.updateProfile(userModel: userModel);
    } catch (_) {
      rethrow;
    }
  }

//====================Change Password====================//
  Future<void> changePassword({required String newPassword}) async {
    try {
      await UserRepository.changePassword(newPassword: newPassword);
    } catch (_) {
      rethrow;
    }
  }

//====================Get All Team Members====================//
  Future<void> getAllTeamMembers() async {
    try {
      myTeamList.value = await UserRepository.getAllTeamMembers();
      if (myTeamList.value != null) {
        myTeamSearchList.value = myTeamList.value!;
      }
      userException.value = null;
    } catch (e) {
      userException.value = e as Exception;
    }
  }

//====================Get Assign Task Users====================//
  Future<void> getAssignTaskUsers() async {
    try {
      assignTaskUsersList.value = await UserRepository.getAssignTaskUsers();
      if (assignTaskUsersList.value != null) {
        assignTaskUsersSearchList.value = assignTaskUsersList.value!;
      }
      userException.value = null;
    } catch (e) {
      userException.value = e as Exception;
    }
  }

//====================Add Team Member====================//
  Future<void> addTeamMember({
    required AllUsersModel userModel,
  }) async {
    try {
      await UserRepository.addTeamMember(userModel: userModel);
      userException.value = null;
      await getAllTeamMembers();
    } catch (e) {
      rethrow;
    }
  }

//====================Update Team Member====================//
  Future<void> updateTeamMember({
    required AllUsersModel userModel,
  }) async {
    try {
      await UserRepository.updateTeamMember(userModel: userModel);
      userException.value = null;
      await getAllTeamMembers();
    } catch (e) {
      rethrow;
    }
  }

//====================Delete Team Member====================//
  Future<void> deleteTeamMember({
    required String memberId,
  }) async {
    try {
      await UserRepository.deleteTeamMember(memberId: memberId);
      userException.value = null;
      await getAllTeamMembers();
    } catch (e) {
      rethrow;
    }
  }

//====================Block Team Member====================//
  Future<void> blockTeamMember({
    required String memberId,
  }) async {
    try {
      await UserRepository.blockTeamMember(memberId: memberId);
      userException.value = null;
      await getAllTeamMembers();
    } catch (e) {
      rethrow;
    }
  }

//====================Log Out====================//
  Future<void> logOut() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await UserRepository.logOut(fcmToken: fcmToken);
        final tasksController = Get.put(TasksController());
        tasksController.allTasksListObs.value = null;
        tasksController.myTasksListObs.value = null;
        tasksController.delegatedTasksListObs.value = null;
        tasksController.dashboardTasksListObs.clear();
        deleteUserModelFromHive();
        AppPreferences.clearSharedPreferences();
      } else {
        throw FcmTokenNullException();
      }
    } catch (_) {
      rethrow;
    }
  }
}

//====================Add user to Hive Box====================//
Future<void> addUserModelToHive({
  required dynamic userModelResponseJson,
}) async {
  try {
    final userBox = Hive.box(AppConstants.appDb);
    userBox.delete(AppConstants.userModelStorageKey);
    userBox.put(AppConstants.userModelStorageKey, userModelResponseJson);
  } catch (_) {
    rethrow;
  }
}

//====================Delete user from Hive Box====================//
Future<void> deleteUserModelFromHive() async {
  final userBox = Hive.box(AppConstants.appDb);
  userBox.delete(AppConstants.userModelStorageKey);
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
