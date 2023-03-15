import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/common_widgets/web_scrollable_list_view.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

/// Main page which displays information on tours the user is a member of
/// as well as currently public tours that can be joined
class ToursDashboard extends StatelessWidget {
  const ToursDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = [
      'One',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight'
    ];
    return SingleChildScrollView(
      child: ResponsiveCenter(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 35.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: cardPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JOINED TOURS',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    const Divider(
                      thickness: 0.5,
                    ),
                    gapH8,
                    WebScrollableListView(
                      height: 400,
                      scrollDirection: Axis.vertical,
                      children: [
                        for (final word in strings)
                          ListTile(
                            onTap: () => debugPrint('tapped'),
                            isThreeLine: true,
                            title: Text(word,
                                style: Theme.of(context).textTheme.titleMedium),
                            subtitle: Text(
                                'user1, user2, user3, user4, user5, user6',
                                style: Theme.of(context).textTheme.bodyMedium),
                            trailing:
                                const Icon(Icons.arrow_circle_right_outlined),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            iconColor: Theme.of(context).colorScheme.tertiary,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            gapH32,
            Card(
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PUBLIC TOURS',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                    const Divider(thickness: 0.5),
                    WebScrollableListView(
                      height: 400,
                      scrollDirection: Axis.vertical,
                      children: [
                        for (final word in strings)
                          ListTile(
                            onTap: () => debugPrint('tapped'),
                            title: Text(word,
                                style: Theme.of(context).textTheme.titleMedium),
                            subtitle: Text(
                                'user1, user2, user3, user4, user5, user6',
                                style: Theme.of(context).textTheme.bodyMedium),
                            trailing:
                                const Icon(Icons.arrow_circle_right_outlined),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            iconColor: Theme.of(context).colorScheme.tertiary,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
