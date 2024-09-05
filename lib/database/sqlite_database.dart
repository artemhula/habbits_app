import 'package:flutter/material.dart';
import 'package:habits/models/habit.dart';
import 'package:habits/models/habit_completion.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HabitDatabase {
  static final HabitDatabase instance = HabitDatabase._internal();
  static Database? _database;

  HabitDatabase._internal();

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE habits (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE habit_completions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      habit_id INTEGER NOT NULL,
      date TEXT NOT NULL,
      FOREIGN KEY (habit_id) REFERENCES habits (id)
    )
    ''');

    await db.execute('''
    CREATE TABLE app_info (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      first_entry_date TEXT NOT NULL
    )
    ''');
  }

  Future close() async {
    final db = await database;
    db.close();
  }

  Future saveFirstEntryDate() async {
    final db = await database;
    if ((await db.query('app_info')).isEmpty) {
      await db.insert('app_info', {'first_entry_date': DateTime.now().toIso8601String()});
    }
  }

  Future<DateTime> getFirstEntryDate() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('app_info');
    return DateTime.parse(maps[0]['first_entry_date']);
  }

  Future addHabit(String name) async {
    final db = await database;
    await db.insert('habits', {'name': name});
  }

  Future deleteHabit(int id) async {
    final db = await database;
    await db.delete('habits', where: 'id = ?', whereArgs: [id]);
    // await db.delete('habit_completions', where: 'habit_id = ?', whereArgs: [id]);
  }

  Future addHabitCompletion(int habitId) async {
    final db = await database;
    await db.insert('habit_completions',
        {'habit_id': habitId, 'date': DateUtils.dateOnly(DateTime.now()).toIso8601String()});
  }

  Future deleteHabitCompetion(int habitId, String date) async {
    final db = await database;
    await db.delete('habit_completions',
        where: 'habit_id = ? AND date = ?', whereArgs: [habitId, date]);
  }

  Future toggleHabitCompletion(int habitId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('habit_completions',
        where: 'habit_id = ? AND date = ?', whereArgs: [habitId, DateUtils.dateOnly(DateTime.now()).toIso8601String()]);
    if (maps.isEmpty) {
      addHabitCompletion(habitId);
    } else {
      deleteHabitCompetion(habitId, DateUtils.dateOnly(DateTime.now()).toIso8601String());
    }
  }

  Future updateHabit(int id, String name) async {
    final db = await database;
    await db.update('habits', {'name': name}, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Habit>> getHabits() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('habits');
    return List.generate(maps.length, (i) {
      return Habit(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<List<HabitCompletion>> getHabitCompletionsByHabit(int habitId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('habit_completions',
        where: 'habit_id = ?', whereArgs: [habitId]);
    return List.generate(maps.length, (i) {
      return HabitCompletion(
        id: maps[i]['id'],
        habitId: maps[i]['habit_id'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  Future<List<HabitCompletion>> getAllHabitCompletions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('habit_completions');
    return List.generate(maps.length, (i) {
      return HabitCompletion(
        id: maps[i]['id'],
        habitId: maps[i]['habit_id'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }
}