import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HabitChart extends StatelessWidget {
  const HabitChart({
    super.key,
    required this.barGroups,
    required this.completionCountsByDate,
  });

  final List<BarChartGroupData> barGroups;
  final Map<String, int> completionCountsByDate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double containerWidth = barGroups.length * 30.0;
        double screenWidth = constraints.maxWidth;

        return ListView(
          physics: containerWidth < screenWidth
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          reverse: true,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primary,
              ),
              width: containerWidth < screenWidth ? screenWidth - 20 : containerWidth,
              child: BarChart(
                BarChartData(
                  borderData: FlBorderData(
                    border: const Border(
                      top: BorderSide.none,
                      right: BorderSide.none,
                      left: BorderSide.none,
                      bottom: BorderSide.none,
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          String date = completionCountsByDate.keys.toList()[value.toInt()];
                          return Text(date, style: const TextStyle(fontSize: 10));
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  barGroups: barGroups,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}