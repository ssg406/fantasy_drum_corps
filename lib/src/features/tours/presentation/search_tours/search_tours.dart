import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/label_checkbox.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/common_widgets/tour_search_tile.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This search page should fetch all tours from the repository
class SearchTours extends ConsumerStatefulWidget {
  const SearchTours({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _SearchToursState();
}

class _SearchToursState extends ConsumerState<SearchTours> {
  bool watchPublicOnly = false;
  String searchText = '';

  void setPublicFilter(bool input) {
    setState(() {
      watchPublicOnly = input;
    });
  }

  void handleSearchText(String input) {
    setState(() {
      searchText = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffolding(
      pageTitle: 'Find a Tour',
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
          SearchBar(
              onPublicOnlyChecked: setPublicFilter,
              onSearched: handleSearchText),
          gapH32,
          AsyncValueWidget(
            value: ref.watch(watchAllToursProvider(watchPublicOnly)),
            data: (List<Tour>? tours) {
              return ResultsContainer(
                tours: tours!,
                searchText: searchText,
              );
            },
          ),
        ],
      ),
    );
  }
}

class ResultsContainer extends StatelessWidget {
  const ResultsContainer(
      {Key? key, required this.tours, required this.searchText})
      : super(key: key);
  final List<Tour> tours;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    final filteredTours = tours.where((tour) {
      final lowerName = tour.name.toLowerCase();
      final lowerDesc = tour.description.toLowerCase();
      final lowerSearch = searchText.toLowerCase();
      return lowerName.contains(lowerSearch) || lowerDesc.contains(lowerSearch);
    });

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView(
        children: [
          for (final tour in filteredTours)
            TourSearchTile(
              tour: tour,
            ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar(
      {Key? key, required this.onSearched, required this.onPublicOnlyChecked})
      : super(key: key);
  final void Function(String) onSearched;
  final void Function(bool) onPublicOnlyChecked;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          flex: 1,
          child: TextField(
            onChanged: onSearched,
            decoration: const InputDecoration(
              hintText: 'Search tours...',
              labelText: 'Search',
            ),
          ),
        ),
        gapW16,
        Flexible(
          flex: 1,
          child:
              LabelCheckbox('Show Public Only', onChecked: onPublicOnlyChecked),
        )
      ],
    );
  }
}
