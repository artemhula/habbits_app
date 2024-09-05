import 'package:flutter/material.dart';
import 'package:habits/locator.dart';
import 'package:habits/models/habit.dart';
import 'package:habits/repository/habit_repository.dart';

class UpdateHabitDialog extends StatefulWidget {
  const UpdateHabitDialog({
    super.key,
    required this.habit,
  });

  final Habit habit;

  @override
  State<UpdateHabitDialog> createState() => _UpdateHabitDialogState();
}

class _UpdateHabitDialogState extends State<UpdateHabitDialog> {
  late TextEditingController habitNameController;

  @override
  void initState() {
    super.initState();
    habitNameController = TextEditingController(text: widget.habit.name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update habit'),
      content: SizedBox(
        width: 300,
        child: TextField(
          controller: habitNameController,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            sl<HabitRepository>().deleteHabit(widget.habit.id);
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
        TextButton(
          onPressed: () {
            sl<HabitRepository>().updateHabit(
              widget.habit.id,
              habitNameController.text,
            );
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
