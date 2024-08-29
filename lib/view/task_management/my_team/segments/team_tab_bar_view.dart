part of '../my_team_screen.dart';

Widget teamTabBarView({
  required List<AllUsersModel>? myTeamList,
  required AppController appController,
}) {
  if (myTeamList != null && myTeamList.isNotEmpty) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: myTeamList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            bottom: index == (myTeamList.length - 1) ? 18.h : 10.h,
          ),
          child: teamCard(allUsersModel: myTeamList[index]).animate().slideX(
                begin: index % 2 == 0 ? -.4 : .4,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.elasticOut,
              ),
        );
      },
    );
  } else if (myTeamList == null) {
    return shimmerTeamListLoading();
  } else {
    return Column(
      children: [
        SizedBox(height: 150.h),
        Lottie.asset(
          'assets/lotties/team_empty_animation.json',
          width: 180.w,
        ),
        Text(
          'Add team members to\nview them here',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
