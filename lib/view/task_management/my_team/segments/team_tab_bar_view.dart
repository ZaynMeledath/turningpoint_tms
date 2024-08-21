part of '../my_team_screen.dart';

Widget teamTabBarView({
  required List<AllUsersModel> myTeamList,
}) {
  return ListView.builder(
    itemCount: myTeamList.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          bottom: index == (myTeamList.length - 1) ? 65.h : 10.h,
        ),
        child: teamCard(allUsersModel: myTeamList[index]).animate().slideX(
              begin: index % 2 == 0 ? -.4 : .4,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.elasticOut,
            ),
      );
    },
  );
}
