import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/logo_text.dart';
import 'package:fantasy_drum_corps/src/common_widgets/user_avatar.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/routing/presentation/ui_shell_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../app_router.dart';

class NavShell extends ConsumerStatefulWidget {
  const NavShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState createState() => _NavShellState();
}

class _NavShellState extends ConsumerState<NavShell> {
  final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  Future<void> _logoutUser() async {
    return ref.read(uiShellControllerProvider.notifier).signOut();
  }

  void _showUserMenu(clickPosition) async {
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
          onTap: _logoutUser,
          child: const ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(uiShellControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
          width: 1500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldStateKey.currentState!.openDrawer(),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.goNamed(AppRoutes.dashboard.name),
                  child: const LogoText(),
                ),
              ),
              GestureDetector(
                onTapDown: (tapDetails) =>
                    _showUserMenu(tapDetails.globalPosition),
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
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 150,
              padding:
                  const EdgeInsets.symmetric(vertical: 35.0, horizontal: 20.0),
              child: Image.asset(
                'two_toned_shield.png',
                fit: BoxFit.contain,
              ),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.gaugeHigh),
              title: const Text('Dashboard'),
              onTap: () => _onDrawerClick(AppRoutes.dashboard),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.circlePlus),
              title: const Text('Create Tour'),
              onTap: () => _onDrawerClick(AppRoutes.createTour),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.users),
              title: const Text('My Tours'),
              onTap: () => _onDrawerClick(AppRoutes.myTours),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.magnifyingGlassPlus),
              title: const Text('Find Tours'),
              onTap: () => _onDrawerClick(AppRoutes.searchTours),
            ),
            const ExpansionTile(
              leading: FaIcon(FontAwesomeIcons.circleInfo),
              title: Text('About'),
              children: [
                ListTile(
                  title: Text('Rules'),
                ),
                ListTile(
                  title: Text('FAQs'),
                ),
                ListTile(
                  title: Text('Contact'),
                ),
                ListTile(
                  title: Text('Terms'),
                )
              ],
            )
          ],
        ),
      ),
      body: widget.child,
    );
  }

  void _onDrawerClick(AppRoutes route) {
    context.goNamed(route.name);
    _scaffoldStateKey.currentState!.closeDrawer();
  }
}
