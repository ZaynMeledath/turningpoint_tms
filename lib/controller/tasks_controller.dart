import 'package:flutter/material.dart' show TimeOfDay;
import 'package:get/get.dart';

class TasksController extends GetxController {
  Rx<DateTime> date = DateTime.now().obs;
  Rx<TimeOfDay> time = TimeOfDay.now().obs;
}

final tasksController = Get.put(TasksController());
