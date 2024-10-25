import 'package:flutter/material.dart';
import 'package:habits/shared/models/habit.dart';
import 'package:habits/shared/models/habit_completion.dart';
import 'package:habits/utils/habit_util.dart';

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];
  List<HabitCompletion> _habitCompletions = [];
  late final DateTime firstEntryDate;
  late int _streak = HabitUtil().getStreak(habitCompletions);
  int? _pickedHabitId;

  List<Habit> get habits => _habits;
  List<HabitCompletion> get habitCompletions => _habitCompletions;
  int? get pickedHabitId => _pickedHabitId;
  int get streak => _streak;

  set habits(List<Habit> habits) {
    _habits = habits;
    notifyListeners();
  }

  set habitCompletions(List<HabitCompletion> habitCompletions) {
    _habitCompletions = habitCompletions;
    _streak = HabitUtil().getStreak(habitCompletions);
    debugPrint(streak.toString());
    notifyListeners();
  }

  set pickedHabitId(int? pickedHabitId) {
    _pickedHabitId = pickedHabitId;
    notifyListeners();
  }

}
