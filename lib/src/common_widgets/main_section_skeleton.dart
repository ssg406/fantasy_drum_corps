import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class MainSectionSkeleton extends StatelessWidget {
  const MainSectionSkeleton({Key? key, required this.children})
      : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        child: Padding(
          padding: pagePadding,
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}
