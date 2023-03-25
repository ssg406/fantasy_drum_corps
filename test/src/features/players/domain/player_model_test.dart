
import 'package:fantasy_drum_corps/src/features/players/domain/player_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([MockPlayer])
class MockPlayer extends Mock implements Player {}
