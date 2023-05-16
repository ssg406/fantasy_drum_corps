import 'package:fantasy_drum_corps/src/common_widgets/not_found.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:flutter/material.dart';

class CreateFantasyCorps extends StatelessWidget {
  const CreateFantasyCorps({
    super.key,
    this.fantasyCorps,
  });

  final FantasyCorps? fantasyCorps;

  @override
  Widget build(BuildContext context) {
    return fantasyCorps == null
        ? const NotFound()
        : Center(
            child:
                Text('received fantasy corps tour ID ${fantasyCorps!.tourId}'),
          );
  }
}
