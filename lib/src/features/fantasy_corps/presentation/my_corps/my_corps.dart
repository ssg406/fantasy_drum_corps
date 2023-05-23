import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      child: SizedBox(
        height: 200,
        child: userCorps.isEmpty
            ? Center(
                child: Text(
                  'No Fantasy Corps Found',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container();
                },
                itemCount: userCorps.length,
              ),
      ),
    );
  }
}
