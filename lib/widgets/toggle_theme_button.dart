import 'package:flutter/material.dart';
import 'package:habits/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      onTap: () =>
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
    );
  }
}
