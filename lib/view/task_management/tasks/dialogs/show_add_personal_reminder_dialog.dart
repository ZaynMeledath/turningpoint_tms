// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/assign_task_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/exceptions/tms_exceptions.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';

Future<Object?> showAddPersonalReminderDialog({
  required String? taskId,
}) async {
  return showGeneralDialog(
    context: Get.context!,
    // barrierDismissible: true,
    barrierColor: Colors.transparent,
    pageBuilder: (context, a1, a2) {
      return Container();
    },
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, a1, a2, child) {
      final curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        alignment: Alignment.topRight,
        scale: curve,
        child: AddPersonalReminderDialog(taskId: taskId),
      );
    },
  );
}

class AddPersonalReminderDialog extends StatefulWidget {
  final String? taskId;
  const AddPersonalReminderDialog({
    required this.taskId,
    super.key,
  });

  @override
  State<AddPersonalReminderDialog> createState() =>
      _AddPersonalReminderDialogState();
}

class _AddPersonalReminderDialogState extends State<AddPersonalReminderDialog> {
  final messageController = TextEditingController();
  final assignTaskController = AssignTaskController();
  final appController = AppController();
  final tasksController = Get.put(TasksController());

  @override
  void dispose() {
    messageController.dispose();
    assignTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Column(
          mainAxisAlignment: MediaQuery.of(context).viewInsets.bottom != 0
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom != 0 ? 250.h : 0,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3.0,
                sigmaY: 3.0,
              ),
              child: Container(
                // width: 300.w,
                margin: EdgeInsets.symmetric(
                  horizontal: 26.w,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.textFieldColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.blueGrey.withOpacity(.3),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            'Add a Personal Reminder',
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      customTextField(
                        controller: messageController,
                        hintText: 'Reminder Message',
                        borderColor: Colors.grey.withOpacity(.3),
                        backgroundColor: AppColors.scaffoldBackgroundColor,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //====================Date Picker Section====================//
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () async {
                              //To prevent the keyboard popping glitch
                              final currentFocus = FocusScope.of(context);
                              if (currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              assignTaskController
                                  .isTitleAndDescriptionEnabled.value = false;
                              final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030),
                              );
                              if (date != null) {
                                assignTaskController.taskDueOrStartDate.value =
                                    date;
                                assignTaskController.taskDueOrStartTime.value =
                                    await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ) ??
                                        TimeOfDay.now();
                              }
                              Future.delayed(Duration.zero, () {
                                assignTaskController
                                    .isTitleAndDescriptionEnabled.value = true;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5.w),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Container(
                                      width: 61.w,
                                      height: 61.w,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.scaffoldBackgroundColor,
                                        shape: BoxShape.circle,
                                        border: assignTaskController
                                                .showDueOrStartDateErrorTextObs
                                                .value
                                            ? Border.all(
                                                color: Colors.redAccent,
                                              )
                                            : null,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.calendar_month_rounded,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Obx(
                                    () => Text(
                                      '${assignTaskController.taskDueOrStartDate.value.day} ${DateFormat.MMMM().format(assignTaskController.taskDueOrStartDate.value)}',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),

                          //====================Time Picker Section====================//
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () async {
                              //To prevent the keyboard popping glitch
                              final currentFocus = FocusScope.of(context);
                              if (currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              assignTaskController
                                  .isTitleAndDescriptionEnabled.value = false;
                              assignTaskController.taskDueOrStartTime.value =
                                  await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ) ??
                                      TimeOfDay.now();
                              Future.delayed(Duration.zero, () {
                                assignTaskController
                                    .isTitleAndDescriptionEnabled.value = true;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5.w),
                              child: Row(
                                children: [
                                  Obx(
                                    () => Container(
                                      width: 61.w,
                                      height: 61.w,
                                      decoration: BoxDecoration(
                                        color:
                                            AppColors.scaffoldBackgroundColor,
                                        shape: BoxShape.circle,
                                        border: assignTaskController
                                                .showDueOrStartDateErrorTextObs
                                                .value
                                            ? Border.all(
                                                color: Colors.redAccent,
                                              )
                                            : null,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.access_time,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Obx(
                                    () => Text(
                                      assignTaskController
                                          .taskDueOrStartTime.value
                                          .format(context),
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(() {
                        if (assignTaskController
                            .showDueOrStartDateErrorTextObs.value) {
                          return Column(
                            children: [
                              SizedBox(height: 4.h),
                              Align(
                                // alignment: Alignment.centerRight,
                                child: Text(
                                  'Reminder Date and Time should be in the future',
                                  style: TextStyle(
                                    fontSize: 12.5.sp,
                                    color: Colors.redAccent.shade100,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                      SizedBox(height: 10.h),
                      Obx(
                        () => customButton(
                          buttonTitle: 'Add Reminder',
                          width: 148.w,
                          height: 40.w,
                          fontSize: 16.w,
                          isLoading: appController.isLoadingObs.value,
                          onTap: () async {
                            try {
                              appController.isLoadingObs.value = true;
                              await tasksController.addPersonalReminder(
                                taskId: widget.taskId,
                                message: messageController.text.trim(),
                                assignTaskController: assignTaskController,
                              );
                              appController.isLoadingObs.value = false;
                              Get.back();
                              showGenericDialog(
                                title: 'Reminder Added',
                                content: 'Personal Reminder added successfully',
                                iconPath:
                                    'assets/lotties/success_animation.json',
                                buttons: {'OK': null},
                              );
                            } on DueOrStartDateTimeErrorException {
                              appController.isLoadingObs.value = false;
                              assignTaskController
                                  .showDueOrStartDateErrorTextObs.value = true;
                            } catch (e) {
                              appController.isLoadingObs.value = false;
                              showGenericDialog(
                                title: 'Something Went Wrong',
                                content:
                                    'Something went wrong while adding a personal reminder',
                                iconPath:
                                    'assets/lotties/server_error_animation.json',
                                buttons: {'Dismiss': null},
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
