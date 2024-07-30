import 'package:flutter/material.dart';
import 'package:habits/models/habit.dart';
import 'package:habits/models/habit_completion.dart';

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];
  List<HabitCompletion> _habitCompletions = [];
  late final DateTime firstEntryDate;

  List<Habit> get habits => _habits;
  List<HabitCompletion> get habitCompletions => _habitCompletions;

  set habits(List<Habit> habits) {
    _habits = habits;
    notifyListeners();
  }

  set habitCompletions(List<HabitCompletion> habitCompletions) {
    _habitCompletions = habitCompletions;
    notifyListeners();
  }

}
