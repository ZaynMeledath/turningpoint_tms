part of '../assign_task_screen.dart';

Widget attachmentSegment({
  required AssignTaskController assignTaskController,
  required AudioRecorder recorder,
  required AudioPlayer audioPlayer,
  required TextEditingController reminderTimeTextController,
}) {
  final appController = Get.put(AppController());
  return Column(
    children: [
      Row(
        children: [
          // IconButton(
          //   onPressed: () async {
          //     // await showLinkDialog();
          //   },
          //   icon: Icon(
          //     Icons.link,
          //     color: Colors.white,
          //     size: 24.w,
          //   ),
          // ),

          //====================Reminder====================//
          Obx(
            () => InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                showReminderBottomSheet(
                  textController: reminderTimeTextController,
                  assignTaskController: assignTaskController,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.alarm,
                      color: Colors.white,
                      size: 25.w,
                    ),
                    assignTaskController.reminderList.isNotEmpty
                        ? Positioned(
                            bottom: 0.w,
                            right: 0.w,
                            child: Container(
                              width: 15.w,
                              height: 15.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Center(
                                child: Text(
                                  assignTaskController.reminderList.length
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 10.w,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),

          //====================Add File====================//
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () async {
              await assignTaskController.addFileAttachment();
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.upload_file,
                color: Colors.white,
                size: 25.w,
              ),
            ),
          ),
          SizedBox(width: 16.w),

          //====================Click Image====================//
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () async {
              await assignTaskController.addFileAttachment(
                useCamera: true,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 25.w,
              ),
            ),
          ),
          SizedBox(width: 16.w),

          //====================Record Audio Icon====================//
          InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () async {
              await assignTaskController.recordAudio(
                recorder: recorder,
                appController: appController,
              );
            },
            child: Obx(
              () => Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.mic,
                  color: assignTaskController.isRecordingObs.value
                      ? AppColors.themeGreen
                      : Colors.white,
                  size: 25.w,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Obx(
            () => assignTaskController.isRecordingObs.value ||
                    assignTaskController.voiceRecordPathObs.isNotEmpty ||
                    assignTaskController.voiceRecordUrlObs.isNotEmpty
                ? Row(
                    children: [
                      Container(
                        width: 140.w,
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
                        child: assignTaskController.isRecordingObs.value

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
                                      color:
                                          AppColors.themeGreen.withOpacity(.7),
                                    ),
                                  )

                                //--------------------Play Voice Record Container--------------------//
                                : Row(
                                    children: [
                                      SizedBox(width: 4.w),
                                      InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        onTap: () async {
                                          if (audioPlayer.playing) {
                                            audioPlayer.stop();
                                            assignTaskController
                                                .isPlayingObs.value = false;
                                          } else {
                                            if (assignTaskController
                                                    .voiceRecordPathObs
                                                    .isEmpty &&
                                                assignTaskController
                                                    .voiceRecordUrlObs
                                                    .isNotEmpty) {
                                              await audioPlayer.setUrl(
                                                  assignTaskController
                                                      .voiceRecordUrlObs.value);
                                            } else {
                                              await audioPlayer.setFilePath(
                                                assignTaskController
                                                    .voiceRecordPathObs.value,
                                              );
                                            }
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
                                                  .voiceRecordPositionObs
                                                  .value /
                                              (audioPlayer
                                                      .duration?.inSeconds ??
                                                  1),
                                          backgroundColor: Colors.white24,
                                          barRadius: const Radius.circular(16),
                                          progressColor: AppColors.themeGreen
                                              .withOpacity(.9),
                                        ),
                                      )
                                    ],
                                  ),
                      ),
                      SizedBox(width: 2.w),

                      //--------------------Delete Icon--------------------//
                      !assignTaskController.isRecordingObs.value &&
                              !appController.isLoadingObs.value
                          ? InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () async {
                                showGenericDialog(
                                  iconPath:
                                      'assets/lotties/delete_animation.json',
                                  title: 'Delete Recording?',
                                  content:
                                      'Are you sure you want to delete this recording?',
                                  confirmationButtonColor: Colors.red,
                                  iconWidth: 100.w,
                                  buttons: {
                                    'Cancel': null,
                                    'Delete': () async {
                                      appController.isLoadingObs.value = true;
                                      assignTaskController
                                          .voiceRecordPathObs.value = '';
                                      assignTaskController
                                          .voiceRecordUrlObs.value = '';
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
          ),
        ],
      ),
      SizedBox(height: 8.h),

//====================Attachments display section====================//
      Obx(
        () {
          final attachmentsList = assignTaskController.attachmentsListObs;
          if (attachmentsList.isNotEmpty) {
            return SizedBox(
              height: 110.h,
              width: double.maxFinite,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: attachmentsList.length,
                itemBuilder: (context, index) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 120.w,
                        height: 125.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        margin: EdgeInsets.only(right: 12.w),
                        decoration: BoxDecoration(
                          color: AppColors.textFieldColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: appController.isLoadingObs.value &&
                                  index == (attachmentsList.length - 1)
                              ? SpinKitWave(
                                  size: 25.w,
                                  color: AppColors.themeGreen,
                                )
                              : attachmentsList.isNotEmpty
                                  ? assignTaskController
                                              .attachmentsListObs[index].type ==
                                          TaskFileType.image
                                      ? AspectRatio(
                                          aspectRatio: 4 / 4,
                                          child: Image.network(
                                            attachmentsList[index].path!,
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/icons/file_icon.png',
                                              width: 52.w,
                                            ),
                                            Text(
                                              attachmentsList[index]
                                                  .path!
                                                  .split('/')
                                                  .last,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        )
                                  : attachmentsList.isNotEmpty
                                      ? Column(
                                          children: [
                                            Image.asset(
                                              'assets/icons/file_icon.png',
                                              width: 52.w,
                                            ),
                                            Text(
                                              assignTaskController
                                                  .attachmentsListObs[index]
                                                  .path!
                                                  .split('/')
                                                  .last,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        )
                                      : const SizedBox(),
                        ),
                      ),
                      Positioned(
                        right: 12.w,
                        top: 0,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            showGenericDialog(
                              iconPath: 'assets/lotties/delete_animation.json',
                              title: 'Delete File?',
                              content:
                                  'Are you sure you want to delete this file?',
                              confirmationButtonColor: Colors.red,
                              iconWidth: 100.w,
                              buttons: {
                                'Cancel': null,
                                'Delete': () async {
                                  appController.isLoadingObs.value = true;

                                  //Delete Attachment
                                  assignTaskController.attachmentsListObs
                                      .removeAt(index);
                                  try {
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
                                  } catch (_) {
                                    appController.isLoadingObs.value = false;
                                    Get.back();
                                    showGenericDialog(
                                      iconPath:
                                          'assets/lotties/server_error_animation.json',
                                      title: 'Something Went Wrong',
                                      content:
                                          'Something went wrong while deleting the recording',
                                      buttons: {'OK': null},
                                    );
                                  }
                                }
                              },
                            );
                          },
                          child: Icon(
                            Icons.close,
                            size: 24.w,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    ],
  );
}
