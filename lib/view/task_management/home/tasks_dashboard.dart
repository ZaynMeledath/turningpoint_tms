import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:turningpoint_tms/constants/app_constants.dart';
import 'package:turningpoint_tms/constants/tasks_management_constants.dart';
import 'package:turningpoint_tms/controller/app_controller.dart';
import 'package:turningpoint_tms/controller/tasks_controller.dart';
import 'package:turningpoint_tms/controller/user_controller.dart';
import 'package:turningpoint_tms/dialogs/show_reminders_list_dialog.dart';
import 'package:turningpoint_tms/extensions/string_extensions.dart';
import 'package:turningpoint_tms/model/all_categories_performance_report_model.dart';
import 'package:turningpoint_tms/model/all_users_performance_report_model.dart';
import 'package:turningpoint_tms/model/delegated_performance_report_model.dart';
import 'package:turningpoint_tms/model/my_performance_report_model.dart';
import 'package:turningpoint_tms/model/user_model.dart';
import 'package:turningpoint_tms/utils/widgets/circular_user_image.dart';
import 'package:turningpoint_tms/utils/widgets/custom_refresh_indicator.dart';
import 'package:turningpoint_tms/utils/widgets/my_app_bar.dart';
import 'package:turningpoint_tms/utils/widgets/name_letter_avatar.dart';
import 'package:turningpoint_tms/utils/widgets/server_error_widget.dart';
import 'package:turningpoint_tms/view/login/login_screen.dart';
import 'package:turningpoint_tms/view/task_management/home/tasks_screen.dart';

part 'segments/dashboard_status_overview_container.dart';
part 'segments/dashboard_status_overview_section.dart';
part 'segments/shimmer_list_loading.dart';
part 'segments/dashboard_tab_bar.dart';
part 'segments/staff_wise_tab_bar_view.dart';
part 'segments/category_wise_tab_bar_view.dart';
part 'segments/my_report_tab_bar_view.dart';
part 'segments/delegated_report_tab_bar_view.dart';
part 'segments/tasks_status_counter_section.dart';
part 'segments/dashboard_card.dart';

class TasksDashboard extends StatefulWidget {
  const TasksDashboard({super.key});

  @override
  State<TasksDashboard> createState() => _TasksDashboardState();
}

class _TasksDashboardState extends State<TasksDashboard>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final tasksController = Get.put(TasksController());
  final appController = Get.put(AppController());
  late final TabController tabController;

  final staffScrollController = ScrollController();
  final categoryScrollController = ScrollController();
  final myReportScrollController = ScrollController();
  final delegatedScrollController = ScrollController();

  final staffWiseSearchController = TextEditingController();
  final categoryWiseSearchController = TextEditingController();
  final myReportSearchController = TextEditingController();
  final delegatedSearchController = TextEditingController();

  final GlobalKey _containerKey = GlobalKey();
  double containerHeight = 0;

  UserModel? userModel;
  bool isAdminOrLeader = false;

  @override
  void initState() {
    super.initState();
    initializeDashboard();
  }

  void initializeDashboard() {
    tasksController.isDelegatedObs.value = null;
    userModel = getUserModelFromHive();
    isAdminOrLeader =
        userModel?.role == Role.admin || userModel?.role == Role.teamLeader;
    tabController = TabController(
      length: isAdminOrLeader ? 4 : 1,
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          _containerKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        setState(() {
          containerHeight = renderBox.size.height;
        });
      }
    });

    getData();
    tabController.addListener(() {
      tasksController.dashboardTabIndexObs.value = tabController.index;

      tasksController.dashboardScrollOffsetObs.value = 0;

      staffScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.elasticOut,
      );

      categoryScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.elasticOut,
      );

      myReportScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.elasticOut,
      );

      delegatedScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.elasticOut,
      );
    });

    staffScrollController.addListener(() {
      tasksController.dashboardScrollOffsetObs.value =
          staffScrollController.offset;
    });

    categoryScrollController.addListener(() {
      tasksController.dashboardScrollOffsetObs.value =
          categoryScrollController.offset;
    });

    myReportScrollController.addListener(() {
      tasksController.dashboardScrollOffsetObs.value =
          myReportScrollController.offset;
    });

    delegatedScrollController.addListener(() {
      tasksController.dashboardScrollOffsetObs.value =
          delegatedScrollController.offset;
    });
  }

  Future<void> getData() async {
    try {
      await tasksController.getMyTasks();
      await tasksController.getDelegatedTasks();
      if (isAdminOrLeader) {
        await Future.wait([
          tasksController.getMyPerformanceReport(),
          tasksController.getDelegatedPerformanceReport(),
          tasksController.getAllTasks(),
          tasksController.getAllUsersPerformanceReport(),
          tasksController.getAllCategoriesPerformanceReport(),
        ]);
      } else {
        await tasksController.getMyPerformanceReport();
      }
    } catch (e) {
      log('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    appController.isLoadingObs.value = false;
    staffWiseSearchController.dispose();
    categoryWiseSearchController.dispose();
    myReportSearchController.dispose();
    delegatedSearchController.dispose();
    tabController.dispose();
    staffScrollController.dispose();
    categoryScrollController.dispose();
    myReportScrollController.dispose();
    delegatedScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: myAppBar(
          title: 'Dashboard',
          implyLeading: false,
          profileAvatar: true,
          trailingIcons: [
            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: showRemindersListDialog,
              icon: Icon(
                Icons.alarm,
                size: 24.w,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Obx(
              () {
                double opacity = (1 -
                        (tasksController.dashboardScrollOffsetObs.value /
                            containerHeight))
                    .clamp(0, 1);
                return AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 250),
                  child: buildDashboardContent(),
                );
              },
            ),
            buildTabBarView(),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardContent() {
    return Container(
      key: _containerKey,
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: dashboardStatusOverviewSection(
              tasksController: tasksController,
              isAdminOrLeader: isAdminOrLeader,
            ),
          ),
          SizedBox(height: 18.h),
          buildReportTitle(),
        ],
      ),
    );
  }

  Widget buildReportTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Text(
          'Report',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget buildTabBarView() {
    return Obx(
      () {
        tasksController.dashboardTabBarViewPaddingObs.value =
            (containerHeight) -
                tasksController.dashboardScrollOffsetObs.value
                    .clamp(0, (containerHeight));

        return AnimatedPadding(
          padding: EdgeInsets.only(
              top: tasksController.dashboardTabBarViewPaddingObs.value),
          duration: const Duration(milliseconds: 250),
          child: Container(
            color: AppColors.scaffoldBackgroundColor,
            padding: EdgeInsets.only(top: 10.h),
            child: Column(
              children: [
                dashboardTabBar(
                  tabController: tabController,
                  isAdminOrLeader: isAdminOrLeader,
                ),
                Obx(
                  () => Expanded(
                    child: tasksController.tasksException.value == null
                        ? buildTabViews()
                        : buildErrorView(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTabViews() {
    if (isAdminOrLeader) {
      return TabBarView(
        controller: tabController,
        children: [
          staffWiseTabBarView(
            tasksController: tasksController,
            staffSearchController: staffWiseSearchController,
            scrollController: staffScrollController,
          ),
          categoryWiseTabBarView(
            tasksController: tasksController,
            categorySearchController: categoryWiseSearchController,
            scrollController: categoryScrollController,
          ),
          myReportTabBarView(
            tasksController: tasksController,
            myReportSearchController: myReportSearchController,
            scrollController: myReportScrollController,
          ),
          delegatedReportTabBarView(
            tasksController: tasksController,
            delegatedSearchController: delegatedSearchController,
            scrollController: delegatedScrollController,
          ),
        ],
      );
    } else {
      return TabBarView(
        controller: tabController,
        children: [
          myReportTabBarView(
            tasksController: tasksController,
            myReportSearchController: myReportSearchController,
            scrollController: myReportScrollController,
          ),
        ],
      );
    }
  }

  Widget buildErrorView() {
    return Column(
      children: [
        SizedBox(height: 50.h),
        serverErrorWidget(
          isLoading: appController.isLoadingObs.value,
          onRefresh: getData,
        ),
      ],
    );
  }
}
