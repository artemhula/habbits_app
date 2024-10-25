import 'package:flutter/material.dart';
import 'package:habits/features/habit_list/provider/theme_provider.dart';
import 'package:habits/features/habit_list/screens/calendar_screen.dart';
import 'package:provider/provider.dart';

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
