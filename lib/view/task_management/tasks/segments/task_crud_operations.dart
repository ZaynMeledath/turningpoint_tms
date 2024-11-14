import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/model/tasks_model.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/show_change_status_bottom_sheet.dart';

class TaskCrudOperations {
//====================Delete Task====================//
  static void deleteTask({
    required TasksController tasksController,
    required TaskModel taskModel,
  }) {
    final appController = Get.put(AppController());
    if (taskModel.repeat != null) {
      showGenericDialog(
        iconPath: 'assets/lotties/delete_animation.json',
        title: 'Delete all or just this?',
        content:
            'Do you want to delete all recurring tasks associated with this or just this one?',
        confirmationButtonColor: Colors.red,
        secondaryButtonBorderColor: Colors.red,
        iconWidth: 100.w,
        buttons: {
          'All Recurring': () async {
            try {
              appController.isLoadingObs.value = true;
              await tasksController.deleteTask(
                taskId: taskModel.id.toString(),
                groupId: taskModel.groupId,
              );

              appController.isLoadingObs.value = false;
//########## Task Deleted Dialog code is written inside the ws initialization method in main.dart ##########//
            } catch (_) {
              appController.isLoadingObs.value = false;
              showGenericDialog(
                iconPath: 'assets/lotties/server_error_animation.json',
                title: 'Something Went Wrong',
                content: 'Something went wrong while connecting to the server',
                buttons: {
                  'Dismiss': null,
                },
              );
            }
          },
          'Just This': () async {
            try {
              appController.isLoadingObs.value = true;
              await tasksController.deleteTask(
                taskId: taskModel.id.toString(),
              );

              appController.isLoadingObs.value = false;
//########## Task Deleted Dialog code is written inside the ws initialization method in main.dart ##########//
            } catch (_) {
              appController.isLoadingObs.value = false;
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
      return;
    }
    showGenericDialog(
      iconPath: 'assets/lotties/delete_animation.json',
      title: 'Delete Task',
      content: 'Are you sure you want to delete this task?',
      confirmationButtonColor: Colors.red,
      iconWidth: 100.w,
      buttons: {
        'Cancel': null,
        'Delete': () async {
          try {
            appController.isLoadingObs.value = true;
            await tasksController.deleteTask(
              taskId: taskModel.id.toString(),
            );

            appController.isLoadingObs.value = false;
//########## Task Deleted Dialog code is written inside the WS initialization method in main.dart ##########//
          } catch (_) {
            appController.isLoadingObs.value = false;
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
