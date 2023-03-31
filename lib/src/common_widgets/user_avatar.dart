import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.avatarString,
    required this.size,
    this.borderWidth,
    this.backgroundColor,
  });

  final String? avatarString;
  final double size;
  final double? borderWidth;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(
            size,
          ),
        ),
        child: avatarString == null
            ? const FaIcon(FontAwesomeIcons.circleUser)
            : SvgPicture.string(
                FluttermojiFunctions()
                    .decodeFluttermojifromString(avatarString!),
                height: size,
                width: size,
              ),
      ),
    );
  }
}
