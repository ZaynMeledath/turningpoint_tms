import 'package:flutter/material.dart';

const totalDays = 31;

class Status {
  static const pending = 'Pending';
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
