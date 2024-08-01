import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/exception/user_exceptions.dart';
import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/preferences/app_preferences.dart';
import 'package:turning_point_tasks_app/repository/user_repository.dart';

Box<dynamic>? userBox;

Future<void> addUserModelToHive({
  required UserModel? userModel,
}) async {
  userBox = await Hive.openBox(AppConstants.appDb);
  userBox!.put(AppConstants.userHiveBoxKey, userModel);
  print(userBox!.get(AppConstants.userHiveBoxKey));
}

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
        await addUserModelToHive(userModel: userModelResponse.user);
      } else {
        throw FcmTokenNullException();
      }
    } catch (e) {
      rethrow;
    }
  }
}

// final userController = Get.put(UserController());
