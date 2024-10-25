import 'package:flutter/material.dart';
import 'package:lottie_tgs/lottie.dart';

class AddHabitAlert extends StatelessWidget {
  const AddHabitAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'No habits yet.\n Add one by tapping the + button below.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge ,
          ),
          Lottie.asset(
            'assets/up.tgs',
            height: MediaQuery.of(context).size.height * 0.25,
          ),
        ],
      ),
    );
  }
}
