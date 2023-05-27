import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key, this.size = 24.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('FANTASY ',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: size)),
        FaIcon(
          FontAwesomeIcons.shieldHalved,
          size: size,
        ),
        Text(' CORPS',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: size)),
      ],
    );
  }
}
