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
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 15, right: 15, bottom: 20),
            child: child,
          ),
        ],
      ),
    );
  }
}
