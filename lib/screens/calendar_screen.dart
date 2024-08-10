import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habits/utils/habit_completion_util.dart';
import 'package:provider/provider.dart';
import 'package:habits/provider/habit_provider.dart';
import 'package:habits/provider/theme_provider.dart';
import 'package:habits/repository/habit_repository.dart';
import 'package:habits/locator.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var habitNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add a new habit'),
            content: SizedBox(
              width: 300,
              child: TextField(
                controller: habitNameController,
                decoration: const InputDecoration(
                  hintText: 'Habit name',
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  sl<HabitRepository>().addHabit(habitNameController.text);
                  habitNameController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        forceMaterialTransparency: true,
        actions: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Icon(
                Provider.of<ThemeProvider>(context).isDarkTheme
                    ? Icons.wb_sunny_outlined
                    : Icons.mode_night_outlined,
                size: 30,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            onTap: () => Provider.of<ThemeProvider>(context, listen: false)
                .toggleTheme(),
          ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.auto_graph_sharp,
                size: 30,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            onTap: () => null,
          ),
        ],
      ),
      body: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          final datasets = sl<HabitCompletionUtil>()
              .getDatasetsForHeatMap(habitProvider.habitCompletions);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
              child: Column(
                children: [
                  HeatMap(
                    datasets: datasets,
                    startDate: habitProvider.firstEntryDate,
                    scrollable: true,
                    showColorTip: false,
                    colorsets: const {
                      1: Colors.red,
                    },
                    onClick: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(datasets[value].toString())));
                    },
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children:
                        List.generate(habitProvider.habits.length, (index) {
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
                            onTap: () => sl<HabitRepository>()
                                .updateHabitCompletion(habit.id),
                            child: ListTile(
                              title: Text(habit.name),
                              textColor: isCompleted
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .inverseSurface,
                              tileColor: isCompleted
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).listTileTheme.tileColor,
                              trailing: Icon(
                                isCompleted
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: isCompleted
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .inverseSurface,
                              ),
                            ),
                          ),
                          if (index < habitProvider.habits.length - 1)
                            const SizedBox(height: 10),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
