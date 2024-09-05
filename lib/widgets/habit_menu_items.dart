import 'package:flutter/material.dart';

class HabitMenuItems extends StatelessWidget {
  const HabitMenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          child: const Text('Add'),
        ),  
        Container(
          color: Theme.of(context).colorScheme.primary,
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
