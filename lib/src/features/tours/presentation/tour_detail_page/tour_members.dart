import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TourMembers extends ConsumerWidget {
  const TourMembers({Key? key, required this.members}) : super(key: key);
  final List<String> members;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Members',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        gapH8,
        Row(
          children: [],
        ),
        Text(
          members.join(', '),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key, this.name, this.photoUrl});

  final String? name;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
