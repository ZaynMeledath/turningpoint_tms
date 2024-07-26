import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turning_point_tasks_app/constants/app_constants.dart';
import 'package:turning_point_tasks_app/constants/tasks_management_constants.dart';
import 'package:turning_point_tasks_app/utils/widgets/my_app_bar.dart';

part 'segments/dashboard_status_overview_container.dart';
part 'segments/dashboard_status_overview_section.dart';

class TasksDashboard extends StatelessWidget {
  const TasksDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context: context,
        title: 'Dashboard',
        implyLeading: false,
        profileAvatar: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            dashboardStatusOverviewSection(),
          ],
        ),
      ),
    );
  }
}

// SizedBox(
//               height: 400,
//               child: BarChart(
//                 BarChartData(
//                   gridData: const FlGridData(
//                     drawHorizontalLine: false,
//                     drawVerticalLine: false,
//                   ),
//                   maxY: 16,
//                   borderData: FlBorderData(
//                     border: Border.all(
//                       color: Colors.transparent,
//                     ),
//                   ),
//                   titlesData: const FlTitlesData(
//                     leftTitles: AxisTitles(),
//                     rightTitles: AxisTitles(),
//                     topTitles: AxisTitles(),
//                   ),
//                   barGroups: [
//                     BarChartGroupData(
//                       x: 1,
//                       barRods: [
//                         BarChartRodData(
//                           toY: 9,
//                           fromY: 0,
//                           width: 15,
//                           color: Colors.blue,
//                         ),
//                         BarChartRodData(
//                           toY: 8,
//                           fromY: 0,
//                           width: 15,
//                           color: Colors.orange,
//                         ),
//                         BarChartRodData(
//                           toY: 6,
//                           fromY: 0,
//                           width: 15,
//                           color: AppColor.themeGreen,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
