part of '../tasks_dashboard.dart';

Widget dashboardTabBar({
  required TabController tabController,
}) {
  return TabBar(
    controller: tabController,
    isScrollable: true,
    physics: const BouncingScrollPhysics(),
    labelPadding: EdgeInsets.only(
      top: 4.h,
      right: 20.h,
      bottom: 4.h,
    ),
    padding: EdgeInsets.only(bottom: 14.h),
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateColor.transparent,
    indicatorColor: AppColors.themeGreen,
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
      Text(
        'My Report',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
      Text(
        'Delegated',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    ],
  );
}
