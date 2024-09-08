import 'dart:math';
import 'package:flutter/material.dart';
import 'package:habits/provider/habit_provider.dart';
import 'package:lottie_tgs/lottie.dart';
import 'package:provider/provider.dart';

class StreakAnimation extends StatefulWidget {
  const StreakAnimation({super.key});

  @override
  State<StreakAnimation> createState() => _StreakAnimationState();
}

class _StreakAnimationState extends State<StreakAnimation> {
  bool _showAnimation = false;
  int _previousStreak = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    habitProvider.addListener(_handleStreakChange);
    _previousStreak = habitProvider.streak;
  }

  @override
  void dispose() {
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    habitProvider.removeListener(_handleStreakChange);
    super.dispose();
  }

  void _handleStreakChange() {
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);

    if (habitProvider.streak > _previousStreak) {
      setState(() {
        _showAnimation = true;
        _previousStreak = habitProvider.streak;
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showAnimation = false;
          });
        }
      });
    } else {
      _previousStreak = habitProvider.streak;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _showAnimation
          ? Lottie.asset(
              'assets/streak_${Random().nextInt(3) + 1}.tgs',
              height: 300,
            )
          : const SizedBox.shrink(),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
