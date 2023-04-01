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
          'two_toned_shield.png',
          width: size * 2,
          height: size * 2,
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
