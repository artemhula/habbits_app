import 'package:flutter/material.dart';
import 'package:habits/models/habit.dart';

class HabitListTile extends StatelessWidget {
  const HabitListTile({
    super.key,
    required this.habit,
    required this.isCompleted,
  });

  final Habit habit;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(habit.name),
      textColor: isCompleted
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.inverseSurface,
      tileColor: isCompleted
          ? Theme.of(context).colorScheme.tertiary
          : Theme.of(context).listTileTheme.tileColor,
      trailing: Icon(
        isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
        color: isCompleted
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }
}
