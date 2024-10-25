import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HabitMap extends StatelessWidget {
  const HabitMap({super.key, required this.datasets, required this.startDate, this.onClick});
  final Map<DateTime, int> datasets;
  final DateTime startDate;
  final void Function(DateTime)? onClick;

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      datasets: datasets,
      startDate: startDate,
      scrollable: true,
      showColorTip: false,
      colorMode: ColorMode.opacity,
      defaultColor: Theme.of(context).colorScheme.primary,
      colorsets: {
        1: Theme.of(context).colorScheme.tertiary,
      },
      onClick: onClick,
    );
  }
}
