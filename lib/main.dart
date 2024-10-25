import 'package:flutter/material.dart';
import 'package:habits/app.dart';
import 'package:habits/locator.dart';
import 'package:habits/features/habit_list/provider/theme_provider.dart';
import 'package:habits/shared/provider/habit_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => sl<ThemeProvider>(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => sl<HabitProvider>(),
        ),
      ],
      child: const HabitApp(),
    ),
  );
}

