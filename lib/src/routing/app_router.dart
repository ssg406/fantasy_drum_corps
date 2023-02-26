import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authentication_form_type.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_main.dart';
import 'package:fantasy_drum_corps/src/features/onboarding/data/onboarding_repository.dart';
import 'package:fantasy_drum_corps/src/routing/go_router_refresh_stream.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen.dart';
import 'package:fantasy_drum_corps/src/features/onboarding/presentation/onboarding_screen.dart';

// Navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoutes {
  signIn,
  dashboard,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final onboardingRepository = ref.watch(onboardingRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    redirect: (context, state) {
      // If onboarding is not complete and user is not at onboarding page,
      // redirect to onboarding page.
      // if (!onboardingRepository.isOnboardingComplete()) {
      //   if (state.subloc != '/onboarding') {
      //     return '/onboarding';
      //   }
      // }
      final loggedIn = authRepository.currentUser != null;
      //
      // if (loggedIn) {
      //   if (state.subloc.startsWith('/signIn')) {
      //     return '/dashboard';
      //   }
      // } else {
      //   return '/signIn';
      // }
      if (loggedIn && !state.subloc.startsWith('/dashboard')) {
        return '/dashboard';
      } else if (!loggedIn && !state.subloc.startsWith('/signIn')) {
        return '/signIn';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
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
                child: const Dashboard(),
              )),
    ],
  );
});
