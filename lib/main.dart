import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/firebase_options.dart';
import 'package:turning_point_tasks_app/preferences/app_preferences.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/home/tasks_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.appDb);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authToken = AppPreferences.getValueShared('auth_token');
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lufga',
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: AppColors.themeGreen,
          ),
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        ),
        home: authToken == null ? const LoginScreen() : const TasksHome(),
        // home: TaskDetailsScreen(
        //   taskModel: TaskModel(
        //     title: 'Task Title',
        //     createdAt: '',
        //     createdBy: 'Zayn Meledath',
        //     assignedTo: 'Ajay',
        //     priority: 'High',
        //     category: 'Business',
        //     description:
        //         'This is the task description which can be as long as this to test the description alignment.',
        //   ),
        //   dueDateString: 'Fri, 12 JUN 12:15 PM',
        // ),
      ),
    );
  }
}
