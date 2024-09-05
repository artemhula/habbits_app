import 'package:flutter/material.dart';
import 'package:habits/locator.dart';
import 'package:habits/repository/habit_repository.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({
    super.key,
  });

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  var habitNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
    );
  }
}
