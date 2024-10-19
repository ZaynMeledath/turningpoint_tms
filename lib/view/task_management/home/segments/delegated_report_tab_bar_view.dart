part of '../tasks_dashboard.dart';

Widget delegatedReportTabBarView({
  required TasksController tasksController,
  required TextEditingController delegatedSearchController,
}) {
  return Obx(
    () {
      List<DelegatedPerformanceReportModel>? performanceReportModelList =
          tasksController.delegatedPerformanceReportModelSearchList.value !=
                      null ||
                  delegatedSearchController.text.trim().isNotEmpty
              ? tasksController.delegatedPerformanceReportModelSearchList.value
              : tasksController.delegatedPerformanceReportModelList.value;
      if (performanceReportModelList != null) {
        return Column(
          children: [
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: customTextField(
                controller: delegatedSearchController,
                hintText: 'Search User',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                onChanged: (value) {
                  tasksController
                          .delegatedPerformanceReportModelSearchList.value =
                      tasksController.delegatedPerformanceReportModelList.value!
                          .where(
                            (performanceReportModel) => performanceReportModel
                                .userName!
                                .toLowerCase()
                                .contains(value.trim().toLowerCase()),
                          )
                          .toList();
                },
              ),
            ),
            SizedBox(height: 6.h),
            Expanded(
              child: performanceReportModelList.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: 8.h,
                        bottom: 66.h,
                      ),
                      itemCount: performanceReportModelList.length,
                      itemBuilder: (context, index) {
                        final performanceReportModel =
                            performanceReportModelList[index];
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
                              final name =
                                  performanceReportModel.userName!.nameFormat();
                              Get.to(
                                () => TasksScreen(
                                  title: '$name\'s Tasks',
                                  tasksListCategory:
                                      TasksListCategory.delegatedReport,
                                  email: performanceReportModel.emailId,
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
                                        name:
                                            '${performanceReportModel.userName}',
                                        circleDiameter: 34.w,
                                      ),
                                      SizedBox(width: 7.w),
                                      SizedBox(
                                        width: 220.w,
                                        child: Text(
                                          performanceReportModel.userName!
                                              .nameFormat(),
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
                                                          .stats
                                                          ?.completionRate ??
                                                      0) <=
                                                  30
                                              ? StatusColor.overdue
                                              : (performanceReportModel.stats
                                                                  ?.completionRate ??
                                                              0) >
                                                          30 &&
                                                      (performanceReportModel
                                                                  .stats
                                                                  ?.completionRate ??
                                                              0) <=
                                                          60
                                                  ? StatusColor.open
                                                  : StatusColor.completed,
                                          percent: (performanceReportModel
                                                      .stats?.completionRate ??
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
                                    overdueCount: performanceReportModel
                                        .stats?.overdueTasks,
                                    openCount:
                                        performanceReportModel.stats?.openTasks,
                                    inProgressCount: performanceReportModel
                                        .stats?.inProgressTasks,
                                    completedCount: performanceReportModel
                                        .stats?.completedTasks,
                                    onTimeCount: performanceReportModel
                                        .stats?.onTimeTasks,
                                    delayedCount: performanceReportModel
                                        .stats?.delayedTasks,
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
                    )
                  : ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(height: 40.h),
                        SizedBox(
                          height: 150.w,
                          child: Lottie.asset(
                            'assets/lotties/empty_list_animation.json',
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      } else {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: shimmerListLoading(),
        );
      }
    },
  );
}
