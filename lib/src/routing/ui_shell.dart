import 'package:fantasy_drum_corps/src/common_widgets/logo_text.dart';
import 'package:fantasy_drum_corps/src/routing/ui_shell_controller.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  var _selectedIndex = 0;

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
        const PopupMenuItem(
          child: ListTile(
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

  void _setNavRailDestination(index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(uiShellControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(uiShellControllerProvider);
    return Scaffold(
        appBar: AppBar(
          title: const LogoText(),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 45.0),
                child: GestureDetector(
                  onTapDown: (tapDetails) =>
                      _showUserMenu(tapDetails.globalPosition),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      child: const Text('SJ'),
                    ),
                  ),
                ))
          ],
        ),
        body: Row(
          children: [
            NavigationRail(
              extended: MediaQuery.of(context).size.width > 700,
              onDestinationSelected:
                  state.isLoading ? null : _setNavRailDestination,
              selectedIndex: _selectedIndex,
              destinations: const [
                NavigationRailDestination(
                  icon: FaIcon(FontAwesomeIcons.gaugeHigh),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: FaIcon(FontAwesomeIcons.users),
                  label: Text('Leagues'),
                ),
                NavigationRailDestination(
                  icon: FaIcon(FontAwesomeIcons.trophy),
                  label: Text('Matches'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.leaderboard_rounded),
                  label: Text('Leaderboard'),
                ),
                NavigationRailDestination(
                  icon: FaIcon(FontAwesomeIcons.circleDollarToSlot),
                  label: Text('Donate'),
                ),
              ],
            ),
            Expanded(
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : widget.child,
            )
          ],
        ));
  }
}
