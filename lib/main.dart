import 'package:flutter/material.dart';
import 'package:habits/locator.dart';
import 'package:habits/screens/calendar_screen.dart';
import 'package:habits/provider/theme_provider.dart';
import 'package:habits/provider/habit_provider.dart';
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

class HabitApp extends StatelessWidget {
  const HabitApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'habits',
      home: const CalendarScreen(),
      theme: Provider.of<ThemeProvider>(context).theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
