import 'package:flutter/material.dart';
import 'package:habits/utils/habit_util.dart';
import 'package:habits/widgets/add_habit_dialog.dart';
import 'package:habits/widgets/chart_button.dart';
import 'package:habits/widgets/habit_list_tile.dart';
import 'package:habits/widgets/habit_map.dart';
import 'package:habits/widgets/streak.dart';
import 'package:habits/widgets/toggle_theme_button.dart';
import 'package:provider/provider.dart';
import 'package:habits/provider/habit_provider.dart';
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddHabitDialog(
            habitNameController: habitNameController,
            onPressed: () {
              sl<HabitRepository>().addHabit(habitNameController.text);
              habitNameController.clear();
              Navigator.pop(context);
            },
          ),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  HabitMap(
                    datasets: datasets,
                    startDate: habitProvider.firstEntryDate,
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
                            child: HabitListTile(
                                habit: habit, isCompleted: isCompleted),
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
