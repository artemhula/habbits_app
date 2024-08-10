import 'package:habits/models/habit_completion.dart';

class HabitCompletionUtil {
 Map<DateTime, int> getDatasetsForHeatMap(List<HabitCompletion> habitCompletions) {
    Map<DateTime, int> datasets = {};
    habitCompletions.forEach((completion) {
      if (datasets.containsKey(completion.date)) {
        datasets[completion.date] = datasets[completion.date]! + 1;
      } else {
        datasets.addAll({completion.date: 1});
      }
    });
    return datasets;
  }
}