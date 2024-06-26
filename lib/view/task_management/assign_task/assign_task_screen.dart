import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:turning_point_tasks_app/controller/tasks_controller.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';

part 'segments/title_text_field.dart';
part 'segments/description_text_field.dart';
part 'segments/priority_tab_bar.dart';
part 'segments/date_and_time_segment.dart';
part 'segments/swipe_to_add.dart';

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

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: myAppBar(context: context, title: ''),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
            child: Column(
              children: [
                Gap(screenHeight * .005),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      text: 'Create\nNew ',
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        fontSize: screenWidth * .08,
                        color: Colors.white,
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: 'Task',
                          style: TextStyle(
                            fontFamily: 'Lufga',
                            fontSize: screenWidth * .08,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(screenHeight * .05),
                titleTextField(titleController: titleController),
                Gap(screenHeight * .05),
                descriptionTextField(
                    descriptionController: descriptionController),
                Gap(screenHeight * .05),
                priorityTabBar(tabController: tabController),
                Gap(screenHeight * .05),
                dateAndTimeSegment(context: context),
                Gap(screenHeight * .05),
                swipeToAdd(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
