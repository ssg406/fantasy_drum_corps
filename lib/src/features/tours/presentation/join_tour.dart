import 'package:fantasy_drum_corps/src/common_widgets/custom_tour_tile.dart';
import 'package:fantasy_drum_corps/src/common_widgets/label_checkbox.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This search page should fetch all tours from the repository
class JoinTour extends ConsumerStatefulWidget {
  const JoinTour({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _JoinTourState();
}

class _JoinTourState extends ConsumerState<JoinTour> {
  void _setPublicFilter() {}

  void _handleSearchText() {}

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxContentWidth: 1200,
      child: Padding(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Be a Part of a Fantasy Corps Tour',
                style: Theme.of(context).textTheme.titleLarge),
            Text(
              'Find your friends\' tour or join a public tour to meet new  drum corps fans!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            gapH32,
            const SearchBar(),
            gapH32,
            const ResultsContainer(),
          ],
        ),
      ),
    );
  }
}

class ResultsContainer extends StatelessWidget {
  const ResultsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: cardPadding,
        child: SizedBox(
          height: 400,
          child: ListView(
            children: const [
              // CustomTourTile(
              //     tourName: 'SCV Brass Alumni',
              //     tourDescription:
              //         'Welcome fellow brass alumni of Santa Clara Vanguard! Join us for our first ever fantasy corps league',
              //     isPublic: true,
              //     openSlots: 3),
              // CustomTourTile(
              //     tourName: 'Silverado Cadets',
              //     tourDescription:
              //         'Hey cadets alumni! Ask Josh for password and click to join!',
              //     isPublic: false,
              //     openSlots: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        const Flexible(
          flex: 1,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search tours...',
              labelText: 'Search',
            ),
          ),
        ),
        gapW16,
        Flexible(
          flex: 3,
          child: Row(
            children: const [
              LabelCheckbox('Public'),
              LabelCheckbox('Private'),
            ],
          ),
        )
      ],
    );
  }
}
