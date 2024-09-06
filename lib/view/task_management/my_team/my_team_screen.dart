import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/app_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/model/all_users_model.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/utils/widgets/server_error_widget.dart';

part 'segments/team_card.dart';
part 'segments/team_tab_bar.dart';
part 'segments/team_card_action_button.dart';
part 'segments/team_tab_bar_view.dart';
part 'segments/shimmer_team_list_loading.dart';

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({super.key});

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final userController = Get.put(UserController());
  final appController = AppController();

  List<AllUsersModel>? adminList;
  List<AllUsersModel>? teamLeaderList;
  List<AllUsersModel>? teamMemberList;

  @override
  void initState() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    getData();
    super.initState();
  }

  @override
  void dispose() {
    appController.dispose();
    super.dispose();
  }

  Future<void> getData() async {
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
          if (myTeamList != null) {
            adminList = myTeamList
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New Member?',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.themeGreen.withOpacity(.7),
                              border: Border.all(
                                color: AppColors.themeGreen,
                                width: 1.5,
                              ),
                            ),
                            child: const Text('Add to Team'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
            body: userController.userException.value == null
                ? TabBarView(
                    controller: tabController,
                    children: [
                      teamTabBarView(
                        myTeamList: myTeamList,
                        appController: appController,
                      ),
                      teamTabBarView(
                        myTeamList: adminList,
                        appController: appController,
                      ),
                      teamTabBarView(
                        myTeamList: teamLeaderList,
                        appController: appController,
                      ),
                      teamTabBarView(
                        myTeamList: teamMemberList,
                        appController: appController,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(height: 90.h),
                      serverErrorWidget(
                        isLoading: appController.isLoadingObs.value,
                        onRefresh: () async {
                          try {
                            appController.isLoadingObs.value = true;
                            await getData();
                            appController.isLoadingObs.value = false;
                          } catch (_) {
                            appController.isLoadingObs.value = false;
                          }
                        },
                      ),
                    ],
                  ),
          );
        },
      ),
      // floatingActionButton: Container(
      //     width: 50.h,
      //     height: 50.h,
      //     margin: EdgeInsets.only(bottom: 50.h),
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: const Color.fromARGB(255, 7, 88, 155),
      //       border: Border.all(
      //         color: Colors.blue,
      //         width: 1.5,
      //       ),
      //     ),
      //     child: const Center(
      //       child: Icon(Icons.add),
      //     )),
    );
  }
}
