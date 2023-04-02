import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:round_icon/round_icon.dart';

class TourSearchTile extends StatelessWidget {
  const TourSearchTile(
      {Key? key,
      required this.name,
      required this.isPublic,
      required this.slotsAvailable,
      required this.description})
      : super(key: key);
  final String name;
  final String description;
  final bool isPublic;
  final int slotsAvailable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Tooltip(
        message: isPublic ? 'Public Tour' : 'Private Tour',
        child: RoundIcon(
          size: 30.0,
          padding: 13.0,
          icon: isPublic ? FontAwesomeIcons.lockOpen : FontAwesomeIcons.lock,
          backgroundColor: theme.colorScheme.tertiary,
          iconColor: theme.colorScheme.onTertiary,
        ),
      ),
      title: Text(name),
      subtitle: Text(description),
      trailing: Text('$slotsAvailable slots available'),
    );
  }
}
