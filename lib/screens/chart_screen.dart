import 'package:flutter/material.dart';
import 'package:habits/locator.dart';
import 'package:habits/provider/habit_provider.dart';
import 'package:habits/utils/habit_util.dart';
import 'package:habits/widgets/habit_chart.dart';
import 'package:habits/widgets/habit_map.dart';
import 'package:habits/widgets/habit_picker.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Consumer<HabitProvider>(
          builder:
              (BuildContext context, HabitProvider provider, Widget? child) {
            if (provider.habitCompletions.isEmpty) {
              return const Center(child: Text('No data available'));
            }
            final completionCountsByDate = sl<HabitUtil>()
                .getCompletionCountsByDate(provider.habitCompletions);
            final barGroups =
                sl<HabitUtil>().getBarGroups(provider.habitCompletions);
            return Column(
              children: [
                const Text('Habit completions by date'),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: HabitChart(
                      barGroups: barGroups,
                      completionCountsByDate: completionCountsByDate,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text('Completions by habit'),
                const SizedBox(height: 15),
                HabitPicker(
                  habits: provider.habits,
                  onSelected: (int? value) {
                    provider.pickedHabitId = value;
                  },
                ),
                const SizedBox(height: 15),
                if (provider.pickedHabitId != null)
                  HabitMap(
                    datasets: sl<HabitUtil>().getDatasetsByHabit(
                        provider.habitCompletions,
                        provider.pickedHabitId!),
                    startDate: provider.firstEntryDate,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
