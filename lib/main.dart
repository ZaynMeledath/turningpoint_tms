import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/preferences/app_preferences.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lufga',
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: AppColor.themeGreen,
          ),
          useMaterial3: true,
          brightness: Brightness.dark,
          // scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
          scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
