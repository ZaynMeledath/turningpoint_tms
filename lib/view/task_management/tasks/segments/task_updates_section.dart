part of '../task_details_screen.dart';

Widget taskUpdateSection({
  required TaskModel taskModel,
  required Dio dio,
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
//====================Note and Photo Section====================//
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

                            statusChangesModel.changesAttachments != null &&
                                    statusChangesModel
                                        .changesAttachments!.isNotEmpty
                                ? Container(
                                    height: 100.h,
                                    margin: EdgeInsets.only(top: 10.h),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: statusChangesModel
                                          .changesAttachments?.length,
                                      itemBuilder: (context, index) {
                                        final changesAttachments =
                                            statusChangesModel
                                                .changesAttachments![index];
                                        return Padding(
                                          padding: EdgeInsets.only(right: 6.w),
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            onTap: () async {
                                              try {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        const SpinKitWave(
                                                          size: 20,
                                                          color: Colors.white,
                                                        ));
                                                var status = await Permission
                                                    .storage.status;
                                                if (!status.isGranted) {
                                                  await Permission.storage
                                                      .request();
                                                }
                                                final attachmentName =
                                                    changesAttachments.path!
                                                        .split('/')
                                                        .last;
                                                Directory appDocDir;
                                                if (Platform.isAndroid) {
                                                  appDocDir = Directory(
                                                      "/storage/emulated/0/Download");
                                                } else {
                                                  appDocDir =
                                                      await getApplicationDocumentsDirectory();
                                                }
                                                final savePath =
                                                    '${appDocDir.path}/$attachmentName';
                                                await dio.download(
                                                  changesAttachments.path!,
                                                  savePath,
                                                );
                                                Get.back();
                                                showGenericDialog(
                                                  iconPath:
                                                      'assets/lotties/success_animation.json',
                                                  title: 'Downloaded',
                                                  content:
                                                      'File has been downloaded to your device',
                                                  buttons: {'OK': null},
                                                );
                                              } catch (_) {
                                                showGenericDialog(
                                                  iconPath:
                                                      'assets/lotties/server_error_animation.json',
                                                  title: 'Something went wrong',
                                                  content:
                                                      'Something went wrong while downloading the file',
                                                  buttons: {'Dismiss': null},
                                                );
                                              }
                                            },
                                            child: Container(
                                              width: 120.w,
                                              height: 125.w,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.blueGrey
                                                    .withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: changesAttachments.type ==
                                                      'image'
                                                  ? AspectRatio(
                                                      aspectRatio: 16 / 9,
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            changesAttachments
                                                                .path!,
                                                      ),
                                                    )
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          'assets/icons/file_icon.png',
                                                          height: 65.w,
                                                        ),
                                                        Text(
                                                          changesAttachments
                                                              .path!
                                                              .split('/')
                                                              .last,
                                                          style: TextStyle(
                                                            fontSize: 14.sp,
                                                          ),
                                                          overflow: TextOverflow
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
