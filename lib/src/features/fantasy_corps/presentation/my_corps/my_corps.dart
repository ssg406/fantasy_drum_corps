import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MyCorps extends ConsumerWidget {
  const MyCorps({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(watchUserFantasyCorpsProvider),
      data: (List<FantasyCorps> corps) => MyCorpsContents(userCorps: corps),
    );
  }
}

class MyCorpsContents extends StatelessWidget {
  const MyCorpsContents({super.key, required this.userCorps});

  final List<FantasyCorps> userCorps;

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
      pageTitle: 'MY FANTASY CORPS',
      child: Column(
        children: [
          Row(
            children: [
              const FaIcon(FontAwesomeIcons.solidFlag),
              gapW16,
              Text(
                'Select a corps for more details',
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
          gapH16,
          SizedBox(
            height: 200,
            child: userCorps.isEmpty
                ? Center(
                    child: Text(
                      'No Fantasy Corps Found',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      for (final corps in userCorps)
                        ListTile(
                          title: Text(
                            corps.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          subtitle: Text(
                            corps.showTitle ?? 'Untitled Show',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          onTap: () => context.pushNamed(
                              AppRoutes.corpsDetail.name,
                              extra: corps),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
