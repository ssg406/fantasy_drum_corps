import 'package:fantasy_drum_corps/src/common_widgets/accent_button.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';
import 'package:fantasy_drum_corps/src/utils/alert_dialogs.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: cardPadding,
        child: Column(
          children: [
            Text('Remaining Picks',
                style: Theme.of(context).textTheme.titleMedium),
            gapH8,
            SizedBox(
                height: 350,
                child: widget.availableCaptions == null
                    ? const Center(child: Text('No available captions'))
                    : ListView.builder(
                        itemCount: widget.availableCaptions!.length,
                        itemBuilder: (context, index) {
                          final corps =
                              widget.availableCaptions![index].corps.fullName;
                          final caption =
                              widget.availableCaptions![index].caption.name;
                          return ListTile(
                            title: Text('$corps - $caption'),
                            selected: index == _selectedIndex,
                            selectedColor: AppColors.customGreen,
                            visualDensity: const VisualDensity(
                                horizontal: -4.0, vertical: -4.0),
                            onTap: !widget.canPick
                                ? null
                                : () {
                                    setState(() {
                                      _selectedCaption =
                                          widget.availableCaptions![index];
                                      // Deselect if clicking on selected tile
                                      _selectedIndex = index == _selectedIndex
                                          ? null
                                          : index;
                                    });
                                  },
                          );
                        },
                      )),
            gapH8,
            if (widget.canPick)
              Align(
                alignment: Alignment.bottomRight,
                child: AccentButton(
                  label: 'Draft',
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
              ),
          ],
        ),
      ),
    );
  }
}
