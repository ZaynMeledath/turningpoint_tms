import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:record/record.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/utils/widgets/camera_screen.dart';

Future<Object?> showChangeStatusBottomSheet({
  required String taskId,
  required String taskStatus,
}) {
  return Get.bottomSheet(
    isScrollControlled: true,
    ChangeStatusBottomSheet(
      taskId: taskId,
      taskStatus: taskStatus,
    ),
  );
}

class ChangeStatusBottomSheet extends StatefulWidget {
  final String taskId;
  final String taskStatus;
  const ChangeStatusBottomSheet({
    required this.taskId,
    required this.taskStatus,
    super.key,
  });

  @override
  State<ChangeStatusBottomSheet> createState() =>
      ChangeStatusBottomSheetState();
}

class ChangeStatusBottomSheetState extends State<ChangeStatusBottomSheet> {
  late final TextEditingController textController;
  final tasksController = Get.put(TasksController());
  final appController = Get.put(AppController());
  final audioPlayer = AudioPlayer();
  final recorder = AudioRecorder();
  final GlobalKey<FormState> _formKey = GlobalKey();
  Color? taskStatusColor;

  @override
  void initState() {
    textController = TextEditingController();
    changeTaskStatusColor();
    audioPlayer.positionStream.listen((position) {
      tasksController.voiceRecordPositionObs.value = position.inSeconds;

      if (position.inMilliseconds > 0 &&
          position.inMilliseconds == audioPlayer.duration?.inMilliseconds) {
        audioPlayer.stop();
        audioPlayer.seek(const Duration(seconds: 0));

        tasksController.isPlayingObs.value = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    tasksController.taskUpdateAttachmentsFileList.clear();
    audioPlayer.dispose();
    recorder.dispose();
  }

  void changeTaskStatusColor() {
    switch (widget.taskStatus) {
      case Status.completed:
        taskStatusColor = StatusColor.completed;
        break;
      case Status.inProgress:
        taskStatusColor = StatusColor.inProgress;
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Material(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
          color: AppColors.scaffoldBackgroundColor,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //====================Title====================//
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                  child: Text(
                    'Task Update',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 1,
                  color: Colors.white12,
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Obx(
                      () => Column(
                        children: [
                          //====================Instruction and TextField====================//
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    'Please add a note before marking the task as ',
                                style: TextStyle(
                                  fontFamily: 'Lufga',
                                  fontSize: 13.sp,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.taskStatus,
                                    style: TextStyle(
                                      fontFamily: 'Lufga',
                                      fontSize: 13.5.sp,
                                      color: taskStatusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 10.h),
                          TextFormField(
                            controller: textController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Note cannot be blank';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12.h),
                          //====================Attachment====================//
                          Row(
                            children: [
                              //====================Add File Attachment====================//
                              InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  await tasksController
                                      .addFileToTaskUpdateAttachments();
                                },
                                child: Container(
                                  width: 42.w,
                                  height: 42.w,
                                  decoration: const BoxDecoration(
                                    color: Colors.black26,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.upload_file,
                                    size: 24.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),

                              //====================Add Media From Storage====================//
                              InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  await tasksController
                                      .addMediaToTaskUpdateAttachments();
                                },
                                child: Container(
                                  width: 42.w,
                                  height: 42.w,
                                  decoration: const BoxDecoration(
                                    color: Colors.black26,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.photo_rounded,
                                    size: 24.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),

                              //====================Add from Camera====================//
                              InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  Get.to(() => CameraScreen(
                                        currentRoute:
                                            '/ChangeStatusBottomSheet',
                                      ));
                                },
                                child: Container(
                                  width: 42.w,
                                  height: 42.w,
                                  decoration: const BoxDecoration(
                                    color: Colors.black26,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 24.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              //====================Record Audio====================//
                              InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  tasksController.recordAudioForTaskUpdate(
                                    recorder: recorder,
                                    appController: appController,
                                  );
                                },
                                child: Container(
                                  width: 42.w,
                                  height: 42.w,
                                  decoration: const BoxDecoration(
                                    color: Colors.black26,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.mic,
                                    size: 24.w,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              buildRecordingContainer(),
                            ],
                          ),
                          SizedBox(height: 10.h),

                          //====================Attachments Display Section====================//
                          tasksController
                                  .taskUpdateAttachmentsFileList.isNotEmpty
                              ? SizedBox(
                                  height: 170.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: tasksController
                                        .taskUpdateAttachmentsFileList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
                                            width: 110.w,
                                            height: 115.w,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12.w,
                                              vertical: 8.h,
                                            ),
                                            margin:
                                                EdgeInsets.only(right: 12.w),
                                            decoration: BoxDecoration(
                                              color: AppColors.textFieldColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: tasksController
                                                              .taskUpdateAttachmentsMapList[
                                                          index]['type'] ==
                                                      TaskFileType.image
                                                  ? AspectRatio(
                                                      aspectRatio: 4 / 4,
                                                      child: Image.file(
                                                        tasksController
                                                                .taskUpdateAttachmentsFileList[
                                                            index],
                                                      ),
                                                    )
                                                  : tasksController
                                                                  .taskUpdateAttachmentsMapList[
                                                              index]['type'] ==
                                                          TaskFileType.video
                                                      ? Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 6.w),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 54.w,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/icons/video_icon.png',
                                                                  width: 51.w,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 12.w),
                                                              Text(
                                                                tasksController
                                                                    .taskUpdateAttachmentsFileList[
                                                                        index]
                                                                    .path
                                                                    .split('/')
                                                                    .last,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 6.w),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                'assets/icons/file_icon.png',
                                                                width: 52.w,
                                                              ),
                                                              Text(
                                                                tasksController
                                                                    .taskUpdateAttachmentsFileList[
                                                                        index]
                                                                    .path
                                                                    .split('/')
                                                                    .last,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              tasksController
                                                  .taskUpdateAttachmentsFileList
                                                  .removeAt(index);
                                              tasksController
                                                  .taskUpdateAttachmentsMapList
                                                  .removeAt(index);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 24.h,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox(),

                          SizedBox(
                            height: tasksController
                                    .taskUpdateAttachmentsFileList.isNotEmpty
                                ? 12.h
                                : 24.h,
                          ),
                          //====================Update Button====================//
                          Obx(
                            () => InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () async {
                                if (appController.isLoadingObs.value) {
                                  return;
                                }
                                if (_formKey.currentState?.validate() != true) {
                                  return;
                                }
                                try {
                                  appController.isLoadingObs.value = true;
                                  await tasksController.updateTaskStatus(
                                    taskId: widget.taskId,
                                    taskStatus: widget.taskStatus,
                                    note: textController.text.trim(),
                                  );
                                  appController.isLoadingObs.value = false;
                                  Get.back();
                                  showGenericDialog(
                                    iconPath: widget.taskStatus ==
                                            Status.completed
                                        ? 'assets/lotties/task_Completed_animation.json'
                                        : 'assets/lotties/task_In Progress_animation.json',
                                    iconWidth: 55.w,
                                    repeatLottieAnimation: false,
                                    title: 'Task Status Updated',
                                    content:
                                        'Task status updated to "${widget.taskStatus}"',
                                    buttons: {
                                      'OK': null,
                                    },
                                  );
                                } catch (e) {
                                  showGenericDialog(
                                    iconPath:
                                        'assets/lotties/server_error_animation.json',
                                    title: 'Something Went Wrong',
                                    content:
                                        'Something went wrong while updating task status',
                                    buttons: {
                                      'OK': null,
                                    },
                                  );
                                  appController.isLoadingObs.value = false;
                                }
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.themeGreen,
                                ),
                                child: Center(
                                  child: appController.isLoadingObs.value
                                      ? SpinKitWave(
                                          size: 18.w,
                                          color: Colors.white,
                                        )
                                      : Text(
                                          'Update Status',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 18.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRecordingContainer() {
    return Obx(
      () => tasksController.isRecordingObs.value ||
              tasksController.voiceRecordPathObs.isNotEmpty ||
              tasksController.voiceRecordUrlListObs.isNotEmpty
          ? Row(
              children: [
                Container(
                  width: 140.w,
                  height: 50.h,
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
                  child: tasksController.isRecordingObs.value

                      //--------------------Recording Animation--------------------//
                      ? Center(
                          child: Lottie.asset(
                            'assets/lotties/voice_recording_animation.json',
                          ),
                        )
                      : appController.isLoadingObs.value
                          ? Center(
                              child: SpinKitThreeBounce(
                                size: 21.h,
                                color: AppColors.themeGreen.withOpacity(.7),
                              ),
                            )

                          //--------------------Play Voice Record Container--------------------//
                          : Row(
                              children: [
                                SizedBox(width: 4.w),
                                InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () async {
                                    if (audioPlayer.playing) {
                                      audioPlayer.stop();
                                      tasksController.isPlayingObs.value =
                                          false;
                                    } else {
                                      if (tasksController
                                              .voiceRecordPathObs.isEmpty &&
                                          tasksController.voiceRecordUrlListObs
                                              .isNotEmpty) {
                                        await audioPlayer.setUrl(tasksController
                                            .voiceRecordUrlListObs[0]);
                                      } else {
                                        await audioPlayer.setFilePath(
                                          tasksController
                                              .voiceRecordPathObs.value,
                                        );
                                      }
                                      audioPlayer.play();
                                      tasksController.isPlayingObs.value = true;
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4.w),
                                    child: Icon(
                                      tasksController.isPlayingObs.value
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 24.w,
                                      color:
                                          AppColors.themeGreen.withOpacity(.8),
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
                                    percent: tasksController
                                            .voiceRecordPositionObs.value /
                                        (audioPlayer.duration?.inSeconds ?? 1),
                                    backgroundColor: Colors.white24,
                                    barRadius: const Radius.circular(16),
                                    progressColor:
                                        AppColors.themeGreen.withOpacity(.9),
                                  ),
                                )
                              ],
                            ),
                ),
                SizedBox(width: 2.w),

                //--------------------Delete Icon--------------------//
                !tasksController.isRecordingObs.value &&
                        !appController.isLoadingObs.value
                    ? InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () async {
                          showGenericDialog(
                            iconPath: 'assets/lotties/delete_animation.json',
                            title: 'Delete Recording?',
                            content:
                                'Are you sure you want to delete this recording?',
                            confirmationButtonColor: Colors.red,
                            iconWidth: 100.w,
                            buttons: {
                              'Cancel': null,
                              'Delete': () async {
                                appController.isLoadingObs.value = true;
                                tasksController.voiceRecordPathObs.value = '';
                                tasksController.voiceRecordUrlListObs.clear();
                                await audioPlayer.seek(
                                  const Duration(seconds: 0),
                                );
                                audioPlayer.stop();
                                appController.isLoadingObs.value = false;
                                Get.back();

                                showGenericDialog(
                                  iconPath:
                                      'assets/lotties/deleted_animation.json',
                                  title: 'Deleted',
                                  content:
                                      'Recording has been successfully deleted',
                                  buttons: {'OK': null},
                                );
                              }
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                            size: 22.w,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            )
          : SizedBox(height: 52.h),
    );
  }
}
