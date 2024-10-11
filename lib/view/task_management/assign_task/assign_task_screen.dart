import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/assign_task_controller.dart';
import 'package:turningpoint_tms/controller/filter_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/exceptions/tms_exceptions.dart';
import 'package:turningpoint_tms/model/tasks_model.dart';
import 'package:turningpoint_tms/service/api/api_exceptions.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';
import 'package:record/record.dart';

part 'segments/title_text_field.dart';
part 'segments/description_text_field.dart';
part 'segments/assign_to_and_category_segment.dart';
part 'segments/priority_tab_bar.dart';
part 'segments/date_and_time_segment.dart';
part 'segments/repeat_frequency_section.dart';
part 'segments/weekly_frequency_segment.dart';
part 'segments/monthly_frequency_segment.dart';
part 'segments/attachment_segment.dart';
part 'segments/swipe_to_add.dart';
// part 'dialogs/show_link_dialog.dart';
part 'dialogs/show_assign_to_dialog.dart';
part 'dialogs/show_category_dialog.dart';
part 'dialogs/show_reminder_bottom_sheet.dart';
part 'dialogs/show_add_category_bottom_sheet.dart';

class AssignTaskScreen extends StatefulWidget {
  final TaskModel? taskModel;
  const AssignTaskScreen({
    this.taskModel,
    super.key,
  });

  @override
  State<AssignTaskScreen> createState() => _AssignTaskScreenState();
}

class _AssignTaskScreenState extends State<AssignTaskScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController assignToSearchController;
  late final TextEditingController categorySearchController;
  late final TextEditingController reminderTimeTextController;
  late final TextEditingController categoryNameController;
  final filterController = FilterController();
  final assignTaskController = AssignTaskController();
  final tasksController = TasksController();
  final recorder = AudioRecorder();
  final audioPlayer = AudioPlayer();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    assignToSearchController = TextEditingController();
    categorySearchController = TextEditingController();
    categoryNameController = TextEditingController();
    reminderTimeTextController = TextEditingController(
        text: DefaultReminder.defaultReminderTime.toString());

    if (widget.taskModel != null) {
      assignPreviousValues();
    }

    audioPlayer.positionStream.listen((position) {
      assignTaskController.voiceRecordPositionObs.value = position.inSeconds;

      if (position.inMilliseconds > 0 &&
          position.inMilliseconds == audioPlayer.duration?.inMilliseconds) {
        audioPlayer.stop();
        audioPlayer.seek(const Duration(seconds: 0));

        assignTaskController.isPlayingObs.value = false;
      }
    });

    super.initState();
  }

  void assignPreviousValues() {
    titleController.text = widget.taskModel!.title ?? '';
    descriptionController.text = widget.taskModel!.description ?? '';
    for (AssignedTo assignedTo in widget.taskModel!.assignedTo!) {
      assignTaskController.assignToMap.addAll({
        assignedTo.emailId!: AssignedTo(
          name: assignedTo.name,
          emailId: assignedTo.emailId,
          phone: assignedTo.phone,
        ),
      });
    }
    assignTaskController.selectedCategory.value =
        widget.taskModel?.category ?? '';
    assignTaskController.taskPriority.value =
        widget.taskModel!.priority ?? TaskPriority.low;
    assignTaskController.taskDate.value =
        DateTime.parse(widget.taskModel!.dueDate!);
    assignTaskController.taskTime.value =
        TimeOfDay.fromDateTime(assignTaskController.taskDate.value);

    //### Add Repeat and attachments also ###//
    assignTaskController.reminderList.value = widget.taskModel!.reminders ?? [];
    if (widget.taskModel!.attachments != null) {
      assignTaskController.voiceRecordUrlObs.value =
          widget.taskModel!.attachments!
              .firstWhere(
                (attachment) => attachment.type == 'audio',
                orElse: () => Attachment(path: '', type: ''),
              )
              .path!;

      assignTaskController.attachmentsListObs.value = widget
          .taskModel!.attachments!
          .where((attachment) => attachment.type != 'audio')
          .toList();
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    assignToSearchController.dispose();
    categorySearchController.dispose();
    reminderTimeTextController.dispose();
    assignTaskController.dispose();
    recorder.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        appBar: myAppBar(title: ''),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 4.5.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        text: 'Create\nNew ',
                        style: TextStyle(
                          fontFamily: 'Lufga',
                          fontSize: 32.sp,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(
                            text: 'Task',
                            style: TextStyle(
                              fontFamily: 'Lufga',
                              fontSize: 32.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ).animate().slideY(
                          begin: 1,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.elasticOut,
                        ),
                  ),
                  SizedBox(height: 30.h),
                  titleTextField(
                    titleController: titleController,
                    assignTaskController: assignTaskController,
                  ).animate().slideY(
                        begin: 1,
                        delay: const Duration(milliseconds: 40),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                  SizedBox(height: 32.h),
                  descriptionTextField(
                    descriptionController: descriptionController,
                    assingTaskController: assignTaskController,
                  ).animate().slideY(
                        begin: 1,
                        delay: const Duration(milliseconds: 80),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                  SizedBox(height: 28.h),
                  assignToAndCategorySegment(
                    assignTaskController: assignTaskController,
                    tasksController: tasksController,
                    filterController: filterController,
                    assignToSearchController: assignToSearchController,
                    categoryNameController: categoryNameController,
                    categorySearchController: categorySearchController,
                  ).animate().slideY(
                        begin: 1,
                        delay: const Duration(milliseconds: 120),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                  SizedBox(height: 28.h),
                  priorityTabBar(
                    tabController: tabController,
                    assignTaskController: assignTaskController,
                  ).animate().slideY(
                        begin: 1,
                        delay: const Duration(milliseconds: 160),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                  SizedBox(height: 28.h),
                  dateAndTimeSegment(
                    context: context,
                    assignTaskController: assignTaskController,
                  ).animate().slideY(
                        begin: 1,
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                  SizedBox(height: 12.h),
                  repeatFrequencySection(
                    assignTaskController: assignTaskController,
                  ).animate().slideY(
                        begin: 1,
                        delay: const Duration(milliseconds: 240),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                  Obx(
                    () => SizedBox(
                      height: assignTaskController.shouldRepeatTask.value
                          ? 12.h
                          : 0,
                    ),
                  ),
                  attachmentSegment(
                    assignTaskController: assignTaskController,
                    recorder: recorder,
                    audioPlayer: audioPlayer,
                    reminderTimeTextController: reminderTimeTextController,
                  ).animate().slideY(
                        begin: 1,
                        delay: const Duration(milliseconds: 280),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                  SizedBox(height: 85.h),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: swipeToAdd(
          assignTaskController: assignTaskController,
          taskTitle: titleController.text.trim(),
          taskDescription: descriptionController.text.trim(),
          formKey: _formKey,
          isUpdating: widget.taskModel != null,
          taskModel: widget.taskModel,
        ).animate().slideY(
              begin: 1,
              delay: const Duration(milliseconds: 280),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.elasticOut,
            ),
      ),
    );
  }
}
