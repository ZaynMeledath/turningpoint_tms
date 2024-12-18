part of '../tasks_dashboard.dart';

Widget dashboardTabBar({
  required TabController tabController,
  required bool isAdminOrLeader,
}) {
  List<Widget> tabs = [];

  if (isAdminOrLeader) {
    tabs = [
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
        'Delegated Report',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    ];
  } else {
    tabs = [
      Text(
        'My Report',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    ];
  }

  return TabBar(
          controller: tabController,
          isScrollable: true,
          physics: const BouncingScrollPhysics(),
          labelPadding: EdgeInsets.only(
            top: 4.h,
            right: 22.h,
            bottom: 4.h,
          ),
          padding: EdgeInsets.only(bottom: 6.h),
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateColor.transparent,
          indicatorColor: AppColors.themeGreen,
          unselectedLabelColor: Colors.white60,
          labelColor: Colors.white,
          dividerColor: Colors.transparent,
          tabs: tabs)
      .animate()
      .slideX(
        begin: .4,
        curve: Curves.elasticOut,
        duration: const Duration(milliseconds: 900),
      );
}
