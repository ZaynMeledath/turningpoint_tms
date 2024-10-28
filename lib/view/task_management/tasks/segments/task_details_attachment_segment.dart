part of '../task_details_screen.dart';

Widget taskDetailsAttachmentSegment({
  required List<Attachment> attachments,
  required AssignTaskController assignTaskController,
  required AudioPlayer audioPlayer,
  required String audioUrl,
  required Dio dio,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Attachments',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),

      //====================Audios====================//
      audioUrl.isNotEmpty
          ? Container(
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
                        assignTaskController.isPlayingObs.value = false;
                      } else {
                        await audioPlayer.setUrl(audioUrl);
                        audioPlayer.play();
                        assignTaskController.isPlayingObs.value = true;
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      child: Icon(
                        assignTaskController.isPlayingObs.value
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
                          assignTaskController.voiceRecordPositionObs.value /
                              (audioPlayer.duration?.inSeconds ?? 1),
                      backgroundColor: Colors.white24,
                      barRadius: const Radius.circular(16),
                      progressColor: AppColors.themeGreen.withOpacity(.9),
                    ),
                  )
                ],
              ),
            )
          : const SizedBox(),
      SizedBox(height: 12.h),

//====================Files====================//
      attachments.isNotEmpty
          ? SizedBox(
              height: 110.h,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: attachments.length,
                itemBuilder: (context, index) {
                  final attachmentUrl = attachments[index].path!;
                  final attachmentType = attachments[index].type!;
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        if (attachmentType == TaskFileType.image) {
                          Get.to(
                            () => ImageViewer(imageUrl: attachmentUrl),
                            transition: Transition.zoom,
                          );
                        } else if (attachmentType == TaskFileType.video) {
                          Get.to(
                            () => TaskVideoPlayer(videoUrl: attachmentUrl),
                            transition: Transition.zoom,
                          );
                        } else {
                          await downloadFile(fileUrl: attachmentUrl);
                        }
                      },
                      child: Container(
                        width: 120.w,
                        height: 125.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textFieldColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: attachmentType == TaskFileType.image
                              ? AspectRatio(
                                  aspectRatio: 4 / 4,
                                  child: Image.network(
                                    attachmentUrl,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/file_icon.png',
                                      height: 70.w,
                                    ),
                                    Text(
                                      attachmentUrl.split('/').last,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const SizedBox(),
      SizedBox(height: 14.h),
    ],
  );
}
