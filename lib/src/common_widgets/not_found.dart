import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NotFound extends StatefulWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  State<NotFound> createState() => _NotFoundState();
}

class _NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: pagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.bug,
              size: 60.0,
            ),
            gapH16,
            Text('Resource Not Found',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            Text(
              'An error might have occurred and we couldn\'t find what you were looking for. We\'ll redirect you back home in a moment.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 24.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _redirect();
  }

  void _redirect() async {
    await Future.delayed(const Duration(seconds: 10),
        () => context.goNamed(AppRoutes.dashboard.name));
  }
}
