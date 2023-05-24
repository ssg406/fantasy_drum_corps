import 'package:fantasy_drum_corps/src/features/admin/domain/corps_score.dart';
import 'package:fantasy_drum_corps/src/features/admin/presentation/admin_main.dart';
import 'package:fantasy_drum_corps/src/features/admin/presentation/admin_scores.dart';
import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authenticate_screen.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authentication_form_type.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_main.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/draft_lobby.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/presentation/corps_detail/corps_detail.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/presentation/create_fantasy_corps/create_fantasy_corps.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/presentation/leaderboard/leaderboard.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/presentation/my_corps/my_corps.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/flutter_moji_customizer/flutter_moji_picker.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/profile_screen.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/create_tour.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/join_tour/join_tour.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/leave_tour/leave_tour.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/manage_tour/manage_tour.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/my_tours/my_tours.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/search_tours/search_tours.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail_page/tour_detail.dart';
import 'package:fantasy_drum_corps/src/routing/go_router_refresh_stream.dart';
import 'package:fantasy_drum_corps/src/routing/presentation/ui_shell.dart';
import 'package:fantasy_drum_corps/src/testpage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

// Navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoutes {
  signIn,
  dashboard,
  tours,
  profile,
  createTour,
  register,
  myTours,
  searchTours,
  tourDetail,
  draft,
  competitionSchedule,
  competitionDetail,
  competitionSubcaptionScores,
  rankings,
  allCorps,
  about,
  rules,
  faqs,
  contact,
  terms,
  editTour,
  joinTour,
  leaveTour,
  manageTour,
  createFluttermoji,
  draftLobby,
  createCorps,
  myCorps,
  corpsDetail,
  leaderboard,
  adminMain,
  adminAddScore,
}

@riverpod
// ignore: unsupported_provider_value
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    redirect: (context, state) {
      final currentUser = authRepository.currentUser;
      final isLoggedIn = currentUser != null;
      if (isLoggedIn) {
        // If logged in and at the sign in page, go to dashboard
        if (state.subloc.startsWith('/signIn')) {
          return '/dashboard';
        }
        // If location is under admin pages
        final adminUids = [
          'dWC5c0tJL3aA450l76gqktSxSUN2',
          '6QatDzHl9PNN4DQOsK304aqCeMB2',
          'BiWZp0rcwGgAD2ac2YkExxJFLx73'
        ];
        if (state.subloc.startsWith('/admin')) {
          // And UID is not Sam's, Kenny's, or Ben's
          if (!adminUids.contains(currentUser.uid)) {
            // Send back to dashboard
            return '/dashboard';
          }
        }
        // If not logged in and at any internal page, go back to sign in
      } else {
        if (state.subloc.startsWith('/dashboard') ||
            state.subloc.startsWith('/profile') ||
            state.subloc.startsWith('/tours') ||
            state.subloc.startsWith('/about') ||
            state.subloc.startsWith('/myCorps') ||
            state.subloc.startsWith('/leaderboard')) {
          return '/signIn';
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
          child: const AuthenticateScreen(
              formType: AuthenticationFormType.register),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return NavShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/testpage',
            pageBuilder: (context, state) =>
                const MaterialPage(child: TestPage()),
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
            path: '/tours',
            name: AppRoutes.tours.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const MyTours(),
            ),
            // Tours sub routes
            routes: [
              GoRoute(
                path: 'create',
                name: AppRoutes.createTour.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const CreateTour(),
                ),
              ),
              GoRoute(
                path: 'myTours',
                name: AppRoutes.myTours.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const MyTours(),
                ),
              ),
              GoRoute(
                path: 'searchTours',
                name: AppRoutes.searchTours.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const SearchTours(),
                ),
              ),
              GoRoute(
                path: ':tid',
                name: AppRoutes.tourDetail.name,
                pageBuilder: (context, state) {
                  final tourId = state.params['tid'] as String;
                  return MaterialPage(
                    fullscreenDialog: true,
                    key: state.pageKey,
                    child: TourDetail(tourId: tourId),
                  );
                },
                // Individual tour sub routes
                routes: [
                  GoRoute(
                      path: 'createCorps',
                      name: AppRoutes.createCorps.name,
                      pageBuilder: (context, state) {
                        final fantasyCorps = state.extra as FantasyCorps?;
                        return MaterialPage(
                          fullscreenDialog: true,
                          key: state.pageKey,
                          child: CreateFantasyCorps(fantasyCorps: fantasyCorps),
                        );
                      }),
                  GoRoute(
                      path: 'manage',
                      name: AppRoutes.manageTour.name,
                      pageBuilder: (context, state) {
                        final tourId = state.params['tid']!;
                        return NoTransitionPage(
                          key: state.pageKey,
                          child: ManageTour(tourId: tourId),
                        );
                      }),
                  GoRoute(
                      path: 'leave',
                      name: AppRoutes.leaveTour.name,
                      pageBuilder: (context, state) {
                        final tourId = state.params['tid']!;
                        return NoTransitionPage(
                          key: state.pageKey,
                          child: LeaveTour(tourId: tourId),
                        );
                      }),
                  GoRoute(
                      path: 'join',
                      name: AppRoutes.joinTour.name,
                      pageBuilder: (context, state) {
                        final tourId = state.params['tid']!;
                        return NoTransitionPage(
                          key: state.pageKey,
                          child: JoinTour(tourId: tourId),
                        );
                      }),
                  GoRoute(
                      path: 'edit',
                      name: AppRoutes.editTour.name,
                      pageBuilder: (context, state) {
                        final tourId = state.params['tid']!;
                        return NoTransitionPage(
                          key: state.pageKey,
                          child: CreateTour(tourId: tourId),
                        );
                      }),
                  GoRoute(
                    path: 'draftLobby',
                    name: AppRoutes.draftLobby.name,
                    pageBuilder: (context, state) {
                      final tourId = state.params['tid'];
                      return NoTransitionPage(
                          key: state.pageKey,
                          child: DraftLobby(tourId: tourId));
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
              path: '/myCorps',
              name: AppRoutes.myCorps.name,
              pageBuilder: (context, state) =>
                  NoTransitionPage(key: state.pageKey, child: const MyCorps()),
              routes: [
                GoRoute(
                    path: 'corpsDetail',
                    name: AppRoutes.corpsDetail.name,
                    pageBuilder: (context, state) => MaterialPage(
                          key: state.pageKey,
                          child: CorpsDetail(
                            fantasyCorps: state.extra as FantasyCorps?,
                          ),
                        ))
              ]),
          GoRoute(
            path: '/leaderboard',
            name: AppRoutes.leaderboard.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const Leaderboard(),
            ),
          ),
          GoRoute(
            path: '/profile',
            name: AppRoutes.profile.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const UserProfile(),
            ),
            // Profile sub route
            routes: [
              GoRoute(
                path: ':uid/createAvatar',
                name: AppRoutes.createFluttermoji.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: FlutterMojiPicker(playerId: state.params['uid']!),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/about',
            name: AppRoutes.about.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const Placeholder(),
            ),
            // About sub routes
            routes: [
              GoRoute(
                path: 'terms',
                name: AppRoutes.terms.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const Placeholder(),
                ),
              ),
              GoRoute(
                path: 'contact',
                name: AppRoutes.contact.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const Placeholder(),
                ),
              ),
              GoRoute(
                path: 'faqs',
                name: AppRoutes.faqs.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const Placeholder(),
                ),
              ),
              GoRoute(
                path: 'rules',
                name: AppRoutes.rules.name,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const Placeholder(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/admin',
            name: AppRoutes.adminMain.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: const AdminMain(),
            ),
            routes: [
              GoRoute(
                path: 'addScore',
                name: AppRoutes.adminAddScore.name,
                pageBuilder: (context, state) {
                  final corpsScore = state.extra as CorpsScore?;
                  return MaterialPage(
                      key: state.pageKey,
                      child: AdminScores(
                        corpsScore: corpsScore,
                      ));
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
