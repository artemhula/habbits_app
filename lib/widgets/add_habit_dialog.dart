import 'package:flutter/material.dart';

class AddHabitDialog extends StatelessWidget {
  const AddHabitDialog({
    super.key,
    required this.habitNameController,
    required this.onPressed,
  });

  final TextEditingController habitNameController;
  final VoidCallback onPressed;

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
          onPressed: onPressed,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
