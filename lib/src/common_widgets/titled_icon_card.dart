import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TitledIconCard extends StatelessWidget {
  const TitledIconCard({
    Key? key,
    required this.iconData,
    required this.title,
    this.subtitle,
    required this.child,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        children: [
          ListTile(
            leading: FaIcon(
              iconData,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: subtitle == null ? null : Text(subtitle!),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
            child: child,
          ),
        ],
      ),
    );
  }
}
