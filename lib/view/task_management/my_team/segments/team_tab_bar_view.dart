part of '../my_team_screen.dart';

Widget teamTabBarView({
  required List<AllUsersModel>? myTeamList,
  required AppController appController,
}) {
  final userController = Get.put(UserController());

  if (userController.userException.value != null) {
    return Column(
      children: [
        SizedBox(height: 90.h),
        serverErrorWidget(
          isLoading: appController.isLoadingObs.value,
          onRefresh: () {},
        ),
      ],
    );
  }
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
  } else if (myTeamList != null && myTeamList.isEmpty) {
    return Container();
  } else {
    return Container();
  }
}
