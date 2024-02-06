import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

/// Shows remaining picks a player can choose on their turn, contains ListView
class AvailableCaptions extends StatefulWidget {
  const AvailableCaptions(
      {super.key,
      this.availableCaptions,
      required this.onCaptionSelected,
      required this.canPick});

  final List<DrumCorpsCaption>? availableCaptions;
  final void Function(DrumCorpsCaption) onCaptionSelected;
  final bool canPick;

  @override
  State<AvailableCaptions> createState() => _AvailableCaptionsState();
}

class _AvailableCaptionsState extends State<AvailableCaptions> {
  int? _selectedIndex;
  DrumCorpsCaption? _selectedCaption;
  bool _isGroupedByCaption = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Remaining Picks',
            style: Theme.of(context).textTheme.headlineSmall),
        gapH8,
        SizedBox(
          height: ResponsiveBreakpoints.of(context).screenHeight * 0.3,
          child: widget.availableCaptions == null
              ? const Center(child: Text('No available captions'))
              : GroupedListView<DrumCorpsCaption, String>(
                  elements: widget.availableCaptions!,
                  groupBy:
                      _isGroupedByCaption ? _groupByCaption : _groupByCorps,
                  useStickyGroupSeparators: true,
                  groupHeaderBuilder: (dcc) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: widget.canPick
                            ? Theme.of(context).colorScheme.secondaryContainer
                            : Theme.of(context)
                                .colorScheme
                                .secondaryContainer
                                .withOpacity(0.3)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    width: double.infinity,
                    child: Text(
                      _isGroupedByCaption
                          ? dcc.caption.fullName
                          : dcc.corps.fullName,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                  ),
                  indexedItemBuilder: (context, dcc, index) {
                    return ListTile(
                      title: Text(dcc.displayString),
                      selected: index == _selectedIndex,
                      selectedColor: Colors.black,
                      selectedTileColor: AppColors.customGreen.withOpacity(0.2),
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      onTap: !widget.canPick
                          ? null
                          : () {
                              setState(
                                () {
                                  _selectedCaption = dcc;
                                  // Deselect if clicking on selected tile
                                  _selectedIndex =
                                      index == _selectedIndex ? null : index;
                                },
                              );
                            },
                    );
                  },
                ),
        ),
        gapH8,
        Expanded(
          child: ButtonBar(
            overflowDirection: VerticalDirection.up,
            children: [
              ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                  ? IconButton(
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () => setState(
                          () => _isGroupedByCaption = !_isGroupedByCaption),
                      icon: const Icon(Icons.sort),
                    )
                  : TextButton.icon(
                      onPressed: () => setState(
                          () => _isGroupedByCaption = !_isGroupedByCaption),
                      icon: const Icon(Icons.sort),
                      label: Text(_isGroupedByCaption
                          ? 'Sort by Corps'
                          : 'Sort by Caption'),
                    ),
              if (widget.canPick)
                ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                    ? IconButton.filled(
                        onPressed: () {
                          if (_selectedCaption == null) {
                            showAlertDialog(
                                context: context,
                                title: 'No Selection Made',
                                content: 'Select a caption to draft first.');
                            return;
                          }
                          widget.onCaptionSelected(_selectedCaption!);
                          setState(() {
                            // Reset the index and the caption to prevent duplication
                            _selectedIndex = null;
                            _selectedCaption = null;
                          });
                        },
                        icon: const Icon(Icons.play_circle_outline_rounded),
                      )
                    : FilledButton.icon(
                        icon: const Icon(Icons.play_circle_outline_rounded),
                        label: const Text(
                          'Draft',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (_selectedCaption == null) {
                            showAlertDialog(
                                context: context,
                                title: 'No Selection Made',
                                content: 'Select a caption to draft first.');
                            return;
                          }
                          widget.onCaptionSelected(_selectedCaption!);
                          setState(() {
                            // Reset the index and the caption to prevent duplication
                            _selectedIndex = null;
                            _selectedCaption = null;
                          });
                        },
                      ),
              if (!widget.canPick)
                ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                    ? const IconButton.filled(
                        onPressed: null,
                        icon: Icon(Icons.hourglass_bottom_rounded),
                      )
                    : FilledButton.icon(
                        onPressed: null,
                        icon: const Icon(Icons.hourglass_bottom_rounded),
                        label: const Text('WAITING'),
                      ),
            ],
          ),
        )
      ],
    );
  }

  String _groupByCorps(DrumCorpsCaption dcc) => dcc.corps.fullName;

  String _groupByCaption(DrumCorpsCaption dcc) => dcc.caption.fullName;
}
