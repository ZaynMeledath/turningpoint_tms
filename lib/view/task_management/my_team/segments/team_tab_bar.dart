part of '../my_team_screen.dart';

Widget teamTabBar({
  required TabController tabController,
}) {
  return TabBar(
    controller: tabController,
    isScrollable: true,
    physics: const BouncingScrollPhysics(),
    indicatorSize: TabBarIndicatorSize.tab,
    labelPadding: EdgeInsets.symmetric(
      vertical: 2.h,
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
    // dividerColor: Colors.transparent,
    tabs: [
      Text(
        'All',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
      Text(
        'Admin',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
      Text(
        'Team Leader',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
      Text(
        'Team Member',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    ],
  );
}
