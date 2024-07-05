import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  )),
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
    );
  }
}
