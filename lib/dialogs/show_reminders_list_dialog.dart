// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/extensions/string_extensions.dart';
import 'package:turningpoint_tms/model/tasks_model.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/show_add_personal_reminder_dialog.dart';
import 'package:turningpoint_tms/view/task_management/tasks/task_details_screen.dart';

Future<Object?> showRemindersListDialog({
  String? taskId,
}) async {
  return showGeneralDialog(
    context: Get.context!,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, _, __) => RemindersListDialog(taskId: taskId),
    transitionBuilder: (context, animation, _, child) {
      final curve = Curves.easeInOut.transform(animation.value);
      return Transform.scale(
        alignment: Alignment.topCenter,
        scale: curve,
        child: child,
      );
    },
  );
}

class RemindersListDialog extends StatefulWidget {
  final String? taskId;
  const RemindersListDialog({
    this.taskId,
    super.key,
  });

  @override
  State<RemindersListDialog> createState() => _RemindersListDialogState();
}

class _RemindersListDialogState extends State<RemindersListDialog> {
  final tasksController = Get.put(TasksController());
  final appController = Get.put(AppController());
  final GlobalKey _containerKey = GlobalKey();
  double _mainContainerHeight = 200.w;
  final user = getUserModelFromHive();

  final List<String> monthList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  void initState() {
    super.initState();
    tasksController.getPersonalRemindersList();
    _updateContainerHeight();
    ever(tasksController.allPersonalRemindersListObs,
        (allPersonalRemindersList) {
      tasksController.personalRemindersListObs.value = widget.taskId != null
          ? allPersonalRemindersList!
              .where((personalReminder) =>
                  personalReminder.task?.id == widget.taskId)
              .toList()
          : allPersonalRemindersList;
      _updateContainerHeight();
    });
  }

  void _updateContainerHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final remindersListLength =
          tasksController.personalRemindersListObs.value?.length ?? 5;

      if (remindersListLength > 0 && _containerKey.currentContext != null) {
        final renderBox =
            _containerKey.currentContext!.findRenderObject() as RenderBox;
        final subContainerHeight = renderBox.size.height;
        final screenHeight = MediaQuery.of(Get.context!).size.height;

        setState(() {
          _mainContainerHeight =
              (remindersListLength * (subContainerHeight + 10)) + 115.w;
          _mainContainerHeight = _mainContainerHeight > (screenHeight - 350.h)
              ? screenHeight - 350.h
              : _mainContainerHeight;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(color: Colors.transparent),
          ),
          Column(
            children: [
              SizedBox(height: 64.w),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Obx(() {
                  return Container(
                    height: _mainContainerHeight,
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.scaffoldBackgroundColor,
                      border:
                          Border.all(color: Colors.blueGrey.withOpacity(.2)),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          _buildDialogHeader(),
                          Expanded(
                            child: tasksController
                                            .personalRemindersListObs.value !=
                                        null &&
                                    tasksController.personalRemindersListObs
                                        .value!.isNotEmpty
                                ? _buildRemindersList()
                                : tasksController
                                            .personalRemindersListObs.value ==
                                        null
                                    ? const SizedBox()
                                    : _buildEmptyState(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 8.w,
                            ),
                            child: customButton(
                              buttonTitle: 'New Reminder',
                              onTap: () {
                                Get.back();
                                showAddPersonalReminderDialog(taskId: null);
                              },
                              fontSize: 14.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDialogHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.w),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios_new, size: 24.w),
          ),
          Text(
            'Reminders',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Text(
                  '<< Swipe the card for options',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white60,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemindersList() {
    return Obx(
      () => ListView.builder(
        itemCount: tasksController.personalRemindersListObs.value!.length,
        itemBuilder: (context, index) {
          final reminder =
              tasksController.personalRemindersListObs.value![index];
          final reminderDate = DateTime.parse(reminder.reminderDate!).toLocal();
          final timeSuffix = reminderDate.hour >= 12 ? 'PM' : 'AM';
          final hour =
              reminderDate.hour % 12 == 0 ? 12 : reminderDate.hour % 12;

          return Padding(
            padding: EdgeInsets.only(
              right: 12.w,
              left: 12.w,
              bottom: 10.w,
            ),
            child: Slidable(
              key: index == 0 ? _containerKey : null,
              closeOnScroll: true,
              endActionPane: ActionPane(
                extentRatio: .5,
                motion: const DrawerMotion(),
                children: _buildSlidableActions(index),
              ),
              child:
                  _buildReminderCard(reminder, reminderDate, hour, timeSuffix),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildSlidableActions(int index) {
    return [
      if (tasksController.personalRemindersListObs.value![index].task != null)
        SlidableAction(
          onPressed: (_) {
            TaskModel taskModel = TaskModel();
            if (user!.role == Role.user) {
              taskModel = tasksController.myTasksListObs.value!.firstWhere(
                (taskModel) =>
                    taskModel.id ==
                    tasksController
                        .personalRemindersListObs.value![index].task!.id,
                orElse: () => TaskModel(),
              );
            } else {
              taskModel = tasksController.allTasksListObs.value!.firstWhere(
                (taskModel) =>
                    taskModel.id ==
                    tasksController
                        .personalRemindersListObs.value![index].task!.id,
                orElse: () => TaskModel(),
              );
            }
            final dueDateString = taskModel.dueDate!.dateFormat();
            Get.to(
              () => TaskDetailsScreen(
                taskModel: taskModel,
                dueDateString: dueDateString,
              ),
              transition: Transition.rightToLeftWithFade,
            );
          },
          borderRadius: BorderRadius.circular(12),
          backgroundColor: AppColors.themeGreen,
          foregroundColor: Colors.white,
          icon: Icons.task_alt,
          label: 'Task',
        ),
      SlidableAction(
        onPressed: (_) {
          showGenericDialog(
            iconPath: 'assets/lotties/delete_animation.json',
            title: 'Delete Reminder',
            content: 'Are you sure you want to delete the reminder?',
            buttons: {
              'Cancel': null,
              'Delete': () async {
                try {
                  appController.isLoadingObs.value = true;
                  await tasksController.deletePersonalReminder(
                      reminderId: tasksController
                          .personalRemindersListObs.value![index].id!);
                  appController.isLoadingObs.value = false;
                  Get.back();
                  showGenericDialog(
                    iconPath: 'assets/lotties/deleted_animation.json',
                    title: 'Reminder Deleted',
                    content: 'Reminder has been deleted successfully',
                    buttons: {
                      'OK': null,
                    },
                  );
                } catch (_) {
                  showGenericDialog(
                    iconPath: 'assets/lotties/server_error_animation.json',
                    title: 'Something Went Wrong',
                    content: 'Something went wrong while deleting the reminder',
                    buttons: {
                      'Dismiss': null,
                    },
                  );
                }
              },
            },
          );
        },
        borderRadius: BorderRadius.circular(12),
        backgroundColor: StatusColor.overdue,
        icon: Icons.delete,
        label: 'Delete',
      ),
    ];
  }

  Widget _buildReminderCard(
      reminder, DateTime reminderDate, int hour, String timeSuffix) {
    final hourString = hour.toString().padLeft(2, '0');
    final minuteString = reminderDate.minute.toString().padLeft(2, '0');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(48, 78, 85, .4),
            Color.fromRGBO(29, 36, 41, 1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.blueGrey.withOpacity(.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reminder.message.toString(), style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 4.w),
          Row(
            children: [
              Text('${reminderDate.day} ${monthList[reminderDate.month - 1]}',
                  style: TextStyle(fontSize: 16.sp)),
              SizedBox(width: 12.w),
              Icon(Icons.alarm, size: 18.w, color: AppColors.themeGreen),
              SizedBox(width: 3.w),
              Text('$hourString:$minuteString $timeSuffix',
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Lottie.asset(
      'assets/lotties/empty_list_animation.json',
      width: 105.w,
    );
  }
}
