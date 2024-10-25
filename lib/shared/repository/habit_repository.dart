import 'package:flutter/material.dart';
import 'package:habits/shared/database/sqlite_database.dart';
import 'package:habits/shared/models/habit.dart';
import 'package:habits/shared/models/habit_completion.dart';
import 'package:habits/shared/provider/habit_provider.dart';
import 'package:habits/utils/notification_service.dart';

abstract class HabitRepository {
  Future<List<Habit>> getHabits();
  Future<List<HabitCompletion>> getHabitCompletions();
  Future addHabit(String name, bool reminderEnable,
      {int? reminderHours, int? reminderMinutes});
  Future addHabitCompletion(int habitId);
  Future deleteHabit(int id);
  Future updateHabit(int id, String name, bool reminderEnable,
      {int? reminderHours, int? reminderMinutes});
  Future updateHabitCompletion(int habitId);
  Future recieveAllDataForProvider();
}

class HabitRepositoryImpl implements HabitRepository {
  HabitRepositoryImpl(this._db, this._provider, this._notificationService);
  final HabitDatabase _db;
  final HabitProvider _provider;
  final NotificationService _notificationService;
  
  @override
  Future addHabit(String name, bool reminderEnable,
      {int? reminderHours, int? reminderMinutes}) async {
    await _db.addHabit(name, reminderEnable, reminderHours, reminderMinutes);
    _provider.habits = await _db.getHabits();
    if (reminderEnable) {
      final habit = _provider.habits.last;
      _notificationService.scheduleDailyNotification(
        habit.id,
        habit.name,
        habit.reminderHours!,
        habit.reminderMinutes!,
      );
    }
  }

  @override
  Future addHabitCompletion(int habitId) async {
    await _db.addHabitCompletion(habitId);
    _provider.habitCompletions = await _db.getAllHabitCompletions();
    final habit =
        _provider.habits.firstWhere((element) => element.id == habitId);
    if (habit.reminderEnable) {
      await _notificationService.cancelNotification(habitId);
      _notificationService.scheduleDailyNotification(
        habit.id,
        habit.name,
        habit.reminderHours!,
        habit.reminderMinutes!,
        isCompleted: true,
      );
    }
  }

  @override
  Future deleteHabit(int id) async {
    await _db.deleteHabit(id);
    _provider.habits = await _db.getHabits();
    await _notificationService.cancelNotification(id);
  }

  @override
  Future<List<HabitCompletion>> getHabitCompletions() async =>
      _provider.habitCompletions;

  @override
  Future<List<Habit>> getHabits() async => _provider.habits;

  @override
  Future updateHabit(int id, String name, bool reminderEnable,
      {int? reminderHours, int? reminderMinutes}) async {
    await _db.updateHabit(
        id, name, reminderEnable, reminderHours, reminderMinutes);
    _provider.habits = await _db.getHabits();
    if (reminderEnable) {
      final habit = _provider.habits.firstWhere((element) => element.id == id);
      _notificationService.scheduleDailyNotification(
        habit.id,
        habit.name,
        habit.reminderHours!,
        habit.reminderMinutes!,
      );
    } else {
      await _notificationService.cancelNotification(id);
    }
  }

  @override
  Future updateHabitCompletion(int habitId) async {
    await _db.toggleHabitCompletion(habitId);
    _provider.habitCompletions = await _db.getAllHabitCompletions();
    final habit =
        _provider.habits.firstWhere((element) => element.id == habitId);
    if (habit.reminderEnable) {
      await _notificationService.cancelNotification(habitId);
      _notificationService.scheduleDailyNotification(
        habit.id,
        habit.name,
        habit.reminderHours!,
        habit.reminderMinutes!,
        isCompleted: _provider.habitCompletions.any(
          (element) =>
              element.habitId == habitId &&
              element.date == DateUtils.dateOnly(DateTime.now()),
        ),
      );
    }
  }

  @override
  Future recieveAllDataForProvider() async {
    await _db.saveFirstEntryDate();
    _provider.habits = await _db.getHabits();
    _provider.habitCompletions = await _db.getAllHabitCompletions();
    _provider.firstEntryDate = await _db.getFirstEntryDate();
    _provider.pickedHabitId =
        _provider.habits.isNotEmpty ? _provider.habits.first.id : null;
  }
}
