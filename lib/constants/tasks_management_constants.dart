import 'package:flutter/material.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';

const totalDays = 31;

class Status {
  static const open = 'Open';
  static const inProgress = 'In Progress';
  static const completed = 'Completed';
  static const overdue = 'Overdue';
}

class StatusIcons {
  static const open = Icons.circle;
  static const inProgress = Icons.incomplete_circle;
  static const completed = Icons.check_circle;
  static const overdue = Icons.circle;
}

class StatusColor {
  static const open = Colors.orange;
  static const inProgress = Colors.blue;
  static const completed = AppColors.themeGreen;
  static const overdue = Colors.red;
}

class TaskFileType {
  static const image = 'image';
  static const video = 'video';
  static const audio = 'audio';
  static const others = 'application';
}

final statusAndColorMap = {
  Status.open: StatusColor.open,
  Status.inProgress: StatusColor.inProgress,
  Status.completed: StatusColor.completed,
  Status.overdue: StatusColor.overdue,
};

class DefaultReminder {
  static const defaultReminderTime = 10;
  static const defaultReminderUnit = 'Minutes';
}

//To filter the tasks list in dashboard screen to tasks screen
enum TasksListCategory {
  overdue,
  open,
  inProgress,
  completed,
  onTime,
  delayed,
  staffWise,
  categoryWise,
  myReport,
  delegatedReport,
}
