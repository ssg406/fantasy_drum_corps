import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LogoText extends StatelessWidget {
  const LogoText(
      {super.key, this.size = 24.0, this.isAdmin = false, this.color});

  final bool isAdmin;
  final Color? color;

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: FaIcon(
            FontAwesomeIcons.shieldHalved,
            size: size,
            color: color,
          ),
        ),
        Text(' FANTASY CORPS',
            style: Theme
                .of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: size, color: color)),
        if (isAdmin)
          Text(' ADMIN',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                color: Theme
                    .of(context)
                    .colorScheme
                    .inversePrimary,
                fontSize: size,)),
      ],
    );
  }
}
