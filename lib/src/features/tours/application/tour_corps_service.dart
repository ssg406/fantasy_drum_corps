import 'package:fantasy_drum_corps/src/features/draft/data/remaining_picks_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/tour_model.dart';

part 'tour_corps_service.g.dart';

class TourCorpsService {
  const TourCorpsService(
    this.toursRepository,
    this.corpsRepository,
    this.picksRepository,
  );

  final ToursRepository toursRepository;
  final FantasyCorpsRepository corpsRepository;
  final RemainingPicksRepository picksRepository;

  // Removes all corps in a tour and deletes the tour
  Future<void> deleteTour(String tourId) async {
    // Remove remaining picks should they exist
    await _deleteRemainingPicks(tourId);

    // Remove any fantasy corps created
    await _deleteTourFantasyCorps(tourId);

    // Delete the tour
    await toursRepository.deleteTour(tourId: tourId);
  }

  // Removes all corps in a tour and resets draft status
  Future<void> resetTourDraft(String tourId) async {
    // Reset draft complete flag
    final tour = await toursRepository.fetchTour(tourId: tourId);
    if (tour == null) {
      throw ArgumentError('Tour to reset could not be found.');
    }
    await _resetDraftComplete(tour);

    // Remove remaining picks
    await _deleteRemainingPicks(tourId);

    // delete all associated fantasy corps
    await _deleteTourFantasyCorps(tourId);
  }

  Future<void> _resetDraftComplete(Tour tour) =>
      toursRepository.updateTour(tour.copyWith(draftComplete: false));

  Future<void> _deleteRemainingPicks(String tourId) =>
      picksRepository.deleteTourRemainingPicks(tourId);

  Future<void> _deleteTourFantasyCorps(String tourId) =>
      corpsRepository.deleteAllTourFantasyCorps(tourId);
}

@riverpod
TourCorpsService tourCorpsService(TourCorpsServiceRef ref) => TourCorpsService(
    ref.watch(toursRepositoryProvider),
    ref.watch(fantasyCorpsRepositoryProvider),
    ref.watch(remainingPicksRepositoryProvider));
