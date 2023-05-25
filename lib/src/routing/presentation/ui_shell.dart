import 'package:fantasy_drum_corps/src/common_widgets/admin_logo_text.dart';
import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/logo_text.dart';
import 'package:fantasy_drum_corps/src/common_widgets/user_avatar.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:fantasy_drum_corps/src/routing/presentation/ui_shell_controller.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../app_router.dart';

class NavShell extends ConsumerWidget {
  const NavShell({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey();
    ref.listen<AsyncValue>(uiShellControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final textSize =
        ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET) ? 24.0 : 16.0;
    return Scaffold(
      key: scaffoldStateKey,
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
                onPressed: () => scaffoldStateKey.currentState!.openDrawer(),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.goNamed(AppRoutes.dashboard.name),
                  child: AsyncValueWidget(
                    showLoading: false,
                    value: ref.watch(currentUserIsAdminProvider),
                    data: (bool isAdmin) => isAdmin
                        ? AdminLogoText(size: textSize)
                        : LogoText(size: textSize),
                  ),
                ),
              ),
              GestureDetector(
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
            const DrawerHeader(
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.shieldHalved,
                  color: AppColors.customBlue,
                  size: 65.0,
                ),
              ),
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.gaugeHigh),
              title: const Text('Dashboard'),
              onTap: () {
                context.pushNamed(AppRoutes.dashboard.name);
                scaffoldStateKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.circlePlus),
              title: const Text('Create Tour'),
              onTap: () {
                context.pushNamed(AppRoutes.createTour.name);
                scaffoldStateKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.users),
              title: const Text('My Tours'),
              onTap: () {
                context.pushNamed(AppRoutes.myTours.name);
                scaffoldStateKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.magnifyingGlassPlus),
              title: const Text('Find Tours'),
              onTap: () {
                context.pushNamed(AppRoutes.searchTours.name);
                scaffoldStateKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.solidFlag),
              title: const Text('My Fantasy Corps'),
              onTap: () {
                context.pushNamed(AppRoutes.myCorps.name);
                scaffoldStateKey.currentState!.closeDrawer();
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.trophy),
              title: const Text('Leaderboard'),
              onTap: () {
                context.pushNamed(AppRoutes.leaderboard.name);
                scaffoldStateKey.currentState!.closeDrawer();
              },
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
            ),
            AsyncValueWidget(
                value: ref.watch(currentUserIsAdminProvider),
                data: (bool isAdmin) {
                  return isAdmin
                      ? ListTile(
                          leading: FaIcon(
                            FontAwesomeIcons.asterisk,
                            color: Colors.red[700],
                          ),
                          title: Text(
                            'Admin Dashboard',
                            style: TextStyle(color: Colors.red[700]),
                          ),
                          onTap: () {
                            context.pushNamed(AppRoutes.adminMain.name);
                            scaffoldStateKey.currentState!.closeDrawer();
                          },
                        )
                      : Container();
                })
          ],
        ),
      ),
      body: child,
    );
  }
}
