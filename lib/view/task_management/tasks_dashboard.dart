import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turning_point_tasks_app/view/task_management/my_tasks/my_tasks_screen.dart';

class TasksDashboard extends StatelessWidget {
  const TasksDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => const MyTasksScreen(),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                child: BarChart(
                  BarChartData(
                    gridData: const FlGridData(
                      drawHorizontalLine: false,
                      drawVerticalLine: false,
                    ),
                    maxY: 16,
                    borderData: FlBorderData(
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                    ),
                    titlesData: const FlTitlesData(
                      leftTitles: AxisTitles(),
                      rightTitles: AxisTitles(),
                      topTitles: AxisTitles(),
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: 9,
                            fromY: 0,
                            width: 15,
                            color: Colors.blue,
                          ),
                          BarChartRodData(
                            toY: 8,
                            fromY: 0,
                            width: 15,
                            color: Colors.orange,
                          ),
                          BarChartRodData(
                            toY: 6,
                            fromY: 0,
                            width: 15,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
