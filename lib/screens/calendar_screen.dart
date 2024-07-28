import 'package:flutter/material.dart';
import 'package:habits/database/sqlite_database.dart';
import 'package:habits/models/habit.dart';
import 'package:habits/models/habit_completion.dart';
import 'package:habits/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:habits/locator.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var habitNameController = TextEditingController();
  List<Habit> habits = [];
  List<HabitCompletion> habitComplections = [];

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
                  sl<HabitDatabase>().addHabit(habitNameController.text);
                  habitNameController.clear();
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
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return ListTile(
            title: Text(habit.name),
            trailing: IconButton(
              icon: Icon(
                habitComplections.any((c) =>
                        c.habitId == habit.id &&
                        c.date.year == DateTime.now().year &&
                        c.date.month == DateTime.now().month &&
                        c.date.day == DateTime.now().day)
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
              ),
              onPressed: () => sl<HabitDatabase>().toggleHabitCompletion(habit.id, DateTime.now()),
            ),
          );
        },
      ),
    );
  }
}
