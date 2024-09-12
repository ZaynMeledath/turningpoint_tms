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
      vertical: 3.h,
      horizontal: 25.w,
    ),
    padding: EdgeInsets.only(bottom: 10.h),
    splashFactory: NoSplash.splashFactory,
    overlayColor: WidgetStateColor.transparent,
    indicator: BoxDecoration(
      color: AppColors.themeGreen.withOpacity(.7),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        width: 1.5,
        color: AppColors.themeGreen,
      ),
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
