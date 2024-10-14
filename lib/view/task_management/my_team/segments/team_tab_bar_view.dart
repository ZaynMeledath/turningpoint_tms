part of '../my_team_screen.dart';

Widget teamTabBarView({
  required List<AllUsersModel>? myTeamList,
  required AppController appController,
  required TasksController tasksController,
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
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            highlightColor: Colors.lightBlue.withOpacity(.15),
            splashColor: Colors.lightBlue.withOpacity(.25),
            onTap: () {
              tasksController.addToDashboardTasksList(
                  tasksList:
                      tasksController.allTasksListObs.value!.where((taskModel) {
                return taskModel.assignedTo?.first.emailId.toString() ==
                    myTeamList[index].emailId;
              }).toList());
              Get.to(
                () => TasksScreen(
                    title:
                        '${myTeamList[index].userName!.split(' ').first}\'s Tasks'),
                transition: Transition.zoom,
              );
            },
            child: teamCard(allUsersModel: myTeamList[index]).animate().slideX(
                  begin: index % 2 == 0 ? -.4 : .4,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.elasticOut,
                ),
          ),
        );
      },
    );
  } else if (myTeamList == null) {
    return shimmerTeamListLoading();
  } else {
    return ListView(
      children: [
        SizedBox(height: 85.h),
        SizedBox(
          height: 180.h,
          child: Lottie.asset(
            'assets/lotties/team_empty_animation.json',
          ),
        ),
        // Text(
        //   '',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     fontSize: 18.sp,
        //   ),
        // ),
      ],
    );
  }
}
