import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habits/shared/models/habit_completion.dart';
import 'package:intl/intl.dart';

class HabitUtil {
  Map<String, int> getCompletionCountsByDate(
      List<HabitCompletion> habitCompletions) {
    DateTime startDate = habitCompletions.first.date;
    DateTime endDate = habitCompletions.last.date;

    final completionCountsByDate = <String, int>{};
    for (DateTime date = startDate;
        date.isBefore(endDate.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      completionCountsByDate[DateFormat('d.M').format(date)] = 0;
    }

    for (var completion in habitCompletions) {
      String formattedDate = DateFormat('d.M').format(completion.date);
      completionCountsByDate[formattedDate] =
          (completionCountsByDate[formattedDate] ?? 0) + 1;
    }

    return completionCountsByDate;
  }

  Map<DateTime, int> getDatasets(List<HabitCompletion> hc) {
    Map<DateTime, int> datasets = {};
    hc.forEach((completion) {
      if (datasets.containsKey(completion.date)) {
        datasets[completion.date] = datasets[completion.date]! + 1;
      } else {
        datasets.addAll({completion.date: 1});
      }
    });
    return datasets;
  }

  Map<DateTime, int> getDatasetsByHabit(List<HabitCompletion> hc, int habitId) {
    Map<DateTime, int> datasets = {};
    hc.forEach((completion) {
      if (completion.habitId == habitId) {
        if (datasets.containsKey(completion.date)) {
          datasets[completion.date] = datasets[completion.date]! + 1;
        } else {
          datasets.addAll({completion.date: 1});
        }
      }
    });
    return datasets;
  }

  List<BarChartGroupData> getBarGroups(List<HabitCompletion> habitCompletions) {
    final completionCountsByDate = getCompletionCountsByDate(habitCompletions);

    final barGroups = completionCountsByDate.entries.map((entry) {
      int index = completionCountsByDate.keys.toList().indexOf(entry.key);
      return BarChartGroupData(x: index, barRods: [
        BarChartRodData(
          toY: entry.value.toDouble(),
          width: 20,
          color: const Color.fromARGB(255, 66, 191, 0),
        ),
      ]);
    }).toList();
    return barGroups;
  }

  int getStreak(List<HabitCompletion> habitCompletions) {
    final datasets = getDatasets(habitCompletions);
    if (datasets.isEmpty) {
      return 0;
    }
    if (!datasets.containsKey(DateUtils.dateOnly(DateTime.now()))) {
      return 0;
    }
    int streak = 1;
    while (true) {
      DateTime yesterday =
          DateUtils.dateOnly(DateTime.now()).subtract(Duration(days: streak));
      if (datasets.containsKey(DateUtils.dateOnly(yesterday))) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }
}
