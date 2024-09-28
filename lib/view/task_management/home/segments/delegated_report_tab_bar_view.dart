part of '../tasks_dashboard.dart';

Widget delegatedReportTabBarView({
  required TasksController tasksController,
}) {
  final performanceReportModelList =
      tasksController.delegatedPerformanceReportModelList.value;

  if (performanceReportModelList != null &&
      performanceReportModelList.isNotEmpty) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: 8.h,
        bottom: 66.h,
      ),
      itemCount: performanceReportModelList.length,
      itemBuilder: (context, index) {
        final performanceReportModel = performanceReportModelList[index];
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
              tasksController.addToDashboardTasksList(
                  tasksList: tasksController.delegatedTasksListObs.value!
                      .where((item) =>
                          item.assignedTo?.first ==
                          performanceReportModel.userName)
                      .toList());

              final name = performanceReportModel.userName
                  ?.split('@')
                  .first
                  .nameFormat();
              Get.to(
                () => TasksScreen(
                  title: '$name\'s Tasks',
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
                      nameLetterAvatar(
                        name: '${performanceReportModel.userName}',
                        circleDiameter: 34.w,
                      ),
                      SizedBox(width: 7.w),
                      SizedBox(
                        width: 220.w,
                        child: Text(
                          '${performanceReportModel.userName?.split('@').first.nameFormat()}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        width: 52.w,
                        height: 52.w,
                        child: CircularPercentIndicator(
                          radius: 22.5.w,
                          progressColor: (performanceReportModel
                                          .stats?.completionRate ??
                                      0) <=
                                  30
                              ? StatusColor.overdue
                              : (performanceReportModel.stats?.completionRate ??
                                              0) >
                                          30 &&
                                      (performanceReportModel
                                                  .stats?.completionRate ??
                                              0) <=
                                          60
                                  ? StatusColor.open
                                  : StatusColor.completed,
                          percent:
                              (performanceReportModel.stats?.completionRate ??
                                      0) /
                                  100,
                          center: Text(
                            '${performanceReportModel.stats?.completionRate ?? '-'}%',
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),

                  //====================Tasks Status Counter Section====================//
                  tasksStatusCounterSection(
                    overdueCount: performanceReportModel.stats?.overdueTasks,
                    openCount: performanceReportModel.stats?.openTasks,
                    inProgressCount:
                        performanceReportModel.stats?.inProgressTasks,
                    completedCount:
                        performanceReportModel.stats?.completedTasks,
                    onTimeCount: performanceReportModel.stats?.onTimeTasks,
                    delayedCount: performanceReportModel.stats?.delayedTasks,
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
      },
    );
  } else if (performanceReportModelList == null) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: shimmerListLoading(),
    );
  } else {
    return Column(
      children: [
        SizedBox(height: 50.h),
        Lottie.asset(
          'assets/lotties/empty_list_animation.json',
          width: 150.w,
        ),
      ],
    );
  }
}
