part of '../tasks_dashboard.dart';

Widget staffWiseTabBarView({
  required TasksController tasksController,
  required TextEditingController staffSearchController,
}) {
  tasksController.allUsersReportModelSearchList.value =
      tasksController.allUsersPerformanceReportModelList.value;

  return Obx(
    () {
      if (tasksController.allUsersReportModelSearchList.value != null &&
          tasksController.allUsersReportModelSearchList.value!.isNotEmpty) {
        List<AllUsersPerformanceReportModel> performanceReportModelList =
            tasksController.allUsersReportModelSearchList.value!;
        return Column(
          children: [
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: customTextField(
                controller: staffSearchController,
                hintText: 'Search Staff',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                onChanged: (value) {
                  tasksController.allUsersReportModelSearchList.value =
                      tasksController.allUsersPerformanceReportModelList.value!
                          .where(
                            (performanceReportModel) => performanceReportModel
                                .userName!
                                .toLowerCase()
                                .contains(value.toLowerCase()),
                          )
                          .toList();
                },
              ),
            ),
            SizedBox(height: 6.h),
            Expanded(
              child: ListView.builder(
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
                            performanceReportModel.userName?.split(' ').first;
                        tasksController.addToDashboardTasksList(
                            tasksList: tasksController.allTasksListObs.value!
                                .where((taskModel) {
                          return (taskModel.assignedTo?.first.split('@').first
                                      as String)
                                  .nameFormat() ==
                              name;
                        }).toList());
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
                                    radius: 22.5.w,
                                    progressColor: (performanceReportModel
                                                    .stats?.completionRate ??
                                                0) <=
                                            30
                                        ? StatusColor.overdue
                                        : (performanceReportModel.stats
                                                            ?.completionRate ??
                                                        0) >
                                                    30 &&
                                                (performanceReportModel.stats
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
                              overdueCount:
                                  performanceReportModel.stats?.overdueTasks,
                              openCount:
                                  performanceReportModel.stats?.openTasks,
                              inProgressCount:
                                  performanceReportModel.stats?.inProgressTasks,
                              completedCount:
                                  performanceReportModel.stats?.completedTasks,
                              onTimeCount:
                                  performanceReportModel.stats?.onTimeTasks,
                              delayedCount:
                                  performanceReportModel.stats?.delayedTasks,
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
              ),
            ),
          ],
        );
      } else if (tasksController.allUsersReportModelSearchList.value == null) {
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
    },
  );
}
