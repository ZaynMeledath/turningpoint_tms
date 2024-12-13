part of '../tasks_dashboard.dart';

Widget delegatedReportTabBarView({
  required TasksController tasksController,
  required TextEditingController delegatedSearchController,
  required ScrollController scrollController,
}) {
  return Obx(
    () {
      List<DelegatedPerformanceReportModel>? performanceReportModelList =
          tasksController.delegatedPerformanceReportModelSearchList.value !=
                      null &&
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
                  ? customRefreshIndicator(
                      onRefresh: () async {
                        await tasksController.getDelegatedPerformanceReport();
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.only(
                          top: 8.h,
                          bottom: 66.h,
                        ),
                        itemCount: performanceReportModelList.length,
                        itemBuilder: (context, index) {
                          final performanceReportModel =
                              performanceReportModelList[index];
                          return dashboardCard(
                            title:
                                performanceReportModel.userName!.nameFormat(),
                            totalTasks:
                                performanceReportModel.stats!.totalTasks!,
                            onTimeCompletionRate:
                                performanceReportModel.stats?.completionRate ??
                                    0,
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
                            tasksListCategory:
                                TasksListCategory.delegatedReport,
                            userEmail: performanceReportModel.emailId,
                            category: null,
                            profileImg: performanceReportModel.profileImg,
                            showAvatar: true,
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
    },
  );
}
