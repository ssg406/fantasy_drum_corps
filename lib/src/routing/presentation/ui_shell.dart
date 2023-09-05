import 'package:fantasy_drum_corps/src/common_widgets/async_value_widget.dart';
import 'package:fantasy_drum_corps/src/common_widgets/logo_text.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/routing/presentation/clickable_avatar_widget.dart';
import 'package:fantasy_drum_corps/src/routing/presentation/ui_shell_controller.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:fantasy_drum_corps/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class NavShell extends ConsumerWidget {
  const NavShell({
    super.key,
    required this.child,
  });

  final Widget child;

  Map<AppRoutes, Widget> get navDestinations => {
        AppRoutes.dashboard: const FaIcon(FontAwesomeIcons.gaugeHigh),
        AppRoutes.leaderboard: const FaIcon(FontAwesomeIcons.trophy),
        AppRoutes.myCorps: const FaIcon(FontAwesomeIcons.solidFlag),
        AppRoutes.myTours: const FaIcon(FontAwesomeIcons.users),
        AppRoutes.searchTours:
            const FaIcon(FontAwesomeIcons.magnifyingGlassPlus),
        AppRoutes.createTour: const FaIcon(FontAwesomeIcons.circlePlus),
        AppRoutes.howToPlay: const Icon(Icons.rule_rounded),
        AppRoutes.about: const FaIcon(FontAwesomeIcons.circleInfo),
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey();
    ref.listen<AsyncValue>(uiShellControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final textSize =
        ResponsiveBreakpoints.of(context).largerOrEqualTo(TABLET) ? 24.0 : 16.0;

    final route =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    return Scaffold(
      key: scaffoldStateKey,
      appBar: route.contains(AppRoutes.draftLobby.name)
          ? null
          : AppBar(
              automaticallyImplyLeading: false,
              title: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
                width: 1500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.bars,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          scaffoldStateKey.currentState!.openDrawer(),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => context.goNamed(AppRoutes.dashboard.name),
                        child: AsyncValueWidget(
                          showLoading: false,
                          value: ref.watch(currentUserIsAdminProvider),
                          data: (bool isAdmin) => LogoText(
                            size: textSize,
                            isAdmin: isAdmin,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const ClickableAvatarWidget(),
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
            for (final route in navDestinations.keys)
              ListTile(
                leading: navDestinations[route],
                title: Text(route.fullName),
                onTap: () {
                  context.pushNamed(route.name);
                  scaffoldStateKey.currentState!.closeDrawer();
                },
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
              },
            ),
          ],
        ),
      ),
      body: child,
    );
  }
}
