part of '../tasks_dashboard.dart';

Widget myReportTabBarView({
  required TasksController tasksController,
  required TextEditingController myReportSearchController,
  required ScrollController scrollController,
}) {
  return Obx(() {
    List<MyPerformanceReportModel>? performanceReportModelList =
        tasksController.myPerformanceReportModelSearchList.value != null &&
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
                ? customRefreshIndicator(
                    onRefresh: () async {
                      await tasksController.getMyPerformanceReport();
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: performanceReportModelList.length,
                      padding: EdgeInsets.only(
                        top: 8.h,
                        bottom: 66.h,
                      ),
                      itemBuilder: (context, index) {
                        final performanceReportModel =
                            performanceReportModelList[index];

                        return dashboardCard(
                          title: performanceReportModel.category!.nameFormat(),
                          totalTasks: performanceReportModel.stats!.totalTasks!,
                          onTimeCompletionRate:
                              performanceReportModel.stats?.completionRate ?? 0,
                          delayedCompletionRate:
                              performanceReportModel.stats?.delayedRate ?? 0,
                          overdueCount:
                              performanceReportModel.stats?.overdueTasks,
                          openCount: performanceReportModel.stats?.openTasks,
                          inProgressCount:
                              performanceReportModel.stats?.inProgressTasks,
                          completedCount:
                              performanceReportModel.stats?.completedTasks,
                          onTimeCount:
                              performanceReportModel.stats?.onTimeTasks,
                          delayedCount:
                              performanceReportModel.stats?.delayedTasks,
                          index: index,
                          tasksListCategory: TasksListCategory.myReport,
                          category: performanceReportModel.category,
                          userEmail: null,
                          profileImg: null,
                          showAvatar: false,
                        );
                      },
                    ),
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
