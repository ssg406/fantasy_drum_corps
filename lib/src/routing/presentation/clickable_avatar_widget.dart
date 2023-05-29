import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/user_avatar.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ClickableAvatarWidget extends ConsumerWidget {
  const ClickableAvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTapDown: (tapDetails) async {
        final clickPosition = tapDetails.globalPosition;
        Size screenSize = MediaQuery.of(context).size;
        double left = clickPosition.dx;
        double top = clickPosition.dy;
        double right = screenSize.width - left;
        double bottom = screenSize.height - top;

        await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(left, top, right, bottom),
          items: [
            PopupMenuItem(
              onTap: () => context.goNamed(AppRoutes.profile.name),
              child: const ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
            ),
            PopupMenuItem(
              onTap: () => ref.read(authRepositoryProvider).signOut(),
              child: const ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
              ),
            ),
          ],
        );
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AsyncValueWidget(
          showLoading: false,
          value: ref.watch(playerStreamProvider),
          data: (Player? player) {
            return player == null
                ? Container()
                : Avatar(
                    size: 40.0,
                    avatarString: player.avatarString,
                  );
          },
        ),
      ),
    );
  }
}
