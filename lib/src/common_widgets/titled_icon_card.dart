import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class TitledIconCard extends StatelessWidget {
  const TitledIconCard({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.child,
  }) : super(key: key);

  final Widget icon;
  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        ListTile(
          leading: icon,
          title: Text(title),
          subtitle: subtitle == null ? null : Text(subtitle!),
        ),
        gapH16,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
          child: child,
        ),
      ],
    ));
  }
}
