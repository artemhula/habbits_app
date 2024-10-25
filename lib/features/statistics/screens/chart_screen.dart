import 'package:flutter/material.dart';
import 'package:habits/locator.dart';
import 'package:habits/shared/provider/habit_provider.dart';
import 'package:habits/utils/habit_util.dart';
import 'package:habits/features/statistics/widgets/habit_chart.dart';
import 'package:habits/shared/widgets/habit_map.dart';
import 'package:habits/features/statistics/widgets/habit_picker.dart';
import 'package:lottie_tgs/lottie.dart';
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
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Habit completions by date',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
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
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Completions by habit',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 15),
                      if (provider.habits.isEmpty)
                        Column(
                          children: [
                            const Text('There are no habits to choose from'),
                            Lottie.asset(
                              'assets/no_data.tgs',
                              height: MediaQuery.of(context).size.height * 0.25,
                            ),
                          ],
                        ),
                      if (provider.habits.isNotEmpty) ...[
                        HabitPicker(
                          habits: provider.habits,
                          initialSelection: provider.pickedHabitId ??
                              provider.habits.first.id,
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
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
