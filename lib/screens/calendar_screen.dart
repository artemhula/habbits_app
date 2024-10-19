import 'package:flutter/material.dart';
import 'package:habits/utils/habit_util.dart';
import 'package:habits/widgets/add_habit_dialog.dart';
import 'package:habits/widgets/chart_button.dart';
import 'package:habits/widgets/habit_list_tile.dart';
import 'package:habits/widgets/habit_map.dart';
import 'package:habits/widgets/streak.dart';
import 'package:habits/widgets/streak_animation.dart';
import 'package:habits/widgets/toggle_theme_button.dart';
import 'package:habits/widgets/update_habit_dialog.dart';
import 'package:provider/provider.dart';
import 'package:habits/provider/habit_provider.dart';
import 'package:habits/repository/habit_repository.dart';
import 'package:habits/locator.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddHabitDialog(),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        forceMaterialTransparency: false,
        centerTitle: true,
        title: const StreakWidget(),
        actions: const [
          ToggleThemeButton(),
          ChartButton(),
        ],
      ),
      body: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          final datasets =
              sl<HabitUtil>().getDatasets(habitProvider.habitCompletions);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    HabitMap(
                      datasets: datasets,
                      startDate: habitProvider.firstEntryDate,
                      onClick: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(datasets[value].toString())));
                      },
                    ),
                    const SizedBox(height: 30),
                    if (habitProvider.habits.isNotEmpty)
                      ...List.generate(habitProvider.habits.length, (index) {
                        final habit = habitProvider.habits[index];
                        final isCompleted = habitProvider.habitCompletions.any(
                            (c) =>
                                c.habitId == habit.id &&
                                c.date.year == DateTime.now().year &&
                                c.date.month == DateTime.now().month &&
                                c.date.day == DateTime.now().day);
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                sl<HabitRepository>()
                                    .updateHabitCompletion(habit.id);
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return UpdateHabitDialog(habit: habit);
                                  },
                                );
                              },
                              child: HabitListTile(
                                  habit: habit, isCompleted: isCompleted),
                            ),
                            if (index < habitProvider.habits.length - 1)
                              const SizedBox(height: 10),
                          ],
                        );
                      }),
                  ],
                ),
                if (habitProvider.habits.isEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Add a new habit to get started!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                const StreakAnimation(),
              ],
            ),
          );
        },
      ),
    );
  }
}
