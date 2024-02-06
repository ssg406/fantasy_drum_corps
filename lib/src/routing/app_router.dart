import 'package:fantasy_drum_corps/src/features/about/presentation/about_page.dart';
import 'package:fantasy_drum_corps/src/features/about/presentation/how_to_play.dart';
import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:fantasy_drum_corps/src/features/admin/presentation/admin_main.dart';
import 'package:fantasy_drum_corps/src/features/admin/presentation/admin_scores.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authenticate_screen.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_form_type.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_main.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft/draft_lobby.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/presentation/create_fantasy_corps/create_fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/flutter_moji_customizer/flutter_moji_picker.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/profile_screen.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/create_tour.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/search_tours/search_tours.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_detail.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:fantasy_drum_corps/src/routing/go_router_refresh_stream.dart';
import 'package:fantasy_drum_corps/src/routing/presentation/error_page.dart';
import 'package:fantasy_drum_corps/src/routing/presentation/ui_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

// Navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
// ignore: unsupported_provider_value
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
      initialLocation: '/sign-in',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      redirect: (context, state) {
        final currentUser = authRepository.currentUser;
        final isLoggedIn = currentUser != null;
        if (isLoggedIn) {
          // If logged in and at the sign in page, go to dashboard
          if (state.matchedLocation.startsWith('/sign-in')) {
            return '/dashboard';
          }
          // If location is under admin pages
          final adminUids = [
            'dWC5c0tJL3aA450l76gqktSxSUN2',
            '6QatDzHl9PNN4DQOsK304aqCeMB2',
            'BiWZp0rcwGgAD2ac2YkExxJFLx73'
          ];
          if (state.matchedLocation.startsWith('/admin')) {
            // And UID is not Sam's, Kenny's, or Ben's
            if (!adminUids.contains(currentUser.uid)) {
              // Send back to dashboard
              return '/dashboard';
            }
          }
          // If not logged in and at any internal page, go back to sign in
        } else {
          if (state.matchedLocation.startsWith('/dashboard') ||
              state.matchedLocation.startsWith('/profile') ||
              state.matchedLocation.startsWith('/tours') ||
              state.matchedLocation.startsWith('/about') ||
              state.matchedLocation.startsWith('/admin') ||
              state.matchedLocation.startsWith('/how-to-play') ||
              state.matchedLocation.startsWith('/leaderboard')) {
            return '/sign-in';
          }
        }

        return null;
      },
      errorBuilder: (context, state) => const RouterErrorPage(),
      routes: [
        GoRoute(
          path: '/sign-in',
          name: AppRoutes.signIn.name,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const AuthenticateScreen(
                formType: AuthenticationFormType.signIn),
          ),
        ),
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => NavShell(child: child),
            routes: [
              GoRoute(
                path: '/about',
                name: AppRoutes.about.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const AboutPage(),
                ),
              ),
              GoRoute(
                path: '/how-to-play',
                name: AppRoutes.howToPlay.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const HowToPlay(),
                ),
              ),
              GoRoute(
                path: '/dashboard',
                name: AppRoutes.dashboard.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const Dashboard(),
                ),
              ),
              GoRoute(
                path: '/create-tour',
                name: AppRoutes.createTour.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const CreateTour(),
                ),
              ),
              GoRoute(
                path: '/search-tours',
                name: AppRoutes.searchTours.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const SearchTours(),
                ),
              ),
              GoRoute(
                path: '/tour/:tid',
                name: AppRoutes.tourDetail.name,
                pageBuilder: (context, state) {
                  final tourId = state.pathParameters['tid'] as String;
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: TourDetail(tourId: tourId),
                  );
                },
                // Individual tour sub routes
                routes: [
                  GoRoute(
                    path: 'create-corps',
                    name: AppRoutes.createCorps.name,
                    pageBuilder: (context, state) {
                      final fantasyCorps = state.extra as FantasyCorps?;
                      return NoTransitionPage(
                        key: state.pageKey,
                        child: CreateFantasyCorps(fantasyCorps: fantasyCorps),
                      );
                    },
                  ),
                  GoRoute(
                      path: 'edit-corps',
                      name: AppRoutes.editCorps.name,
                      pageBuilder: (context, state) {
                        final fantasyCorps = state.extra as FantasyCorps?;
                        return NoTransitionPage(
                          child: CreateFantasyCorps(
                            fantasyCorps: fantasyCorps,
                            isEditing: true,
                          ),
                        );
                      }),
                  GoRoute(
                    path: 'edit-tour',
                    name: AppRoutes.editTour.name,
                    pageBuilder: (context, state) {
                      final tourId = state.pathParameters['tid']!;
                      return NoTransitionPage(
                        key: state.pageKey,
                        child: CreateTour(tourId: tourId),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'draft-lobby',
                    name: AppRoutes.draftLobby.name,
                    pageBuilder: (context, state) {
                      final tourId = state.pathParameters['tid'];
                      return NoTransitionPage(
                          key: state.pageKey,
                          child: DraftLobby(tourId: tourId));
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/profile',
                name: AppRoutes.profile.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const UserProfile(),
                ),
                // Profile sub route
                routes: [
                  GoRoute(
                    path: ':uid/create-avatar',
                    name: AppRoutes.createFluttermoji.name,
                    pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: FlutterMojiPicker(
                          playerId: state.pathParameters['uid']!),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: '/admin',
                name: AppRoutes.adminMain.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: const AdminMain(),
                ),
                routes: [
                  GoRoute(
                    path: 'add-score',
                    name: AppRoutes.adminAddScore.name,
                    pageBuilder: (context, state) {
                      return NoTransitionPage(
                        key: state.pageKey,
                        child:
                            AdminScores(corpsScore: state.extra as CorpsScore?),
                      );
                    },
                  ),
                ],
              ),
            ]),
      ]);
}
