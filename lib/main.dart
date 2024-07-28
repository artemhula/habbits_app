import 'package:flutter/material.dart';
import 'package:habits/locator.dart';
import 'package:habits/screens/calendar_screen.dart';
import 'package:habits/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await initializeDependencies();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => sl<ThemeProvider>(),
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
