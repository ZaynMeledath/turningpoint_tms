import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/assign_task_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/dialogs/show_reminders_list_dialog.dart';
import 'package:turningpoint_tms/model/all_users_model.dart';
import 'package:turningpoint_tms/model/tasks_model.dart';
import 'package:turningpoint_tms/extensions/string_extensions.dart';
import 'package:turningpoint_tms/utils/download_file.dart';
import 'package:turningpoint_tms/utils/widgets/circular_user_image.dart';
import 'package:turningpoint_tms/utils/widgets/custom_refresh_indicator.dart';
import 'package:turningpoint_tms/utils/widgets/image_viewer.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';
import 'package:turningpoint_tms/utils/widgets/task_video_player.dart';
import 'package:turningpoint_tms/view/task_management/assign_task/assign_task_screen.dart';
import 'package:turningpoint_tms/view/task_management/tasks/dialogs/show_add_personal_reminder_dialog.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/card_action_button.dart';
import 'package:turningpoint_tms/view/task_management/tasks/segments/task_crud_operations.dart';

part 'segments/title_description_container.dart';
part 'segments/task_details_assigned_container.dart';
part 'segments/task_updates_section.dart';
part 'dialogs/show_task_details_assigned_container_dialog.dart';
part 'segments/task_details_attachment_segment.dart';

class TaskDetailsScreen extends StatefulWidget {
  final TaskModel taskModel;
  final String dueDateString;

  const TaskDetailsScreen({
    required this.taskModel,
    required this.dueDateString,
    super.key,
  });

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final tasksController = Get.put(TasksController());
  final userController = Get.put(UserController());
  final assignTaskController = AssignTaskController();

  bool isTaskCompleted = false;
  String creationDateString = '';
  String audioUrl = '';
  List<Attachment> attachments = [];
  final dio = Dio();

  final user = getUserModelFromHive();
  final audioPlayer = AudioPlayer();
  late TaskModel taskModel;

  @override
  void initState() {
    taskModel = widget.taskModel;
    isTaskCompleted = taskModel.status == Status.completed;
    creationDateString = '${taskModel.createdAt?.dateFormat()}';
    setAudioAndOtherAttachments();

    if (tasksController.isDelegatedObs.value == true) {
      ever(tasksController.delegatedTasksListObs, (tasksList) {
        setAudioAndOtherAttachments();
      });
    } else if (tasksController.isDelegatedObs.value == false) {
      ever(tasksController.myTasksListObs, (tasksList) {
        setAudioAndOtherAttachments();
      });
    } else {
      ever(tasksController.allTasksListObs, (tasksList) {
        setAudioAndOtherAttachments();
      });
    }
    userController.getAssignTaskUsers();

    super.initState();
  }

//====================Set Audio and Other Attachments====================//
  void setAudioAndOtherAttachments() {
    if (taskModel.attachments != null) {
      audioUrl = taskModel.attachments!
          .firstWhere(
            (item) => item.type == TaskFileType.audio,
            orElse: () => Attachment(path: '', type: ''),
          )
          .path!;
      attachments = taskModel.attachments!
          .where(
            (item) => item.type != TaskFileType.audio,
          )
          .toList();
    }
    if (audioUrl.isNotEmpty) {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(audioUrl),
        ),
      );
    }

    audioPlayer.positionStream.listen((position) {
      tasksController.voiceRecordUrlPositionMap[
          tasksController.currentlyPlayingUrl.value] = position.inSeconds;

      if (position.inMilliseconds > 0 &&
          position.inMilliseconds == audioPlayer.duration?.inMilliseconds) {
        audioPlayer.stop();
        audioPlayer.seek(const Duration(seconds: 0));

        tasksController.voiceRecordUrlIsPlayingMap[
            tasksController.currentlyPlayingUrl.value] = false;
      }
    });
  }

  String? getAssignToProfileImage() {
    final user = userController.assignTaskUsersList.value?.firstWhere(
      (userModel) => userModel.emailId == taskModel.assignedTo?.first.emailId,
      orElse: () => AllUsersModel(),
    );
    return user?.profileImg;
  }

  String? getCreatedByProfileImage() {
    final user = userController.assignTaskUsersList.value?.firstWhere(
      (userModel) => userModel.emailId == taskModel.createdBy?.emailId,
      orElse: () => AllUsersModel(),
    );
    return user?.profileImg;
  }

  @override
  void dispose() {
    assignTaskController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        title: 'Task Details',
        trailingIcons: [
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              showRemindersListDialog(taskId: widget.taskModel.id);
            },
            icon: Icon(
              Icons.alarm,
              size: 24.w,
            ),
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              showAddPersonalReminderDialog(
                taskId: taskModel.id,
              );
            },
            icon: const Icon(Icons.alarm_add),
          ),
        ],
      ),
      body: Obx(
        () {
          try {
            if (tasksController.isDelegatedObs.value == true) {
              taskModel =
                  tasksController.delegatedTasksListObs.value!.firstWhere(
                (taskModel) => taskModel.id == widget.taskModel.id,
              );
            } else if (tasksController.isDelegatedObs.value == false) {
              taskModel = tasksController.myTasksListObs.value!.firstWhere(
                (taskModel) => taskModel.id == widget.taskModel.id,
              );
            } else {
              taskModel = tasksController.allTasksListObs.value!.firstWhere(
                (taskModel) => taskModel.id == widget.taskModel.id,
              );
            }
            isTaskCompleted = taskModel.status == Status.completed;
          } catch (_) {
            Get.back();
            showGenericDialog(
              iconPath: 'assets/lotties/deleted_animation.json',
              title: 'Task Deleted!',
              content: 'Task Successfully deleted',
              buttons: {'OK': null},
            );
          }

          return customRefreshIndicator(
            onRefresh: () async {
              if (tasksController.isDelegatedObs.value == true) {
                await tasksController.getDelegatedTasks();
              } else if (tasksController.isDelegatedObs.value == false) {
                await tasksController.getMyTasks();
              } else {
                await tasksController.getAllTasks();
              }
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 14.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleDescriptionContainer(
                      taskModel: taskModel,
                    ),
                    SizedBox(height: 14.h),

                    //====================Attachments Section====================//
                    taskModel.attachments != null &&
                            taskModel.attachments!.isNotEmpty
                        ? taskDetailsAttachmentSegment(
                            attachments: attachments,
                            tasksController: tasksController,
                            audioPlayer: audioPlayer,
                            audioUrl: audioUrl,
                            dio: dio,
                          )
                        : const SizedBox(),

                    //====================Assigned By and To Section====================//
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        taskDetailsAssignedContainer(
                          name: taskModel.createdBy != null
                              ? taskModel.createdBy!.name!.nameFormat()
                              : '-',
                          email: taskModel.createdBy != null
                              ? taskModel.createdBy!.emailId!
                              : '-',
                          // profileImg: getCreatedByProfileImage(),
                          profileImg: taskModel.createdBy?.profileImg,
                          isAssignedBy: true,
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          size: 28.w,
                        ),
                        taskDetailsAssignedContainer(
                          name: '${taskModel.assignedTo?.first.name}'
                              .nameFormat(),
                          email: '${taskModel.assignedTo?.first.emailId}',
                          // profileImg: getAssignToProfileImage(),
                          profileImg: taskModel.assignedTo?.first.profileImg,
                          isAssignedBy: false,
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),

                    //====================Action Buttons Section====================//
                    isTaskCompleted &&
                            (tasksController.isDelegatedObs.value == true ||
                                user?.role == Role.admin ||
                                taskModel.createdBy!.emailId == user!.emailId)
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                            ),
                            child: Row(
                              mainAxisAlignment: taskModel.isApproved == true
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.spaceBetween,
                              children: [
                                cardActionButton(
                                  title: 'Delete',
                                  icon: Icons.delete,
                                  iconColor: Colors.red,
                                  onTap: () {
                                    TaskCrudOperations.deleteTask(
                                      tasksController: tasksController,
                                      taskModel: taskModel,
                                    );
                                  },
                                  containerColor: Colors.grey.withOpacity(.08),
                                  containerWidth: 150.w,
                                  containerHeight: 40,
                                  iconSize: 22.sp,
                                  textSize: 14.sp,
                                ),
                                taskModel.isApproved != true
                                    ? cardActionButton(
                                        title: 'Re Open',
                                        icon: StatusIcons.inProgress,
                                        iconColor: StatusColor.open,
                                        onTap: () {
                                          TaskCrudOperations.updateTaskStatus(
                                            taskId: taskModel.id.toString(),
                                            taskStatus: Status.open,
                                            tasksController: tasksController,
                                          );
                                        },
                                        containerColor:
                                            Colors.grey.withOpacity(.08),
                                        containerWidth: 150.w,
                                        containerHeight: 40,
                                        iconSize: 22.sp,
                                        textSize: 14.sp,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          )
                        : !isTaskCompleted
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    cardActionButton(
                                      title: 'In Progress',
                                      icon: StatusIcons.inProgress,
                                      iconColor: StatusColor.inProgress,
                                      onTap: () {
                                        TaskCrudOperations.updateTaskStatus(
                                          taskId: taskModel.id.toString(),
                                          taskStatus: Status.inProgress,
                                          tasksController: tasksController,
                                        );
                                      },
                                      containerColor:
                                          Colors.grey.withOpacity(.08),
                                      containerWidth: 150.w,
                                      containerHeight: 40,
                                      iconSize: 22.sp,
                                      textSize: 14.sp,
                                    ),
                                    cardActionButton(
                                      title: 'Completed',
                                      icon: StatusIcons.completed,
                                      iconColor: StatusColor.completed,
                                      onTap: () {
                                        TaskCrudOperations.updateTaskStatus(
                                          taskId: taskModel.id.toString(),
                                          taskStatus: Status.completed,
                                          tasksController: tasksController,
                                        );
                                      },
                                      containerColor:
                                          Colors.grey.withOpacity(.08),
                                      containerWidth: 150.w,
                                      containerHeight: 40,
                                      iconSize: 22.sp,
                                      textSize: 14.sp,
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                    SizedBox(height: isTaskCompleted ? 0 : 9.h),
                    !isTaskCompleted &&
                            (tasksController.isDelegatedObs.value == true ||
                                user?.role == Role.admin ||
                                taskModel.createdBy!.emailId == user!.emailId)
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                cardActionButton(
                                  title: 'Edit',
                                  icon: Icons.edit,
                                  iconColor: Colors.blueGrey,
                                  onTap: () => Get.to(
                                    () => AssignTaskScreen(
                                      taskModel: taskModel,
                                    ),
                                    transition: Transition.downToUp,
                                  ),
                                  containerColor: Colors.grey.withOpacity(.08),
                                  containerWidth: 150.w,
                                  containerHeight: 40,
                                  iconSize: 22.sp,
                                  textSize: 14.sp,
                                ),
                                cardActionButton(
                                  title: 'Delete',
                                  icon: Icons.delete,
                                  iconColor: Colors.red,
                                  onTap: () {
                                    TaskCrudOperations.deleteTask(
                                      tasksController: tasksController,
                                      taskModel: taskModel,
                                    );
                                  },
                                  containerColor: Colors.grey.withOpacity(.08),
                                  containerWidth: 150.w,
                                  containerHeight: 40,
                                  iconSize: 22.sp,
                                  textSize: 14.sp,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    taskModel.status == Status.completed &&
                            taskModel.isApproved != true &&
                            taskModel.createdBy!.emailId == user!.emailId
                        ? Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(top: 9.h),
                              child: cardActionButton(
                                title: 'Approve',
                                icon: Icons.verified,
                                iconColor: Colors.teal,
                                onTap: () async {
                                  try {
                                    Get.dialog(
                                      SpinKitWave(
                                        size: 20.w,
                                        color: AppColors.themeGreen,
                                      ),
                                      barrierColor: Colors.black45,
                                      barrierDismissible: false,
                                    );
                                    await tasksController.approveTask(
                                        taskId: taskModel.id!);
                                    Get.back();
                                    showGenericDialog(
                                      iconPath:
                                          'assets/lotties/success_animation.json',
                                      title: 'Task Approved',
                                      content:
                                          'Task has been successfully approved',
                                      buttons: {
                                        'OK': null,
                                      },
                                    );
                                  } catch (_) {
                                    Get.back();
                                    showGenericDialog(
                                      iconPath:
                                          'assets/lotties/server_error_animation.json',
                                      title: 'Something went wrong',
                                      content:
                                          'Something went wrong while approving task',
                                      buttons: {
                                        'Dismiss': null,
                                      },
                                    );
                                  }
                                },
                                containerColor: Colors.grey.withOpacity(.08),
                                containerWidth: 150.w,
                                containerHeight: 40,
                                iconSize: 22.sp,
                                textSize: 14.sp,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: 14.h),
                    Container(
                      width: double.maxFinite,
                      height: 1,
                      color: Colors.white12,
                    ),
                    SizedBox(height: 12.h),

                    //====================Task Updates Section====================//
                    taskUpdateSection(
                      taskModel: taskModel,
                      dio: dio,
                      audioPlayer: audioPlayer,
                      tasksController: tasksController,
                      userController: userController,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
