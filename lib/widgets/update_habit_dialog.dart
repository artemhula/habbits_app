import 'package:flutter/material.dart';
import 'package:habits/locator.dart';
import 'package:habits/models/habit.dart';
import 'package:habits/repository/habit_repository.dart';
import 'package:numberpicker/numberpicker.dart';

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
  var habitNameController = TextEditingController();
  late bool isChecked;
  late int hours;
  late int minutes;

  @override
  void initState() {
    habitNameController.text = widget.habit.name;
    isChecked = widget.habit.reminderEnable;
    hours = widget.habit.reminderHours ?? TimeOfDay.now().hour;
    minutes = widget.habit.reminderMinutes ?? TimeOfDay.now().minute;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update habit'),
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
              isChecked,
              reminderHours: isChecked ? hours : null,
              reminderMinutes: isChecked ? minutes : null,
            );
            habitNameController.clear();
            Navigator.pop(context);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
