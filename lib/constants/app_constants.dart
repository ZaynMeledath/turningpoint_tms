import 'package:flutter/material.dart';

class AppColor {
  static const themeGreen = Color.fromRGBO(36, 196, 123, 1); //#24C47B
  static const scaffoldBackgroundColor = Color.fromRGBO(30, 36, 40, 1);

  static const textFieldColor = Color.fromRGBO(44, 50, 54, 1);
  static const bottomSheetColor = Color.fromRGBO(29, 36, 41, 1);
}

class AppConstants {
  static const appDb = 'turningpoint_db';
  static const userModelStorageKey = 'user';
  static const authTokenKey = 'auth_token';
}

class Role {
  static const admin = 'Admin';
  static const teamLeader = 'TeamLeader';
  static const user = 'User';
}
