import 'package:fantasy_drum_corps/src/features/authentication/presentation/authentication_form_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen.dart';
import 'package:fantasy_drum_corps/src/features/onboarding/presentation/onboarding_screen.dart';

// Navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoutes {
  signIn,
  dashboard,
}

final goRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  // redirect: (context, state) {
  //   // TODO check if onboarding complete from repository, redirect to onboarding if not
  //   if (true) {
  //     /// Check state.subloc before returning non-null route
  //     /// if not at /onboarding, redirect to /onboarding
  //     if (state.subloc != '/onboarding') {
  //       return '/onboarding';
  //     }
  //   }
  //   // TODO isLoggedIn condition from provider navigates to dashboard from /signIn
  //   if (true) {
  //     if (state.subloc.startsWith('/signIn')) {
  //       return '/dashboard';
  //     }
  //   }
  //   // TODO 'else' clause checks for not signed in and redirects all to /signIn
  //   return null;
  // },
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const OnboardingScreen(),
      ),
    ),
    GoRoute(
      path: '/signIn',
      name: AppRoutes.signIn.name,
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const AuthenticateScreen(
          formType: AuthenticationFormType.register,
        ),
      ),
    ),
    GoRoute(
        path: '/dashboard',
        name: AppRoutes.dashboard.name,
        pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const Placeholder(),
            )),
  ],
);
