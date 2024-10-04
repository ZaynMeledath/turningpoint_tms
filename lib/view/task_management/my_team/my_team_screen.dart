import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/controller/app_controller.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/controller/user_controller.dart';
import 'package:turning_point_tasks_app/dialogs/show_generic_dialog.dart';
import 'package:turning_point_tasks_app/model/all_users_model.dart';
import 'package:turning_point_tasks_app/model/user_model.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';
import 'package:turning_point_tasks_app/utils/widgets/name_letter_avatar.dart';
import 'package:turning_point_tasks_app/utils/widgets/server_error_widget.dart';
import 'package:turning_point_tasks_app/view/login/login_screen.dart';

part 'segments/team_card.dart';
part 'segments/team_tab_bar.dart';
part 'segments/team_card_action_button.dart';
part 'segments/team_tab_bar_view.dart';
part 'segments/shimmer_team_list_loading.dart';
part 'dialogs/show_add_team_member_bottom_sheet.dart';
part 'segments/role_drop_down.dart';
part 'segments/reporting_manager_drop_down.dart';
part 'segments/department_drop_down.dart';

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

  final teamSearchController = TextEditingController();

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
    userController.myTeamSearchList.clear();
    super.dispose();
  }

  Future<void> getData() async {
    await userController.getAllTeamMembers();
  }

  @override
  Widget build(BuildContext context) {
    final user = getUserModelFromHive();
    return Scaffold(
      appBar: myAppBar(
        title: 'My Team',
        implyLeading: false,
        profileAvatar: true,
      ),
      body: Obx(
        () {
          final myTeamList = userController.myTeamSearchList.isNotEmpty ||
                  teamSearchController.text.trim().isNotEmpty
              ? userController.myTeamSearchList
              : userController.myTeamList.value;

          if (myTeamList != null) {
            adminList = myTeamList
                .where((element) => element.role == Role.admin)
                .toList();

            teamLeaderList = myTeamList
                .where((element) => element.role == Role.teamLeader)
                .toList();

            teamMemberList = myTeamList
                .where((element) => element.role == Role.user)
                .toList();
          }
          return Column(
              // physics: const BouncingScrollPhysics(),
              children: [
                teamTabBar(tabController: tabController).animate().slideX(
                      begin: .4,
                      curve: Curves.elasticOut,
                      duration: const Duration(milliseconds: 900),
                    ),
                SizedBox(height: 12.h),
                user?.role == Role.admin || user?.role == Role.teamLeader
                    ? Row(
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
                            onTap: () {
                              showAddTeamMemberBottomSheet();
                            },
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
                      )
                    : const SizedBox(),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: customTextField(
                      controller: teamSearchController,
                      hintText: 'Search by Name',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      onChanged: (value) {
                        userController.myTeamSearchList.value =
                            userController.myTeamList.value != null
                                ? userController.myTeamList.value!
                                    .where((item) => item.userName!
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList()
                                : [];
                      }),
                ),
                SizedBox(height: 10.h),
                userController.userException.value == null
                    ? Expanded(
                        child: TabBarView(
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
                        ),
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
              ]);
        },
      ),
    );
  }
}
