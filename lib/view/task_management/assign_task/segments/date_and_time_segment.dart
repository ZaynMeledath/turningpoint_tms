import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';

Widget dateAndTimeSegment() {
  return Row(
    children: [
      Container(
        width: screenWidth * .15,
        height: screenWidth * .15,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.1),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.calendar_month_rounded),
        ),
      ),
      Gap(screenWidth * .02),
      Text(
        '25 June',
        style: TextStyle(
          color: Colors.white60,
          fontSize: screenWidth * .036,
        ),
      ),
    ],
  );
}
