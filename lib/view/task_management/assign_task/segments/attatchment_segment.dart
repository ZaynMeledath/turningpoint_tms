part of '../assign_task_screen.dart';

Widget attatchmentSegment({
  required AssignTaskController assignTaskController,
  required AudioRecorder recorder,
  required AudioPlayer audioPlayer,
  required TextEditingController reminderTimeTextController,
}) {
  final appController = Get.put(AppController());
  return Row(
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
      SizedBox(width: 18.w),
      Container(
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
      SizedBox(width: 18.w),

      InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () async {
          try {
            if (assignTaskController.isRecording.value) {
              assignTaskController.voiceRecordPath.value =
                  await recorder.stop() ?? '';
              assignTaskController.isRecording.value = false;
            } else {
              if (await recorder.hasPermission()) {
                final appDir = await path.getApplicationDocumentsDirectory();
                recorder.start(
                  const RecordConfig(),
                  path: '${appDir.path}/voice_note.wav',
                );
                assignTaskController.isRecording.value = true;
              }
              if (!await recorder.hasPermission()) {
                await Permission.microphone.request();
              }
            }
          } catch (e) {
            throw Exception(e);
          }
        },
        child: Obx(
          () => Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mic,
              color: assignTaskController.isRecording.value
                  ? AppColors.themeGreen
                  : Colors.white,
              size: 25.w,
            ),
          ),
        ),
      ),
      SizedBox(width: 12.w),
      Obx(
        () => assignTaskController.isRecording.value ||
                assignTaskController.voiceRecordPath.isNotEmpty
            ? Row(
                children: [
                  Container(
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
                    child: assignTaskController.isRecording.value
                        ? Center(
                            child: Lottie.asset(
                              'assets/lotties/voice_recording_animation.json',
                            ),
                          )
                        : Row(
                            children: [
                              SizedBox(width: 4.w),
                              InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  if (audioPlayer.playing) {
                                    audioPlayer.stop();
                                    assignTaskController.isPlaying.value =
                                        false;
                                  } else {
                                    await audioPlayer.setFilePath(
                                      assignTaskController
                                          .voiceRecordPath.value,
                                    );
                                    audioPlayer.play();
                                    assignTaskController.isPlaying.value = true;
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.w),
                                  child: Icon(
                                    assignTaskController.isPlaying.value
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    size: 24.w,
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
                                          .voiceRecordPosition.value /
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
                  !assignTaskController.isRecording.value
                      ? InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () async {
                            showGenericDialog(
                              iconPath: 'assets/lotties/delete_animation.json',
                              title: 'Delete Recording?',
                              content:
                                  'Are you sure you want to delete this recording?',
                              buttons: {
                                'Cancel': null,
                                'Delete': () async {
                                  appController.isLoadingObs.value = true;
                                  assignTaskController.voiceRecordPath.value =
                                      '';
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
  );
}
