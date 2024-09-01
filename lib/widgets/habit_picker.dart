import 'package:flutter/material.dart';
import 'package:habits/models/habit.dart';

class HabitPicker extends StatelessWidget {
  const HabitPicker({
    super.key,
    required this.habits,
    required this.onSelected,
  });

  final List<Habit> habits;
  final void Function(int?) onSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: 1,
      width: MediaQuery.of(context).size.width * 0.7,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Theme.of(context).listTileTheme.tileColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      dropdownMenuEntries:
          List<DropdownMenuEntry<int>>.generate(habits.length, (index) {
        return DropdownMenuEntry(
          value: habits[index].id,
          label: habits[index].name,
        );
      }),
      onSelected: onSelected,
    );
  }
}
