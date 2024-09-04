import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits/screens/chart_screen.dart';

class ChartButton extends StatelessWidget {
  const ChartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          Icons.auto_graph_sharp,
          size: 30,
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
      ),
      onTap: () => Navigator.push(
          context, CupertinoPageRoute(builder: (context) => ChartScreen())),
    );
  }
}
