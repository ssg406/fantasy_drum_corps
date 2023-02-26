import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  var _selectedIndex = 0;

  Future<void> _logoutUser() async {
    return ref.read(dashboardControllerProvider.notifier).signOut();
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
    return Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'FANTASY',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.lightBlue, letterSpacing: 1.5)),
              TextSpan(
                text: 'DRUM',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextSpan(
                text: 'CORPS',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ]),
          ),
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
              onDestinationSelected: _setNavRailDestination,
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
              child: Center(
                  child: Text(
                'Dashboard',
                style: Theme.of(context).textTheme.displayMedium,
              )),
            )
          ],
        ));
  }
}
