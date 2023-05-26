// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remaining_picks_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$remainingPicksRepositoryHash() =>
    r'2b0965e2e26d2853764d3a0180aaf372e55319ce';

/// See also [remainingPicksRepository].
@ProviderFor(remainingPicksRepository)
final remainingPicksRepositoryProvider =
    AutoDisposeProvider<RemainingPicksRepository>.internal(
  remainingPicksRepository,
  name: r'remainingPicksRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$remainingPicksRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RemainingPicksRepositoryRef
    = AutoDisposeProviderRef<RemainingPicksRepository>;
String _$fetchTourRemainingPicksHash() =>
    r'4de02361bc371039549d8434556a25b85a67b49b';

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

typedef FetchTourRemainingPicksRef
    = AutoDisposeFutureProviderRef<RemainingPicks?>;

/// See also [fetchTourRemainingPicks].
@ProviderFor(fetchTourRemainingPicks)
const fetchTourRemainingPicksProvider = FetchTourRemainingPicksFamily();

/// See also [fetchTourRemainingPicks].
class FetchTourRemainingPicksFamily
    extends Family<AsyncValue<RemainingPicks?>> {
  /// See also [fetchTourRemainingPicks].
  const FetchTourRemainingPicksFamily();

  /// See also [fetchTourRemainingPicks].
  FetchTourRemainingPicksProvider call(
    String tourId,
  ) {
    return FetchTourRemainingPicksProvider(
      tourId,
    );
  }

  @override
  FetchTourRemainingPicksProvider getProviderOverride(
    covariant FetchTourRemainingPicksProvider provider,
  ) {
    return call(
      provider.tourId,
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
  String? get name => r'fetchTourRemainingPicksProvider';
}

/// See also [fetchTourRemainingPicks].
class FetchTourRemainingPicksProvider
    extends AutoDisposeFutureProvider<RemainingPicks?> {
  /// See also [fetchTourRemainingPicks].
  FetchTourRemainingPicksProvider(
    this.tourId,
  ) : super.internal(
          (ref) => fetchTourRemainingPicks(
            ref,
            tourId,
          ),
          from: fetchTourRemainingPicksProvider,
          name: r'fetchTourRemainingPicksProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchTourRemainingPicksHash,
          dependencies: FetchTourRemainingPicksFamily._dependencies,
          allTransitiveDependencies:
              FetchTourRemainingPicksFamily._allTransitiveDependencies,
        );

  final String tourId;

  @override
  bool operator ==(Object other) {
    return other is FetchTourRemainingPicksProvider && other.tourId == tourId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tourId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
