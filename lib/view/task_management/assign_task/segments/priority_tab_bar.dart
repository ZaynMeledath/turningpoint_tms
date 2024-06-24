import 'package:flutter/material.dart';
import 'package:turning_point_tasks_app/utils/screen_size.dart';

Widget priorityTabBar({required TabController tabController}) {
  return Container(
    height: screenHeight * .07,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey.withOpacity(.1),
    ),
    child: TabBar(
      controller: tabController,
      dividerColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateColor.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.black87,
      labelStyle: TextStyle(
        fontSize: screenWidth * .035,
        fontFamily: 'Lufga',
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelColor: Colors.white54,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(36, 196, 123, 1),
            Color.fromRGBO(52, 228, 140, 1)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      tabs: const [
        Text('Low'),
        Text('Medium'),
        Text('High'),
      ],
    ),
  );
}
