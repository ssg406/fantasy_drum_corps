import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class TitledSectionCard extends StatelessWidget {
  const TitledSectionCard({Key? key, required this.title, required this.child})
      : super(key: key);
  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.tertiary.withAlpha(25),
      child: Padding(
        padding: ResponsiveBreakpoints.of(context).largerThan(TABLET)
            ? cardPadding
            : mobileCardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            gapH16,
            const Divider(thickness: 0.5),
            gapH16,
            child,
          ],
        ),
      ),
    );
  }
}
