import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Fantasy Drum Corps',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary)),
          TextButton(
            onPressed: () => context.goNamed(AppRoutes.signIn.name),
            child: Text(
              'register',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          )
        ],
      ),
    );
  }
}
