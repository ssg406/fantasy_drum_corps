// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_tour_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$playerTourServiceHash() => r'920afe2a858c2d049b485171bd16f2dd6584d14d';

/// See also [playerTourService].
@ProviderFor(playerTourService)
final playerTourServiceProvider =
    AutoDisposeProvider<PlayerTourService>.internal(
  playerTourService,
  name: r'playerTourServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playerTourServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayerTourServiceRef = AutoDisposeProviderRef<PlayerTourService>;
String _$fetchTourPlayersHash() => r'87e9cc1809e8d0a89b928a202349c7d1c0947ba9';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef FetchTourPlayersRef = AutoDisposeFutureProviderRef<List<Player>>;

/// See also [fetchTourPlayers].
@ProviderFor(fetchTourPlayers)
const fetchTourPlayersProvider = FetchTourPlayersFamily();

/// See also [fetchTourPlayers].
class FetchTourPlayersFamily extends Family<AsyncValue<List<Player>>> {
  /// See also [fetchTourPlayers].
  const FetchTourPlayersFamily();

  /// See also [fetchTourPlayers].
  FetchTourPlayersProvider call(
    List<String> members,
  ) {
    return FetchTourPlayersProvider(
      members,
    );
  }

  @override
  FetchTourPlayersProvider getProviderOverride(
    covariant FetchTourPlayersProvider provider,
  ) {
    return call(
      provider.members,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchTourPlayersProvider';
}

/// See also [fetchTourPlayers].
class FetchTourPlayersProvider extends AutoDisposeFutureProvider<List<Player>> {
  /// See also [fetchTourPlayers].
  FetchTourPlayersProvider(
    this.members,
  ) : super.internal(
          (ref) => fetchTourPlayers(
            ref,
            members,
          ),
          from: fetchTourPlayersProvider,
          name: r'fetchTourPlayersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchTourPlayersHash,
          dependencies: FetchTourPlayersFamily._dependencies,
          allTransitiveDependencies:
              FetchTourPlayersFamily._allTransitiveDependencies,
        );

  final List<String> members;

  @override
  bool operator ==(Object other) {
    return other is FetchTourPlayersProvider && other.members == members;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, members.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
