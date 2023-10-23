import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText(
      {super.key,
      this.size = 20.0,
      this.isAdmin = false,
      this.color,
      this.alignment = MainAxisAlignment.start});

  final bool isAdmin;
  final Color? color;
  final MainAxisAlignment alignment;

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(2.0),
        //   child: FaIcon(
        //     FontAwesomeIcons.shieldHalved,
        //     size: size,
        //     color: color,
        //   ),
        // ),
        Text(
          ' FANTASY CORPS',
          style: TextStyle(fontSize: size, color: color),
        ),
        if (isAdmin)
          Text(
            ' ADMIN',
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: size),
          ),
      ],
    );
  }
}
