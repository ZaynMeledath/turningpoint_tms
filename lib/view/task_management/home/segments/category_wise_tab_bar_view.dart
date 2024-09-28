part of '../tasks_dashboard.dart';

Widget categoryWiseTabBarView({
  required TasksController tasksController,
  required TextEditingController categorySearchController,
}) {
  tasksController.allCategoriesPerformanceReportModelSearchList.value =
      tasksController.allCategoriesPerformanceReportModelList.value;

  return Obx(() {
    if (tasksController.allCategoriesPerformanceReportModelSearchList.value !=
        null) {
      List<AllCategoriesPerformanceReportModel> performanceReportModelList =
          tasksController.allCategoriesPerformanceReportModelSearchList.value!;
      return Column(
        children: [
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: customTextField(
              controller: categorySearchController,
              hintText: 'Search Category',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
              onChanged: (value) {
                tasksController
                        .allCategoriesPerformanceReportModelSearchList.value =
                    tasksController
                        .allCategoriesPerformanceReportModelList.value!
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
                            tasksController.addToDashboardTasksList(
                                tasksList: tasksController
                                    .allTasksListObs.value!
                                    .where((taskModel) =>
                                        taskModel.category ==
                                        performanceReportModel.category)
                                    .toList());

                            Get.to(
                              () => TasksScreen(
                                title:
                                    '${performanceReportModel.category} Tasks',
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
                                        radius: 22.5.w,
                                        progressColor: (performanceReportModel
                                                        .completionRate ??
                                                    0) <=
                                                30
                                            ? StatusColor.overdue
                                            : (performanceReportModel
                                                                .completionRate ??
                                                            0) >
                                                        30 &&
                                                    (performanceReportModel
                                                                .completionRate ??
                                                            0) <=
                                                        60
                                                ? StatusColor.open
                                                : StatusColor.completed,
                                        percent: (performanceReportModel
                                                    .completionRate ??
                                                0) /
                                            100,
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

                                //====================Tasks Status Counter Section====================//
                                tasksStatusCounterSection(
                                  overdueCount:
                                      performanceReportModel.overdueTasks,
                                  openCount: performanceReportModel.openTasks,
                                  inProgressCount:
                                      performanceReportModel.inProgressTasks,
                                  completedCount:
                                      performanceReportModel.completedTasks,
                                  onTimeCount:
                                      performanceReportModel.onTimeTasks,
                                  delayedCount:
                                      performanceReportModel.delayedTasks,
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
