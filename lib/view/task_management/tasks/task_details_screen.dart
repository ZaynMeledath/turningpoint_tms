import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/controller/assign_task_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/model/tasks_model.dart';
import 'package:turning_point_tasks_app/extensions/string_extensions.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/view/task_management/assign_task/assign_task_screen.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/card_action_button.dart';
import 'package:turning_point_tasks_app/view/task_management/tasks/segments/task_crud_operations.dart';

part 'segments/title_description_container.dart';
part 'segments/task_details_assigned_container.dart';
part 'segments/task_updates_section.dart';

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
  bool isTaskCompleted = false;
  String creationDateString = '';
  List<dynamic> audioList = [];

  final user = getUserModelFromHive();
  final assignTaskController = AssignTaskController();
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    isTaskCompleted = widget.taskModel.status == Status.completed;
    creationDateString = '${widget.taskModel.createdAt?.dateFormat()}';
    audioList = widget.taskModel.attachments!
        .where((item) => item.split('.').last == 'wav')
        .toList();
    if (audioList.isNotEmpty) {
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(audioList.first),
        ),
      );
    }
    super.initState();
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 14.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleDescriptionContainer(
                taskModel: widget.taskModel,
                dueDateString: widget.dueDateString,
                creationDateString: creationDateString,
              ),
              SizedBox(height: 14.h),

              //====================Attachments Section====================//
              widget.taskModel.attachments!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attachments',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        audioList.isNotEmpty
                            ? Container(
                                width: 180.w,
                                height: 52.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromRGBO(48, 78, 85, .4),
                                      Color.fromRGBO(29, 36, 41, 1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 4.w),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(100),
                                      onTap: () async {
                                        if (audioPlayer.playing) {
                                          audioPlayer.stop();
                                          assignTaskController
                                              .isPlayingObs.value = false;
                                        } else {
                                          await audioPlayer.setFilePath(
                                            assignTaskController
                                                .voiceRecordPathObs.value,
                                          );
                                          audioPlayer.play();
                                          assignTaskController
                                              .isPlayingObs.value = true;
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4.w),
                                        child: Icon(
                                          assignTaskController
                                                  .isPlayingObs.value
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          size: 24.w,
                                          color: AppColors.themeGreen
                                              .withOpacity(.8),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: LinearPercentIndicator(
                                        padding: EdgeInsets.only(
                                          left: 2.w,
                                          right: 12.w,
                                        ),
                                        lineHeight: 8.h,
                                        percent: assignTaskController
                                                .voiceRecordPositionObs.value /
                                            (audioPlayer.duration?.inSeconds ??
                                                1),
                                        backgroundColor: Colors.white24,
                                        barRadius: const Radius.circular(16),
                                        progressColor: AppColors.themeGreen
                                            .withOpacity(.9),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(height: 14.h),
                      ],
                    )
                  : const SizedBox(),

              //====================Assigned By and To Section====================//
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  taskDetailsAssignedContainer(
                    name: widget.taskModel.createdBy
                        .toString()
                        .split('@')[0]
                        .toUpperCase(),
                    email: widget.taskModel.createdBy.toString(),
                    isAssignedBy: true,
                  ),
                  Icon(
                    Icons.arrow_right_alt,
                    size: 28.w,
                  ),
                  taskDetailsAssignedContainer(
                    name: '${widget.taskModel.assignedTo?.first}'
                        .split('@')[0]
                        .toUpperCase(),
                    email: '${widget.taskModel.assignedTo?.first}',
                    isAssignedBy: false,
                  ),
                ],
              ),
              SizedBox(height: 14.h),

              //====================Action Buttons Section====================//
              isTaskCompleted &&
                      (tasksController.isDelegatedObs.value ||
                          user?.role == Role.admin)
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cardActionButton(
                            title: 'Delete',
                            icon: Icons.delete,
                            iconColor: Colors.red,
                            onTap: () => TaskCrudOperations.deleteTask(
                              tasksController: tasksController,
                              taskModel: widget.taskModel,
                            ),
                            containerColor: Colors.grey.withOpacity(.08),
                            containerWidth: 150.w,
                            containerHeight: 40,
                            iconSize: 22.sp,
                            textSize: 14.sp,
                          ),
                          cardActionButton(
                            title: 'Re Open',
                            icon: StatusIcons.inProgress,
                            iconColor: StatusColor.open,
                            onTap: () => TaskCrudOperations.updateTaskStatus(
                              taskId: widget.taskModel.id.toString(),
                              taskStatus: Status.open,
                              tasksController: tasksController,
                            ),
                            containerColor: Colors.grey.withOpacity(.08),
                            containerWidth: 150.w,
                            containerHeight: 40,
                            iconSize: 22.sp,
                            textSize: 14.sp,
                          ),
                        ],
                      ),
                    )
                  : !isTaskCompleted
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cardActionButton(
                                title: 'In Progress',
                                icon: StatusIcons.inProgress,
                                iconColor: StatusColor.inProgress,
                                onTap: () =>
                                    TaskCrudOperations.updateTaskStatus(
                                  taskId: widget.taskModel.id.toString(),
                                  taskStatus: Status.inProgress,
                                  tasksController: tasksController,
                                ),
                                containerColor: Colors.grey.withOpacity(.08),
                                containerWidth: 150.w,
                                containerHeight: 40,
                                iconSize: 22.sp,
                                textSize: 14.sp,
                              ),
                              cardActionButton(
                                title: 'Completed',
                                icon: StatusIcons.completed,
                                iconColor: StatusColor.completed,
                                onTap: () =>
                                    TaskCrudOperations.updateTaskStatus(
                                  taskId: widget.taskModel.id.toString(),
                                  taskStatus: Status.completed,
                                  tasksController: tasksController,
                                ),
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
              SizedBox(height: isTaskCompleted ? 0 : 9.h),
              !isTaskCompleted &&
                      (tasksController.isDelegatedObs.value ||
                          user?.role == Role.admin)
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
                                taskModel: widget.taskModel,
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
                            onTap: () => TaskCrudOperations.deleteTask(
                              tasksController: tasksController,
                              taskModel: widget.taskModel,
                            ),
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
              SizedBox(height: 14.h),
              Container(
                width: double.maxFinite,
                height: 1,
                color: Colors.white12,
              ),
              SizedBox(height: 12.h),

              //====================Task Updates Section====================//
              taskUpdateSection(taskModel: widget.taskModel),
            ],
          ),
        ),
      ),
    );
  }
}
