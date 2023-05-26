import 'package:fantasy_drum_corps/src/features/draft/data/remaining_picks_repository.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/data/fantasy_corps_repository.dart';
import 'package:fantasy_drum_corps/src/features/tours/data/tour_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tour_corps_service.g.dart';

class TourCorpsService {
  const TourCorpsService(this.toursRepository,
      this.corpsRepository,
      this.picksRepository,);

  final ToursRepository toursRepository;
  final FantasyCorpsRepository corpsRepository;
  final RemainingPicksRepository picksRepository;

  // Removes all corps in a tour and resets draft status
  Future<void> resetTourDraft(String tourId) async {
    // Reset draft complete flag
    final tour = await toursRepository.fetchTour(tourId: tourId);
    if (tour == null) {
      throw ArgumentError('Tour to reset could not be found.');
    }
    toursRepository.updateTour(tour.copyWith(draftComplete: false));

    // Remove remaining picks if present
    final remainingPicks = await picksRepository.fetchTourRemainingPicks(
        tourId);
    if (remainingPicks != null) {
      picksRepository.deleteTourRemainingPicks(remainingPicks.id!);
    }

    // delete all associated fantasy corps
    await corpsRepository.deleteAllTourFantasyCorps(tourId);
  }
}

@riverpod
TourCorpsService tourCorpsService(TourCorpsServiceRef ref) =>
    TourCorpsService(ref.watch(toursRepositoryProvider),
        ref.watch(fantasyCorpsRepositoryProvider),
        ref.watch(remainingPicksRepositoryProvider));
