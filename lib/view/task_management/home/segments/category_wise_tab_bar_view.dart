part of '../tasks_dashboard.dart';

Widget categoryWiseTabBarView({
  required TasksController tasksController,
}) {
  final performanceReportModelList =
      tasksController.allCategoriesPerformanceReportModelList.value;

  if (performanceReportModelList != null &&
      performanceReportModelList.isNotEmpty) {
    return ListView.builder(
      itemCount: performanceReportModelList.length,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: 8.h,
        bottom: 66.h,
      ),
      itemBuilder: (context, index) {
        final performanceReportModel = performanceReportModelList[index];
        return Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(bottom: 10.h),
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
                  Container(
                    margin: EdgeInsets.only(left: 4.w),
                    width: 250.w,
                    child: Text(
                      performanceReportModel.category ?? '-',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17.sp,
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
                      progressColor:
                          (performanceReportModel.completionRate ?? 0) <= 30
                              ? StatusColor.overdue
                              : (performanceReportModel.completionRate ?? 0) >
                                          30 &&
                                      (performanceReportModel.completionRate ??
                                              0) <=
                                          60
                                  ? StatusColor.open
                                  : StatusColor.completed,
                      percent:
                          (performanceReportModel.completionRate ?? 0) / 100,
                      center: Text(
                        '${(performanceReportModel.completionRate ?? '-')}%',
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8.h),

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
                        '${performanceReportModel.overdueTasks ?? 0}',
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
                        '${performanceReportModel.openTasks ?? 0}',
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
                        '${performanceReportModel.inProgressTasks ?? 0}',
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
                        '${performanceReportModel.completedTasks ?? 0}',
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
                        '${performanceReportModel.onTimeTasks ?? 0}',
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
                        '${performanceReportModel.delayedTasks ?? 0}',
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