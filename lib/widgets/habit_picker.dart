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
      menuStyle: MenuStyle(
        backgroundColor:
            WidgetStatePropertyAll(Theme.of(context).colorScheme.primary),
        maximumSize: WidgetStatePropertyAll(
          Size(
            MediaQuery.of(context).size.width * 0.7,
            MediaQuery.of(context).size.height * 0.4,
          ),
        ),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Theme.of(context).colorScheme.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      dropdownMenuEntries: List<DropdownMenuEntry<int>>.generate(
        habits.length,
        (index) => DropdownMenuEntry(
          value: habits[index].id,
          label: habits[index].name,
        ),
      ),
      onSelected: onSelected,
    );
  }
}
