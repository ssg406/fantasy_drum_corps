import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminLogoText extends StatelessWidget {
  const AdminLogoText({Key? key, this.size = 24.0}) : super(key: key);
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
          ),
        ),
        Text(' FANTASY CORPS ',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: size)),
        Text('ADMIN',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: size)),
      ],
    );
  }
}
