import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/dialogs/show_generic_dialog.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/dialogs/show_change_status_bottom_sheet.dart';

class TaskCrudOperations {
//====================Delete Task====================//
  static void deleteTask({
    required TasksController tasksController,
    required TaskModel taskModel,
  }) async {
    await showGenericDialog(
      iconPath: 'assets/lotties/delete_animation.json',
      title: 'Delete Task',
      content: 'Are you sure you want to delete this task?',
      confirmationButtonColor: Colors.red,
      iconWidth: 100.w,
      buttons: {
        'Cancel': null,
        'Delete': () async {
          try {
            await tasksController.deleteTask(
              taskId: taskModel.id.toString(),
            );
            Get.back();
            showGenericDialog(
              iconPath: 'assets/lotties/deleted_animation.json',
              title: 'Task Deleted!',
              content: 'Task Successfully deleted',
              buttons: {
                'OK': null,
              },
            );
          } catch (_) {
            showGenericDialog(
              iconPath: 'assets/lotties/server_error_animation.json',
              title: 'Something Went Wrong',
              content: 'Something went wrong while connecting to the server',
              buttons: {
                'Dismiss': null,
              },
            );
          }
        }
      },
    );
  }

//====================Edit Task====================//
  static void editTask({required String taskId}) {}

//====================Change Task Status====================//
  static void updateTaskStatus({
    required String taskId,
    required String taskStatus,
    required TasksController tasksController,
  }) async {
    showChangeStatusBottomSheet(
      taskId: taskId,
      taskStatus: taskStatus,
    );
  }
}