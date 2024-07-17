import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lufga',
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.green,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
        // scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(29, 36, 41, 1),
      ),
      home: const LoginScreen(),
    );
  }
}
