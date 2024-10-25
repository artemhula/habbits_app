import 'package:flutter/material.dart';
import 'package:habits/locator.dart';
import 'package:habits/shared/repository/habit_repository.dart';
import 'package:numberpicker/numberpicker.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({
    super.key,
  });

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  var habitNameController = TextEditingController();
  var isChecked = false;
  int hours = TimeOfDay.now().hour;
  int minutes = TimeOfDay.now().minute;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new habit'),
      backgroundColor: Theme.of(context).colorScheme.surface,
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: habitNameController,
              decoration: const InputDecoration(
                hintText: 'Habit name',
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Remind you'),
                Checkbox(
                  value: isChecked,
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 5),
            AbsorbPointer(
              absorbing: !isChecked,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      NumberPicker(
                        minValue: 0,
                        maxValue: 23,
                        zeroPad: true,
                        value: hours,
                        selectedTextStyle: isChecked
                            ? Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                )
                            : Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.grey),
                        textStyle: isChecked
                            ? Theme.of(context).textTheme.bodyMedium
                            : Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                        onChanged: (h) {
                          setState(() {
                            hours = h;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'hours',
                        style: isChecked
                            ? Theme.of(context).textTheme.bodyMedium
                            : Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      NumberPicker(
                        minValue: 0,
                        maxValue: 59,
                        zeroPad: true,
                        value: minutes,
                        selectedTextStyle: isChecked
                            ? Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                )
                            : Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.grey),
                        textStyle: isChecked
                            ? Theme.of(context).textTheme.bodyMedium
                            : Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                        onChanged: (m) {
                          setState(() {
                            minutes = m;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'minutes',
                        style: isChecked
                            ? Theme.of(context).textTheme.bodyMedium
                            : Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            sl<HabitRepository>().addHabit(
              habitNameController.text,
              isChecked,
              reminderHours: isChecked ? hours : null,
              reminderMinutes: isChecked ? minutes : null,
            );
            habitNameController.clear();
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
