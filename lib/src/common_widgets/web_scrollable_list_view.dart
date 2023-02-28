import 'dart:ui';

import 'package:flutter/material.dart';

/// [WebScrollableListView] includes configuration to allow [ListView] to be
/// scrolled when deployed to web
class WebScrollableListView extends StatelessWidget {
  const WebScrollableListView({
    super.key,
    required this.height,
    required this.scrollDirection,
    required this.children,
  });
  final double height;
  final Axis scrollDirection;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: SizedBox(
        height: height,
        child: ListView(
          scrollDirection: scrollDirection,
          children: children,
        ),
      ),
    );
  }
}
