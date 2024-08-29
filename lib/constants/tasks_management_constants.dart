import 'package:flutter/material.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';

const totalDays = 31;

class Status {
  static const open = 'Open';
  static const inProgress = 'In Progress';
  static const completed = 'Completed';
  static const overdue = 'Overdue';
}

class StatusIcons {
  static const pending = Icons.circle;
  static const inProgress = Icons.incomplete_circle;
  static const completed = Icons.check_circle;
  static const overdue = Icons.circle;
}

class StatusIconColor {
  static const pending = Colors.orange;
  static const inProgress = Colors.blue;
  static const completed = AppColors.themeGreen;
  static const overdue = Colors.red;
}

class DefaultReminder {
  static const defaultReminderTime = 10;
  static const defaultReminderUnit = 'Minutes';
}
