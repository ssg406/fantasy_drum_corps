import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/authenticate_screen/authenticate_screen.dart';
import 'package:fantasy_drum_corps/src/features/authentication/presentation/register_screen/register_screen.dart';
import 'package:fantasy_drum_corps/src/features/competition/presentation/scheduled_matchup.dart';
import 'package:fantasy_drum_corps/src/features/competition/presentation/standings.dart';
import 'package:fantasy_drum_corps/src/features/competition/presentation/subcaption_results.dart';
import 'package:fantasy_drum_corps/src/features/dashboard/presentation/dashboard_main.dart';
import 'package:fantasy_drum_corps/src/features/draft/presentation/main_draft.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/profile_screen.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/join_tour.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/my_tours.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/tour_detail.dart';
import 'package:fantasy_drum_corps/src/routing/go_router_refresh_stream.dart';
import 'package:fantasy_drum_corps/src/routing/presentation/ui_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
  joinTour,
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
  terms
}

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return GoRouter(
      initialLocation: '/signIn',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      redirect: (context, state) {
        final isLoggedIn = authRepository.currentUser != null;
        if (isLoggedIn) {
          if (state.subloc.startsWith('/signIn') ||
              state.subloc.startsWith('/register')) {
            return '/dashboard';
          }
        } else {
          if (state.subloc.startsWith('/dashboard') ||
              state.subloc.startsWith('/leagues') ||
              state.subloc.startsWith('/profile')) {
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
              path: '/tours',
              name: AppRoutes.tours.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const MyTours(),
              ),
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
                  path: 'joinTour',
                  name: AppRoutes.joinTour.name,
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const JoinTour(),
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
                  routes: [
                    GoRoute(
                      path: 'draft',
                      name: AppRoutes.draft.name,
                      pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: const TourDraft() //state.params['id']
                          ),
                    ),
                    GoRoute(
                      path: 'competitionSchedule',
                      name: AppRoutes.competitionSchedule.name,
                      pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: const Placeholder() //state.params['id']
                          ),
                    ),
                    GoRoute(
                      path: 'results',
                      name: AppRoutes.competitionDetail.name,
                      pageBuilder: (context, state) => MaterialPage(
                          key: state.pageKey,
                          fullscreenDialog: true,
                          child: const WeeklyScores() // tid still in params
                          ),
                      routes: [
                        GoRoute(
                          path: 'subcaptionResults',
                          name: AppRoutes.competitionSubcaptionScores.name,
                          pageBuilder: (context, state) => MaterialPage(
                            key: state.pageKey,
                            fullscreenDialog: true,
                            child: const SubcaptionResults(),
                          ),
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'rankings',
                      name: AppRoutes.rankings.name,
                      pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: const Standings() //state.params['id']
                          ),
                    ),
                    GoRoute(
                      path: 'allCorps',
                      name: AppRoutes.allCorps.name,
                      pageBuilder: (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: const Placeholder() //state.params['id']
                          ),
                    ),
                  ],
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
            GoRoute(
              path: '/about',
              name: AppRoutes.about.name,
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const Placeholder(),
              ),
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
          ],
        ),
      ],
    );
  },
);
