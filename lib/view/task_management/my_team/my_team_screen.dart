import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
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

  @override
  void initState() {
    tabController = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
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
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              toolbarHeight: 50.h,
              backgroundColor: AppColor.scaffoldBackgroundColor,
              surfaceTintColor: AppColor.scaffoldBackgroundColor,
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    bottom: 12.h,
                  ),
                  child: teamCard().animate().slideX(
                        begin: index % 2 == 0 ? -.4 : .4,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                ),
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
        )
        // .animate().slideY(
        //       begin: .2,
        //       duration: const Duration(milliseconds: 1200),
        //       curve: Curves.elasticOut,
        //     ),
        );
  }
}
