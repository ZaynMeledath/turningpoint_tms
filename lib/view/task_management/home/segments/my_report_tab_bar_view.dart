part of '../tasks_dashboard.dart';

Widget myReportTabBarView({
  required TasksController tasksController,
  required TextEditingController myReportSearchController,
}) {
  return Obx(() {
    List<MyPerformanceReportModel>? performanceReportModelList =
        tasksController.myPerformanceReportModelSearchList.value != null ||
                myReportSearchController.text.trim().isNotEmpty
            ? tasksController.myPerformanceReportModelSearchList.value
            : tasksController.myPerformanceReportModelList.value;
    if (performanceReportModelList != null) {
      return Column(
        children: [
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: customTextField(
              controller: myReportSearchController,
              hintText: 'Search Category',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
              onChanged: (value) {
                tasksController.myPerformanceReportModelSearchList.value =
                    tasksController.myPerformanceReportModelList.value!
                        .where(
                          (performanceReportModel) => performanceReportModel
                              .category!
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
                    itemCount: performanceReportModelList.length,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.only(
                      top: 8.h,
                      bottom: 66.h,
                    ),
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
                            Get.to(
                              () => TasksScreen(
                                title:
                                    '${performanceReportModel.category} Tasks',
                                tasksListCategory: TasksListCategory.myReport,
                                category: performanceReportModel.category,
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
                                    Container(
                                      margin: EdgeInsets.only(left: 4.w),
                                      width: 195.w,
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
                                      percent: (performanceReportModel
                                                  .stats?.completionRate ??
                                              0) /
                                          100,
                                      center: Text(
                                        '${performanceReportModel.stats?.completionRate ?? 0}%',
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
                                      percent: (performanceReportModel
                                                  .stats?.delayedRate ??
                                              0) /
                                          100,
                                      center: Text(
                                        '${performanceReportModel.stats?.delayedRate ?? 0}%',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: StatusColor.overdue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),

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
                                  onTimeCount:
                                      performanceReportModel.stats?.onTimeTasks,
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
  });
}
