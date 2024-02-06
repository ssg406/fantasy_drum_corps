import 'package:flutter/material.dart';

class DetailPageExpansionTile extends StatelessWidget {
  const DetailPageExpansionTile(
      {super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.titleMedium,
      ),
      childrenPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.centerLeft,
      children: [child],
    );
  }
}
