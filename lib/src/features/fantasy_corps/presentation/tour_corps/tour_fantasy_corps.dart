import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/fantasy_corps_tile.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FantasyCorpsList extends ConsumerWidget {
  const FantasyCorpsList(
      {super.key,
      this.tourId,
      this.userId,
      this.showTourCorps = false,
      this.showUserCorps = false});

  factory FantasyCorpsList.showTourCorps({
    required String tourId,
  }) =>
      FantasyCorpsList(
        tourId: tourId,
        showTourCorps: true,
      );

  factory FantasyCorpsList.showUserCorps({
    required String userId,
  }) =>
      FantasyCorpsList(
        userId: userId,
        showUserCorps: true,
      );

  final String? tourId;
  final String? userId;
  final bool showTourCorps;
  final bool showUserCorps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (showTourCorps) {
      return AsyncValueWidget(
        value: ref.watch(watchTourFantasyCorpsProvider(tourId!)),
        data: (List<FantasyCorps> tourCorps) {
          return tourCorps.isEmpty
              ? const Text('No Corps Found')
              : Column(
                  children: [
                    for (final corps in tourCorps)
                      FantasyCorpsTile(corps: corps),
                  ],
                );
        },
      );
    } else if (showUserCorps) {
      return AsyncValueWidget(
        value: ref.watch(watchUserFantasyCorpsProvider),
        data: (List<FantasyCorps> userCorps) {
          return userCorps.isEmpty
              ? const Text('No Corps Found')
              : Column(
                  children: [
                    for (final corps in userCorps)
                      FantasyCorpsTile(corps: corps),
                  ],
                );
        },
      );
    } else {
      return Container();
    }
  }
}
