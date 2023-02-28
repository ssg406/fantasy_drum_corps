import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key, this.size = 24.0});
  final double size;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: 'FANTASY',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.lightBlue, letterSpacing: 1.5, fontSize: size)),
        TextSpan(
          text: 'DRUM',
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: size),
        ),
        TextSpan(
          text: 'CORPS',
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: size),
        ),
      ]),
    );
  }
}
