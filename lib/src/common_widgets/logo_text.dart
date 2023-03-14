import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key, this.size = 24.0});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('FANTASY',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: size)),
        Image.asset(
          'fc_logo_sm_blank_green@0.25x.png',
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        Text('CORPS',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: size)),
      ],
    );
  }
}
