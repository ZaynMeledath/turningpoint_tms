import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_generic_dialog.dart';
import 'package:turningpoint_tms/model/all_users_model.dart';
import 'package:turningpoint_tms/model/user_model.dart';
import 'package:turningpoint_tms/service/api/api_exceptions.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';
import 'package:turningpoint_tms/utils/widgets/server_error_widget.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';
import 'package:turningpoint_tms/view/task_management/home/tasks_screen.dart';

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
  final tasksController = Get.put(TasksController());
  final appController = Get.put(AppController());

  final teamSearchController = TextEditingController();

  List<AllUsersModel> adminList = [];
  List<AllUsersModel> teamLeaderList = [];
  List<AllUsersModel> teamMemberList = [];
  List<AllUsersModel> blockedList = [];

  @override
  void initState() {
    tasksController.isDelegatedObs.value = null;
    tabController = TabController(
      length: 5,
      vsync: this,
    );
    getData();
    super.initState();
  }

  @override
  void dispose() {
    userController.myTeamSearchList.clear();
    appController.isLoadingObs.value = false;
    super.dispose();
  }

  Future<void> getData() async {
    await userController.getAllTeamMembers();
  }

  @override
  Widget build(BuildContext context) {
    final user = getUserModelFromHive();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: myAppBar(
          title: 'My Team',
          implyLeading: false,
          profileAvatar: true,
        ),
        body: Obx(
          () {
            if (teamSearchController.text.isNotEmpty) {
              userController.myTeamSearchList.value = userController
                          .myTeamList.value !=
                      null
                  ? userController.myTeamList.value!
                      .where((item) => item.userName!
                          .toLowerCase()
                          .contains(teamSearchController.text.toLowerCase()))
                      .toList()
                  : [];
            }
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
              blockedList = myTeamList
                  .where((element) => element.isBlocked == true)
                  .toList();
            }
            return Column(
                // physics: const BouncingScrollPhysics(),
                children: [
                  teamTabBar(
                    tabController: tabController,
                    allUsersCount: myTeamList?.length,
                    adminCount: adminList.length,
                    teamLeaderCount: teamLeaderList.length,
                    teamMemberCount: teamMemberList.length,
                    blockedCount: blockedList.length,
                  ).animate().slideX(
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
                  SizedBox(height: 10.h),
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
                                tasksController: tasksController,
                              ),
                              teamTabBarView(
                                myTeamList: adminList,
                                appController: appController,
                                tasksController: tasksController,
                              ),
                              teamTabBarView(
                                myTeamList: teamLeaderList,
                                appController: appController,
                                tasksController: tasksController,
                              ),
                              teamTabBarView(
                                myTeamList: teamMemberList,
                                appController: appController,
                                tasksController: tasksController,
                              ),
                              teamTabBarView(
                                myTeamList: blockedList,
                                appController: appController,
                                tasksController: tasksController,
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
      ),
    );
  }
}
