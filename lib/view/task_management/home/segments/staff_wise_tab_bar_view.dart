part of '../tasks_dashboard.dart';

Widget staffWiseTabBarView({
  required TasksController tasksController,
}) {
  final performanceReportModelList =
      tasksController.allUsersPerformanceReportModelList.value;

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
              final name = performanceReportModel.userName?.split(' ').first;
              final tasksList =
                  tasksController.allTasksListObs.value!.where((taskModel) {
                log((taskModel.assignedTo?.first.split('@').first as String)
                    .nameFormat());
                return (taskModel.assignedTo?.first.split('@').first as String)
                        .nameFormat() ==
                    name;
              }).toList();
              Get.to(
                () => TasksScreen(
                  title: '$name\'s Tasks',
                  tasksList: tasksList,
                ),
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
                          '${performanceReportModel.userName}',
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
                          radius: 20.w,
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

                  //====================Overdue, Pending and In Progress Row====================//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            StatusIcons.overdue,
                            size: 18.w,
                            color: StatusColor.overdue,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Overdue: ',
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            '${performanceReportModel.stats?.overdueTasks ?? '-'}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            StatusIcons.open,
                            size: 18.w,
                            color: StatusColor.open,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Open: ',
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            '${performanceReportModel.stats?.openTasks ?? '-'}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            StatusIcons.inProgress,
                            size: 18.w,
                            color: StatusColor.inProgress,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'In Progress: ',
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            '${performanceReportModel.stats?.inProgressTasks ?? '-'}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),
                  //====================Completed, In Time, and Delayed Row====================//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            StatusIcons.completed,
                            size: 18.w,
                            color: StatusColor.completed,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Completed: ',
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            '${performanceReportModel.stats?.completedTasks ?? '-'}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 18.w,
                            color: StatusColor.completed,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'On Time: ',
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            '${performanceReportModel.stats?.onTimeTasks ?? '-'}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 18.w,
                            color: StatusColor.overdue,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Delayed: ',
                            style: TextStyle(
                              fontSize: 15.sp,
                            ),
                          ),
                          Text(
                            '${performanceReportModel.stats?.delayedTasks ?? '-'}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
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
    return shimmerListLoading();
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
