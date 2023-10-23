import 'dart:math';

import 'package:fantasy_drum_corps/src/common_widgets/back_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class PageScaffolding extends StatelessWidget {
  const PageScaffolding({
    super.key,
    this.maxContentWidth = 1200,
    required this.pageTitle,
    this.onBackPressed,
    required this.child,
    this.showImage = false,
  });

  final double maxContentWidth;
  final String pageTitle;
  final VoidCallback? onBackPressed;
  final Widget child;
  final bool showImage;

  String _getRandomImagePath() {
    int randomNum = Random().nextInt(6);
    return 'assets/header_img_$randomNum.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final isLargerThanMobile =
        ResponsiveBreakpoints.of(context).largerThan(TABLET);
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: maxContentWidth,
        child: Padding(
          padding: ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET)
              ? pagePadding
              : mobilePagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pageTitle.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // gapH8,
              // const Divider(thickness: 0.5),
              gapH16,
              child,
              gapH16,
              CustomBackButton(customOnPressed: onBackPressed),
            ],
          ),
        ),
      ),
    );
  }
}
