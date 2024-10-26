import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/firebase_options.dart';
import 'package:turningpoint_tms/notification/awesome_notification_controller.dart';
import 'package:turningpoint_tms/preferences/app_preferences.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';
import 'package:turningpoint_tms/view/task_management/home/tasks_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.init();
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.appDb);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onMessage.listen(_firebasePushHandler);
  FirebaseMessaging.onBackgroundMessage(_firebasePushHandler);
  // RemoteMessage? initialMessage =
  //     await FirebaseMessaging.instance.getInitialMessage();

  // if (initialMessage != null) {
  //   _handleFirebaseMessage(initialMessage);
  // }
  // FirebaseMessaging.onMessageOpenedApp.listen(_handleFirebaseMessage);
  AwesomeNotifications().initialize(
    'resource://drawable/notification_icon',
    [
      NotificationChannel(
        channelGroupKey: 'basic_group',
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Channel for basic notifications',
        enableVibration: true,
        importance: NotificationImportance.High,
        defaultColor: Colors.red,
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_group',
        channelGroupName: 'Basic Group',
      ),
    ],
  );

//====================Requesting Permissions====================//
  if (!await AwesomeNotifications().isNotificationAllowed()) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  AwesomeNotifications().setListeners(
    onActionReceivedMethod:
        AwesomeNotificationController.onActionReceivedMethod,
    onNotificationCreatedMethod:
        AwesomeNotificationController.onNotificationCreatedMethod,
    onNotificationDisplayedMethod:
        AwesomeNotificationController.onNotificationDisplayedMethod,
    onDismissActionReceivedMethod:
        AwesomeNotificationController.onDismissActionReceivedMethod,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

Future<void> _firebasePushHandler(RemoteMessage message) async {
  // if (message.data['type'] == 'task')
  // {
  final tasksController = Get.put(TasksController());
  final userModel = getUserModelFromHive();
  final isAdminOrLeader =
      userModel?.role == Role.admin || userModel?.role == Role.teamLeader;
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecondsSinceEpoch.remainder(1000),
      channelKey: 'basic_channel',
      title: message.notification!.title,
      body: message.notification!.body,
    ),
  );

//To ensure that the data is up to date
  switch (message.data['type']) {
    case 'task':
      await tasksController.getMyTasks();
      await tasksController.getDelegatedTasks();
      await tasksController.getAllTasks();
      if (isAdminOrLeader) {
        await tasksController.getAllUsersPerformanceReport();
        await tasksController.getAllCategoriesPerformanceReport();
        await tasksController.getMyPerformanceReport();
        await tasksController.getDelegatedPerformanceReport();
      } else {
        await tasksController.getMyPerformanceReport();
      }
      break;

    case 'profile':
      break;

    default:
      break;
  }
  // }
}

// void _handleFirebaseMessage(RemoteMessage message) {
//   if (message.notification != null) {
//     switch (message.data['type']) {
//       case 'task':
//         break;
//       case 'profile':
//         break;
//       default:
//         break;
//     }
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authToken = AppPreferences.getValueShared('auth_token');
    final user = getUserModelFromHive();
    return ScreenUtilInit(
      ///Add maxScreen width to the ScreenUtil package file to ensure UI quality (On line 216 of screen_util.dart (pub package))
      ///  double get scaleWidth => !_enableScaleWH() ? 1 : (screenWidth > 550 ? 550 : screenWidth) / _uiSize.width;

      designSize: const Size(412, 915),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TurningPoint TMS',
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
        home: user == null || authToken == null
            ? const LoginScreen()
            : const TasksHome(),
      ),
    );
  }
}
