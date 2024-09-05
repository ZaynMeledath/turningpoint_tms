part of '../task_details_screen.dart';

Widget taskUpdateSection({
  required TaskModel taskModel,
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
                          color: statusAndColorMap[statusChangesModel.status]
                              ?.withOpacity(.7),
                          border: Border.all(
                            color:
                                statusAndColorMap[statusChangesModel.status] ??
                                    Colors.white24,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            statusChangesModel.status.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
//====================Note and Photo Section====================//
                  Text(
                    statusChangesModel.note ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      height: 1.2,
                    ),
                  ),

                  statusChangesModel.changesAttachments != null &&
                          statusChangesModel.changesAttachments!.isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(height: 4.h),
                            SizedBox(
                              height: 100.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: statusChangesModel
                                    .changesAttachments?.length,
                                itemBuilder: (context, index) {
                                  return AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: CachedNetworkImage(
                                      imageUrl: statusChangesModel
                                          .changesAttachments![index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            );
          },
        ),
    ],
  );
}
