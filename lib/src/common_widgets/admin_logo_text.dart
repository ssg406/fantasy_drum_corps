import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';

class AdminLogoText extends StatelessWidget {
  const AdminLogoText({Key? key, this.size = 24.0}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'FANTASY',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: size, color: AppColors.customBlue),
        ),
        Text('CORPS',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: size, color: AppColors.customBlue)),
        Text('ADMIN',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: size, color: AppColors.customGreen)),
      ],
    );
  }
}
