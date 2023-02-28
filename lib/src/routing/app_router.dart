import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_form_type.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/register_screen/register_screen.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_main.dart';
import 'package:fantasy_drum_corps/src/features/leagues/presentation/create_league.dart';
import 'package:fantasy_drum_corps/src/features/leagues/presentation/league_overview_screen.dart';
import 'package:fantasy_drum_corps/src/features/onboarding/data/onboarding_repository.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/profile_screen.dart';
import 'package:fantasy_drum_corps/src/routing/go_router_refresh_stream.dart';
import 'package:fantasy_drum_corps/src/routing/ui_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authenticate_screen.dart';
import 'package:fantasy_drum_corps/src/features/onboarding/presentation/onboarding_screen.dart';

// Navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoutes { signIn, dashboard, leagues, profile, createLeague, register }

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final onboardingRepository = ref.watch(onboardingRepositoryProvider);
  return GoRouter(
    initialLocation: '/register',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    redirect: (context, state) {
      // If onboarding is not complete and user is not at onboarding page,
      // redirect to onboarding page.

      final loggedIn = authRepository.currentUser != null;
      // If logged in
      if (loggedIn) {
        // If at register or sign in pages
        if (state.subloc.startsWith('/register') ||
            state.subloc.startsWith('/signIn')) {
          // Redirect to dashboard
          return '/dashboard';
        }
        // If not logged in
      } else {
        // If not at sign in and not at register
        if (!state.subloc.startsWith('/signin') &&
            !state.subloc.startsWith('/register')) {
          // if already onboarded
          if (onboardingRepository.isOnboardingComplete()) {
            // Redirect to sign in
            return '/signIn';
            // If not onboarded
          } else {
            // Redirect to register
            return '/register';
          }
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/signIn',
        name: AppRoutes.signIn.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const AuthenticateScreen(),
        ),
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.register.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const RegistrationScreen(),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return NavShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            name: AppRoutes.dashboard.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const Dashboard(),
            ),
          ),
          GoRoute(
            path: '/leagues',
            name: AppRoutes.leagues.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const LeaguesMain(),
            ),
            routes: [
              GoRoute(
                path: 'create',
                name: AppRoutes.createLeague.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const CreateLeague(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            name: AppRoutes.profile.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const UserProfile(),
            ),
          ),
        ],
      ),
    ],
  );
});
