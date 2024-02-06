import 'package:fantasy_drum_corps/src/common_widgets/back_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/responsive_center.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class PageScaffolding extends StatelessWidget {
  const PageScaffolding({
    super.key,
    this.maxContentWidth = 1200,
    required this.pageTitle,
    this.onBackPressed,
    required this.child,
  });

  final double maxContentWidth;
  final String pageTitle;
  final VoidCallback? onBackPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: maxContentWidth,
        child: Padding(
          padding: mobilePagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pageTitle.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
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
