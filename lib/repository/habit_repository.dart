import 'package:habits/database/sqlite_database.dart';
import 'package:habits/models/habit.dart';
import 'package:habits/models/habit_completion.dart';
import 'package:habits/provider/habit_provider.dart';

abstract class HabitRepository {
  Future<List<Habit>> getHabits();
  Future<List<HabitCompletion>> getHabitCompletions();
  Future addHabit(String name);
  Future addHabitCompletion(int habitId);
  Future deleteHabit(int id);
  Future updateHabit(int id, String name);
  Future updateHabitCompletion(int habitId);
  Future recieveAllDataForProvider();
}

class HabitRepositoryImpl implements HabitRepository {
  HabitRepositoryImpl(this._db, this._provider);
  final HabitDatabase _db;
  final HabitProvider _provider;

  @override
  Future addHabit(String name) async {
    await _db.addHabit(name);
    _provider.habits = await _db.getHabits();
  }

  @override
  Future addHabitCompletion(int habitId) async {
    await _db.addHabitCompletion(habitId);
    _provider.habitCompletions = await _db.getAllHabitCompletions();
  }

  @override
  Future deleteHabit(int id) async {
    await _db.deleteHabit(id);
    _provider.habits = await _db.getHabits();
  }

  @override
  Future<List<HabitCompletion>> getHabitCompletions() async =>
      _provider.habitCompletions;

  @override
  Future<List<Habit>> getHabits() async => _provider.habits;

  @override
  Future updateHabit(int id, String name) async {
    _db.updateHabit(id, name);
    _provider.habits = await _db.getHabits();
  }

  @override
  Future updateHabitCompletion(int habitId) async {
    await _db.toggleHabitCompletion(habitId);
    _provider.habitCompletions = await _db.getAllHabitCompletions();
  }

  @override
  Future recieveAllDataForProvider() async {
    await _db.saveFirstEntryDate();
    _provider.habits = await _db.getHabits();
    _provider.habitCompletions = await _db.getAllHabitCompletions();
    _provider.firstEntryDate = await _db.getFirstEntryDate();
    _provider.pickedHabitId = _provider.habits[0].id;
  }
}
