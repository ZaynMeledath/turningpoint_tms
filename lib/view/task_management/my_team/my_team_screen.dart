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

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({super.key});

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final userController = Get.put(UserController());

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
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  toolbarHeight: 50.h,
                  backgroundColor: AppColor.scaffoldBackgroundColor,
                  surfaceTintColor: AppColor.scaffoldBackgroundColor,
                  flexibleSpace: FlexibleSpaceBar(
                    background: teamTabBar(tabController: tabController)
                        .animate()
                        .slideX(
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
                userController.myTeamList.value != null &&
                        userController.myTeamList.value!.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: myTeamList!.length,
                          (context, index) => Padding(
                            padding: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w,
                              bottom: 12.h,
                            ),
                            child: teamCard(allUsersModel: myTeamList[index])
                                .animate()
                                .slideX(
                                  begin: index % 2 == 0 ? -.4 : .4,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.elasticOut,
                                ),
                          ),
                        ),
                      )
                    : const SliverList(
                        delegate: SliverChildListDelegate.fixed(
                          [
                            SizedBox(),
                          ],
                        ),
                      ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 65.h),
                    ],
                  ),
                ),
              ],
            );
          },
        )
        // .animate().slideY(
        //       begin: .2,
        //       duration: const Duration(milliseconds: 1200),
        //       curve: Curves.elasticOut,
        //     ),
        );
  }
}
