import 'package:flutter/material.dart';
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
          return ListView.builder(
            itemCount: habitProvider.habits.length,
            itemBuilder: (context, index) {
              final habit = habitProvider.habits[index];
              final isCompleted = habitProvider.habitCompletions.any((c) =>
                  c.habitId == habit.id &&
                  c.date.year == DateTime.now().year &&
                  c.date.month == DateTime.now().month &&
                  c.date.day == DateTime.now().day);
              return ListTile(
                title: Text(habit.name),
                trailing: IconButton(
                  icon: Icon(
                    isCompleted
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                  ),
                  onPressed: () =>
                      sl<HabitRepository>().updateHabitCompletion(habit.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
