import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:habits/database/sqlite_database.dart';
import 'package:habits/provider/habit_provider.dart';
import 'package:habits/repository/habit_repository.dart';
import 'package:habits/utils/habit_util.dart';
import 'package:habits/utils/notification_service.dart';
import 'provider/theme_provider.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<ThemeProvider>(ThemeProvider());
  sl.registerSingleton<HabitProvider>(HabitProvider());

  sl.registerSingleton(HabitDatabase.instance); 
  sl.registerSingleton<HabitUtil>(HabitUtil());

  sl.registerSingleton<FlutterLocalNotificationsPlugin>(
      FlutterLocalNotificationsPlugin());
  sl<FlutterLocalNotificationsPlugin>()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  sl.registerSingleton<NotificationService>(NotificationService(sl()));

  sl.registerFactory<HabitRepository>(
      () => HabitRepositoryImpl(sl(), sl(), sl()));
  await sl<HabitRepository>().recieveAllDataForProvider();
}
