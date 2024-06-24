import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';

class AssignTaskScreen extends StatelessWidget {
  const AssignTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context, title: ''),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * .04),
        child: Column(
          children: [
            Gap(screenHeight * .005),
            Text.rich(
              TextSpan(
                  text: 'Create\nNew ',
                  style: TextStyle(
                    fontFamily: 'Lufga',
                    // fontWeight: FontWeight.w500,
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
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
