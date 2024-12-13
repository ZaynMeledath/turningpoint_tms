part of '../tasks_dashboard.dart';

Widget categoryWiseTabBarView({
  required TasksController tasksController,
  required TextEditingController categorySearchController,
  required ScrollController scrollController,
}) {
  return Obx(() {
    List<AllCategoriesPerformanceReportModel>? performanceReportModelList =
        tasksController.allCategoriesPerformanceReportModelSearchList.value !=
                    null &&
                categorySearchController.text.trim().isNotEmpty
            ? tasksController
                .allCategoriesPerformanceReportModelSearchList.value
            : tasksController.allCategoriesPerformanceReportModelList.value;
    if (performanceReportModelList != null) {
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
                ? customRefreshIndicator(
                    onRefresh: () async {
                      await tasksController.getAllCategoriesPerformanceReport();
                    },
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: performanceReportModelList.length,
                      // physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: 8.h,
                        bottom: 66.h,
                      ),
                      itemBuilder: (context, index) {
                        final performanceReportModel =
                            performanceReportModelList[index];

                        return dashboardCard(
                          title: performanceReportModel.category!.nameFormat(),
                          totalTasks: performanceReportModel.totalTasks!,
                          onTimeCompletionRate:
                              performanceReportModel.completionRate ?? 0,
                          delayedCompletionRate:
                              performanceReportModel.delayedRate ?? 0,
                          overdueCount: performanceReportModel.overdueTasks,
                          openCount: performanceReportModel.openTasks,
                          inProgressCount:
                              performanceReportModel.inProgressTasks,
                          completedCount: performanceReportModel.completedTasks,
                          onTimeCount: performanceReportModel.onTimeTasks,
                          delayedCount: performanceReportModel.delayedTasks,
                          index: index,
                          tasksListCategory: TasksListCategory.categoryWise,
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
