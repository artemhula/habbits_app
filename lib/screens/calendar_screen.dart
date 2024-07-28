import 'package:flutter/material.dart';
import 'package:habits/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
          onPressed: () => null,
        ),
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Icon(
                  Provider.of<ThemeProvider>(context).isDarkTheme
                      ? Icons.wb_sunny_outlined
                      : Icons.mode_night_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              onTap: () => Provider.of<ThemeProvider>(context, listen: false)
                  .toggleTheme(),
            ),
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.auto_graph_sharp,
                  size: 30,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
              onTap: () => null,
            ),
          ],
        ),
        body: ListView(
          children: [],
        ));
  }
}
