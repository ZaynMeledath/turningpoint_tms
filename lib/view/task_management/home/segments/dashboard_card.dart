part of '../tasks_dashboard.dart';

Widget dashboardCard({
  required String title,
  required int totalTasks,
  required int onTimeCompletionRate,
  required int delayedCompletionRate,
  required int? overdueCount,
  required int? openCount,
  required int? inProgressCount,
  required int? completedCount,
  required int? onTimeCount,
  required int? delayedCount,
  required int index,
  required TasksListCategory tasksListCategory,
  required String? userEmail,
  required String? category,
  required String? profileImg,
  required bool showAvatar,
}) {
  final profileImageSize = 34.w;
  return Padding(
    padding: EdgeInsets.only(
      bottom: 10.h,
      left: 12.w,
      right: 12.w,
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      highlightColor: Colors.lightBlue.withOpacity(.15),
      splashColor: Colors.lightBlue.withOpacity(.25),
      onTap: () {
        Get.to(
          () => TasksScreen(
            title: tasksListCategory == TasksListCategory.categoryWise ||
                    tasksListCategory == TasksListCategory.myReport
                ? '$title Tasks'
                : '${title.split(' ').first}\'s Tasks',
            tasksListCategory: tasksListCategory,
            delegatedUserEmail:
                tasksListCategory == TasksListCategory.categoryWise ||
                        tasksListCategory == TasksListCategory.myReport
                    ? category
                    : userEmail,
          ),
          transition: Transition.zoom,
        );
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 10.h,
        ),
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
        child: Column(
          children: [
            //====================Avatar, Name and Progress Indicator====================//
            Row(
              children: [
                if (showAvatar)
                  profileImg != null
                      ? circularUserImage(
                          imageUrl: profileImg,
                          imageSize: profileImageSize,
                          userName: title,
                        )
                      : nameLetterAvatar(
                          name: title,
                          circleDiameter: profileImageSize,
                        ),
                SizedBox(width: 7.w),
                Column(
                  children: [
                    SizedBox(height: 2.w),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 2.w),
                    SizedBox(
                      width: 200.w,
                      child: Text.rich(
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: 'Total Tasks : ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                          ),
                          children: [
                            TextSpan(
                              text: totalTasks.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),

                //--------------------On Time Progress Indicator--------------------//
                CircularPercentIndicator(
                  radius: 23.w,
                  progressColor: StatusColor.completed,
                  // progressColor: (performanceReportModel
                  //                 .stats
                  //                 ?.completionRate ??
                  //             0) <=
                  //         30
                  //     ? StatusColor.overdue
                  //     : (performanceReportModel.stats
                  //                         ?.completionRate ??
                  //                     0) >
                  //                 30 &&
                  //             (performanceReportModel
                  //                         .stats
                  //                         ?.completionRate ??
                  //                     0) <=
                  //                 60
                  //         ? StatusColor.open
                  //         : StatusColor.completed,
                  percent: onTimeCompletionRate / 100,
                  center: Text(
                    '$onTimeCompletionRate%',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: StatusColor.completed,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),

                //--------------------Delayed Progress Indicator--------------------//
                CircularPercentIndicator(
                  radius: 23.w,
                  progressColor: StatusColor.overdue,
                  // progressColor: (performanceReportModel
                  //                 .stats
                  //                 ?.completionRate ??
                  //             0) <=
                  //         30
                  //     ? StatusColor.overdue
                  //     : (performanceReportModel.stats
                  //                         ?.completionRate ??
                  //                     0) >
                  //                 30 &&
                  //             (performanceReportModel
                  //                         .stats
                  //                         ?.completionRate ??
                  //                     0) <=
                  //                 60
                  //         ? StatusColor.open
                  //         : StatusColor.completed,
                  percent: delayedCompletionRate / 100,
                  center: Text(
                    '$delayedCompletionRate%',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: StatusColor.overdue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            //====================Tasks Status Counter Section====================//
            tasksStatusCounterSection(
              overdueCount: overdueCount,
              openCount: openCount,
              inProgressCount: inProgressCount,
              completedCount: completedCount,
              onTimeCount: onTimeCount,
              delayedCount: delayedCount,
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ).animate().slideX(
            begin: index.isEven ? -.4 : .4,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.elasticOut,
          ),
    ),
  );
}
