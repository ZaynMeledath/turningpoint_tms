import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/view/task_management/test.dart';

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
          brightness: Brightness.light,
          seedColor: const Color(0xff5d87ff),
        ),
        useMaterial3: true,
        brightness: Brightness.light,
        // scaffoldBackgroundColor: const Color.fromRGBO(18, 18, 18, 1),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Test(),
    );
  }
}
