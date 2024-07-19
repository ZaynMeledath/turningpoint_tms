import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';

part 'segments/title_text_field.dart';
part 'segments/description_text_field.dart';
part 'segments/assign_to_and_category_segment.dart';
part 'segments/priority_tab_bar.dart';
part 'segments/date_and_time_segment.dart';
part 'segments/repeat_frequency_section.dart';
part 'segments/weekly_frequency_segment.dart';
part 'segments/monthly_frequency_segment.dart';
part 'segments/attatchment_segment.dart';
part 'segments/swipe_to_add.dart';
part 'dialogs/show_link_dialog.dart';

class AssignTaskScreen extends StatefulWidget {
  const AssignTaskScreen({super.key});

  @override
  State<AssignTaskScreen> createState() => _AssignTaskScreenState();
}

class _AssignTaskScreenState extends State<AssignTaskScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  final tasksController = Get.put(TasksController());

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    tasksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBody: true,
        appBar: myAppBar(context: context, title: ''),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 4.5.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      text: 'Create\nNew ',
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        fontSize: 32.sp,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: 'Task',
                          style: TextStyle(
                            fontFamily: 'Lufga',
                            fontSize: 32.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ).animate().slideY(
                        begin: 1,
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.elasticOut,
                      ),
                ),
                SizedBox(height: 30.h),
                titleTextField(
                  titleController: titleController,
                  tasksController: tasksController,
                ).animate().slideY(
                      begin: 1,
                      delay: const Duration(milliseconds: 40),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    ),
                SizedBox(height: 32.h),
                descriptionTextField(
                  descriptionController: descriptionController,
                  tasksController: tasksController,
                ).animate().slideY(
                      begin: 1,
                      delay: const Duration(milliseconds: 80),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    ),
                SizedBox(height: 28.h),
                assignToAndCategorySegment(
                  tasksController: tasksController,
                ).animate().slideY(
                      begin: 1,
                      delay: const Duration(milliseconds: 120),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    ),
                SizedBox(height: 28.h),
                priorityTabBar(
                  tabController: tabController,
                  tasksController: tasksController,
                ).animate().slideY(
                      begin: 1,
                      delay: const Duration(milliseconds: 160),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    ),
                SizedBox(height: 28.h),
                dateAndTimeSegment(
                  context: context,
                  tasksController: tasksController,
                ).animate().slideY(
                      begin: 1,
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    ),
                SizedBox(height: 15.h),
                repeatFrequencySection(
                  tasksController: tasksController,
                ).animate().slideY(
                      begin: 1,
                      delay: const Duration(milliseconds: 240),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    ),
                SizedBox(height: 4.5.h),
                attatchmentSegment().animate().slideY(
                      begin: 1,
                      delay: const Duration(milliseconds: 280),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.elasticOut,
                    ),
                SizedBox(height: 85.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: swipeToAdd().animate().slideY(
              begin: 1,
              delay: const Duration(milliseconds: 280),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.elasticOut,
            ),
      ),
    );
  }
}
