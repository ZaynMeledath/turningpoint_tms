import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/exception/user_exceptions.dart';
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
          key: 'auth_token',
          value: userModelResponse.token,
        );
      } else {
        throw FcmTokenNullException();
      }
    } catch (e) {
      rethrow;
    }
  }
}

// final userController = Get.put(UserController());
