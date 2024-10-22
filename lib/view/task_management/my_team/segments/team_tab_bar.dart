part of '../my_team_screen.dart';

Widget teamTabBar({
  required TabController tabController,
  required int? allUsersCount,
  required int? adminCount,
  required int? teamLeaderCount,
  required int? teamMemberCount,
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
        'All - ${allUsersCount ?? 0}',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
      Text(
        'Admin - ${adminCount ?? 0}',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
      Text(
        'Team Leader - ${teamLeaderCount ?? 0}',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
      Text(
        'User - ${teamMemberCount ?? 0}',
        style: TextStyle(
          fontSize: 16.sp,
        ),
      ),
    ],
  );
}
