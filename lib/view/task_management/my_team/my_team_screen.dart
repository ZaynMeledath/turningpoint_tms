import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/model/all_users_model.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';

part 'segments/team_card.dart';
part 'segments/team_tab_bar.dart';
part 'segments/team_card_action_button.dart';
part 'segments/team_tab_bar_view.dart';

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({super.key});

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final userController = Get.put(UserController());

  List<AllUsersModel> adminList = [];
  List<AllUsersModel> teamLeaderList = [];
  List<AllUsersModel> teamMemberList = [];

  @override
  void initState() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    getData();
    super.initState();
  }

  void getData() async {
    await userController.getAllTeamMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'My Team',
        implyLeading: false,
        profileAvatar: true,
      ),
      body: Obx(
        () {
          final myTeamList = userController.myTeamList.value;
          if (userController.myTeamList.value != null &&
              userController.myTeamList.value!.isNotEmpty) {
            adminList = myTeamList!
                .where((element) => element.role == Role.admin)
                .toList();

            teamLeaderList = myTeamList
                .where((element) => element.role == Role.teamLeader)
                .toList();

            teamMemberList = myTeamList
                .where((element) => element.role == Role.teamMember)
                .toList();
          }
          return NestedScrollView(
            // physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                pinned: true,
                toolbarHeight: 50.h,
                backgroundColor: AppColors.scaffoldBackgroundColor,
                surfaceTintColor: AppColors.scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      teamTabBar(tabController: tabController).animate().slideX(
                            begin: .4,
                            curve: Curves.elasticOut,
                            duration: const Duration(milliseconds: 900),
                          ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
            body: userController.myTeamList.value != null &&
                    userController.myTeamList.value!.isNotEmpty
                ? TabBarView(
                    controller: tabController,
                    children: [
                      teamTabBarView(myTeamList: myTeamList!),
                      teamTabBarView(myTeamList: adminList),
                      teamTabBarView(myTeamList: teamLeaderList),
                      teamTabBarView(myTeamList: teamMemberList),
                    ],
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}
