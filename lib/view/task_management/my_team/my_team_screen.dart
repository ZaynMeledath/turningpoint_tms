import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 50.h,
            backgroundColor: AppColor.scaffoldBackgroundColor,
            surfaceTintColor: AppColor.scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: teamTabBar(tabController: tabController),
            ),
          ),
          const SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                SizedBox(height: 10),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: teamCard().animate().slideX(
                      begin: index % 2 == 0 ? -.5 : .5,
                      delay: const Duration(milliseconds: 1),
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
      ),
    );
  }
}
