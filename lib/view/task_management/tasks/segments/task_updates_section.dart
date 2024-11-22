part of '../task_details_screen.dart';

Widget taskUpdateSection({
  required TaskModel taskModel,
  required Dio dio,
  required AudioPlayer audioPlayer,
  required TasksController tasksController,
}) {
  final statusChangesList = taskModel.statusChanges ?? [];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Task Updates',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          height: 1,
        ),
      ),
      SizedBox(height: 14.h),
      statusChangesList.isNotEmpty
          ? Column(
              children: [
                for (int i = 0; i < statusChangesList.length; i++)
                  Builder(
                    builder: (context) {
                      final statusChangesModel = statusChangesList[i];
                      final audioUrl = statusChangesModel.changesAttachments!
                          .firstWhere(
                            (element) => element.type == TaskFileType.audio,
                            orElse: () => Attachment(),
                          )
                          .path;
                      final fileAttachmentsList = statusChangesModel
                          .changesAttachments!
                          .where(
                              (element) => element.type != TaskFileType.audio)
                          .toList();
                      return Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 8.h,
                        ),
                        margin: EdgeInsets.only(bottom: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(48, 78, 85, .4),
                              Color.fromRGBO(29, 36, 41, 1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: Colors.grey.withOpacity(.3),
                          ),
                        ),
                        child: Column(
                          children: [
//====================Avatar, Name, Time and Task Update Sections====================//
                            Row(
                              children: [
                                // statusChangesModel.taskUpdatedBy?.profileImg !=
                                //         null
                                //     ? circularUserImage(
                                //         imageUrl: statusChangesModel
                                //             .taskUpdatedBy!.profileImg!,
                                //         imageSize: profileImageSize,
                                //       )
                                //     :
                                //  nameLetterAvatar(
                                //     name:
                                //         '${statusChangesModel.taskUpdatedBy?.name}',
                                //     circleDiameter: profileImageSize,
                                //   ),
                                nameLetterAvatar(
                                  name:
                                      '${statusChangesModel.taskUpdatedBy?.split('@').first}',
                                  circleDiameter: 34.w,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 180.w,
                                      child: Text(
                                        statusChangesModel.taskUpdatedBy
                                                ?.split('@')
                                                .first
                                                .nameFormat() ??
                                            '',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          height: 1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '${statusChangesModel.changedAt?.dateFormat()}',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white54,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const Expanded(child: SizedBox()),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: statusAndColorMap[
                                            statusChangesModel.status]
                                        ?.withOpacity(.4),
                                    border: Border.all(
                                      color: statusAndColorMap[
                                                  statusChangesModel.status]
                                              ?.withOpacity(.7) ??
                                          Colors.white24,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      statusChangesModel.status == Status.open
                                          ? 'Re-Opened'
                                          : statusChangesModel.status
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
//====================Note and Attachments Section====================//
                            SizedBox(height: 6.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 6.w,
                                  top: 11.h,
                                ),
                                child: Text(
                                  statusChangesModel.note ?? '',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            if (audioUrl != null && audioUrl.isNotEmpty)
                              buildAudioContainer(
                                tasksController: tasksController,
                                audioPlayer: audioPlayer,
                                audioUrl: audioUrl,
                              ),

                            fileAttachmentsList.isNotEmpty
                                ? Container(
                                    height: 102.w,
                                    margin: EdgeInsets.only(top: 10.h),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: fileAttachmentsList.length,
                                      itemBuilder: (context, index) {
                                        final changesAttachment =
                                            fileAttachmentsList[index];
                                        return Padding(
                                          padding: EdgeInsets.only(right: 6.w),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            onTap: () async {
                                              if (changesAttachment.type ==
                                                  TaskFileType.image) {
                                                Get.to(
                                                  () => ImageViewer(
                                                      imageUrl:
                                                          changesAttachment
                                                              .path!),
                                                  transition: Transition.zoom,
                                                );
                                              } else if (changesAttachment
                                                      .type ==
                                                  TaskFileType.video) {
                                                Get.to(
                                                  () => TaskVideoPlayer(
                                                      videoUrl:
                                                          changesAttachment
                                                              .path!),
                                                  transition: Transition.zoom,
                                                );
                                              } else {
                                                downloadFile(
                                                    fileUrl: changesAttachment
                                                        .path!);
                                              }
                                            },
                                            child: Container(
                                              width: 120.w,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 4.w,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey
                                                    .withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: changesAttachment.type ==
                                                      TaskFileType.image
                                                  ? AspectRatio(
                                                      aspectRatio: 16 / 9,
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            changesAttachment
                                                                .path!,
                                                      ),
                                                    )
                                                  : changesAttachment.type ==
                                                          TaskFileType.video
                                                      ? Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height: 50.w,
                                                              child:
                                                                  Image.asset(
                                                                'assets/icons/video_icon.png',
                                                                width: 48.w,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 12.w),
                                                            Text(
                                                              changesAttachment
                                                                  .path!
                                                                  .split('/')
                                                                  .last,
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          ],
                                                        )
                                                      : Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'assets/icons/file_icon.png',
                                                              height: 60.w,
                                                            ),
                                                            SizedBox(height: 4),
                                                            Text(
                                                              changesAttachment
                                                                  .path!
                                                                  .split('/')
                                                                  .last,
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          ],
                                                        ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            )
          : Center(
              child: Lottie.asset(
                'assets/lotties/empty_list_animation.json',
                width: 150.w,
              ),
            ),
    ],
  );
}

Widget buildAudioContainer({
  required TasksController tasksController,
  required AudioPlayer audioPlayer,
  required String audioUrl,
}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Obx(
      () => Container(
        width: 180.w,
        height: 52.h,
        margin: EdgeInsets.only(top: 6.h),
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
                  tasksController.currentlyPlayingUrl.value = '';
                  tasksController.voiceRecordUrlIsPlayingMap[audioUrl] = false;
                } else {
                  await audioPlayer.setUrl(audioUrl);
                  audioPlayer.play();
                  tasksController.currentlyPlayingUrl.value = audioUrl;
                  tasksController.voiceRecordUrlIsPlayingMap[audioUrl] = true;
                }
              },
              child: Container(
                padding: EdgeInsets.all(4.w),
                child: Icon(
                  tasksController.voiceRecordUrlIsPlayingMap[audioUrl] == true
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 24.w,
                  color: AppColors.themeGreen.withOpacity(.8),
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
                percent:
                    (tasksController.voiceRecordUrlPositionMap[audioUrl] ?? 0) /
                        (audioPlayer.duration?.inSeconds ?? 1),
                backgroundColor: Colors.white24,
                barRadius: const Radius.circular(16),
                progressColor: AppColors.themeGreen.withOpacity(.9),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
