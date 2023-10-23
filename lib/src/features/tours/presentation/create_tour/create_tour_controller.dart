import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/create_tour.dart';
import 'package:fantasy_drum_corps/src/routing/app_router.dart';
import 'package:fantasy_drum_corps/src/routing/app_routes.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_tour_controller.g.dart';

/// [AsyncNotifierProvider] manages state for [CreateTour]
@riverpod
class CreateTourController extends _$CreateTourController {
  @override
  FutureOr<void> build() {}

  Future<void> updateTour(Tour tour) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(toursRepositoryProvider).updateTour(tour));
    ref.read(goRouterProvider).goNamed(AppRoutes.myTours.name);
  }

  Future<void> submitTour(Tour tour) async {
    state = const AsyncLoading();
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      throw AssertionError('User cannot be null when creating tour');
    }
    final finalizedTour = tour.copyWith(owner: user.uid, members: [user.uid]);
    state = await AsyncValue.guard(
        () => ref.read(toursRepositoryProvider).addTour(finalizedTour));
    ref.read(goRouterProvider).goNamed(AppRoutes.myTours.name);
  }
}
