import 'package:get_it/get_it.dart';
import 'package:habits/database/sqlite_database.dart';
import 'package:habits/provider/habit_provider.dart';
import 'package:habits/repository/habit_repository.dart';
import 'package:habits/utils/habit_util.dart';
import 'provider/theme_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<ThemeProvider>(ThemeProvider());
  sl.registerSingleton<HabitProvider>(HabitProvider());
  sl.registerSingleton(HabitDatabase.instance);
  sl.registerFactory<HabitRepository>(() => HabitRepositoryImpl(sl(), sl()));
  await sl<HabitRepository>().recieveAllDataForProvider();
  sl.registerSingleton<HabitUtil>(HabitUtil());

}

