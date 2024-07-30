import 'package:get_it/get_it.dart';
import 'package:habits/database/sqlite_database.dart';
import 'package:habits/repository/habit_repository.dart';
import 'provider/theme_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerFactory(() => ThemeProvider());
  sl.registerSingleton(HabitDatabase.instance);
  sl.registerFactory<HabitRepository>(() => HabitRepositoryImpl(sl(), sl()));
  sl<HabitRepository>().recieveAllDataForProvider();
}
