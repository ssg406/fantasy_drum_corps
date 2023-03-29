import 'dart:async';

import 'package:fantasy_drum_corps/src/features/authentication/data/auth_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/domain/tour_model.dart';
import 'package:fantasy_drum_corps/src/features/tours/presentation/create_tour/create_tour.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_tour_controller.g.dart';

/// Controller for [CreateTour]
@riverpod
class CreateTourController extends _$CreateTourController {
  @override
  FutureOr<void> build() {}

  Future<void> updateTour(Tour tour) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _updateTour(tour));
  }

  Future<void> _updateTour(Tour tour) {
    final toursRepository = ref.read(toursRepositoryProvider);
    return toursRepository.updateTour(tour);
  }

  Future<void> submitTour({required String name,
    required String description,
    required bool isPublic,
    String? password,
    required DateTime draftDateTime}) async {
    state = const AsyncValue.loading();
    final user = ref
        .watch(authRepositoryProvider)
        .currentUser;
    if (user == null) {
      throw AssertionError('User cannot be null when creating tour');
    }
    final owner = user.uid;
    final members = [owner];
    final tour = Tour(
        name: name,
        description: description,
        isPublic: isPublic,
        password: password,
        owner: owner,
        members: members,
        draftDateTime: draftDateTime);
    state = await AsyncValue.guard(() => _submitLeague(tour));
  }

  Future<void> _submitLeague(Tour tour) {
    final tourRepository = ref.read(toursRepositoryProvider);
    return tourRepository.addTour(tour);
  }
}
