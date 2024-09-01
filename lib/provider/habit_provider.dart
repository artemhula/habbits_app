import 'package:flutter/material.dart';
import 'package:habits/models/habit.dart';
import 'package:habits/models/habit_completion.dart';

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];
  List<HabitCompletion> _habitCompletions = [];
  late final DateTime firstEntryDate;
  int? _pickedHabitId;

  List<Habit> get habits => _habits;
  List<HabitCompletion> get habitCompletions => _habitCompletions;
  int? get pickedHabitId => _pickedHabitId;

  set habits(List<Habit> habits) {
    _habits = habits;
    notifyListeners();
  }

  set habitCompletions(List<HabitCompletion> habitCompletions) {
    _habitCompletions = habitCompletions;
    notifyListeners();
  }

  set pickedHabitId(int? pickedHabitId) {
    _pickedHabitId = pickedHabitId;
    print(_pickedHabitId);
    notifyListeners();
  }

}
