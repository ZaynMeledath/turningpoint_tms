part of '../tasks_dashboard.dart';

Widget dashboardTabBar({
  required TabController tabController,
}) {
  return TabBar(
    controller: tabController,
    // isScrollable: true,
    physics: const BouncingScrollPhysics(),
    indicatorSize: TabBarIndicatorSize.tab,
    labelPadding: EdgeInsets.symmetric(
      vertical: 4.h,
      horizontal: 25.w,
    ),
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateColor.transparent,
    indicator: BoxDecoration(
      color: AppColors.themeGreen,
      borderRadius: BorderRadius.circular(16),
    ),
    unselectedLabelColor: Colors.white60,
    labelColor: Colors.white,
    dividerColor: Colors.transparent,
    tabs: [
      Text(
        'Staff Wise',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
      Text(
        'Category Wise',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    ],
  );
}
