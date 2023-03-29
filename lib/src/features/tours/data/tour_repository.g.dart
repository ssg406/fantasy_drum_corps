// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseFirestoreHash() => r'bcd0de65a93e6108353c348ea0c88ca8795a64ae';

/// See also [firebaseFirestore].
@ProviderFor(firebaseFirestore)
final firebaseFirestoreProvider =
    AutoDisposeProvider<FirebaseFirestore>.internal(
  firebaseFirestore,
  name: r'firebaseFirestoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firebaseFirestoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseFirestoreRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$toursRepositoryHash() => r'442d864df6637d552699989357120f760734dd06';

/// See also [toursRepository].
@ProviderFor(toursRepository)
final toursRepositoryProvider = AutoDisposeProvider<ToursRepository>.internal(
  toursRepository,
  name: r'toursRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$toursRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ToursRepositoryRef = AutoDisposeProviderRef<ToursRepository>;
String _$fetchTourHash() => r'86be6826c0efbe83d2723a2e0e7e3ac32f73b1a3';

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

typedef FetchTourRef = AutoDisposeFutureProviderRef<Tour?>;

/// See also [fetchTour].
@ProviderFor(fetchTour)
const fetchTourProvider = FetchTourFamily();

/// See also [fetchTour].
class FetchTourFamily extends Family<AsyncValue<Tour?>> {
  /// See also [fetchTour].
  const FetchTourFamily();

  /// See also [fetchTour].
  FetchTourProvider call(
    String tourId,
  ) {
    return FetchTourProvider(
      tourId,
    );
  }

  @override
  FetchTourProvider getProviderOverride(
    covariant FetchTourProvider provider,
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
  String? get name => r'fetchTourProvider';
}

/// See also [fetchTour].
class FetchTourProvider extends AutoDisposeFutureProvider<Tour?> {
  /// See also [fetchTour].
  FetchTourProvider(
    this.tourId,
  ) : super.internal(
          (ref) => fetchTour(
            ref,
            tourId,
          ),
          from: fetchTourProvider,
          name: r'fetchTourProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchTourHash,
          dependencies: FetchTourFamily._dependencies,
          allTransitiveDependencies: FetchTourFamily._allTransitiveDependencies,
        );

  final String tourId;

  @override
  bool operator ==(Object other) {
    return other is FetchTourProvider && other.tourId == tourId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tourId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$watchJoinedToursHash() => r'5aad5a23dd6cddb927b877b0337941750255859e';

/// See also [watchJoinedTours].
@ProviderFor(watchJoinedTours)
final watchJoinedToursProvider = AutoDisposeStreamProvider<List<Tour>>.internal(
  watchJoinedTours,
  name: r'watchJoinedToursProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchJoinedToursHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchJoinedToursRef = AutoDisposeStreamProviderRef<List<Tour>>;
String _$watchOwnedToursHash() => r'8d78735105a8977965f3a2a121b0a106bee9b93e';

/// See also [watchOwnedTours].
@ProviderFor(watchOwnedTours)
final watchOwnedToursProvider = AutoDisposeStreamProvider<List<Tour>>.internal(
  watchOwnedTours,
  name: r'watchOwnedToursProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchOwnedToursHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchOwnedToursRef = AutoDisposeStreamProviderRef<List<Tour>>;
String _$watchAllToursHash() => r'd5fa1216969e9d74068b771cc3aa1f9aa39e352d';
typedef WatchAllToursRef = AutoDisposeStreamProviderRef<List<Tour>>;

/// See also [watchAllTours].
@ProviderFor(watchAllTours)
const watchAllToursProvider = WatchAllToursFamily();

/// See also [watchAllTours].
class WatchAllToursFamily extends Family<AsyncValue<List<Tour>>> {
  /// See also [watchAllTours].
  const WatchAllToursFamily();

  /// See also [watchAllTours].
  WatchAllToursProvider call(
    bool watchPublicOnly,
  ) {
    return WatchAllToursProvider(
      watchPublicOnly,
    );
  }

  @override
  WatchAllToursProvider getProviderOverride(
    covariant WatchAllToursProvider provider,
  ) {
    return call(
      provider.watchPublicOnly,
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
  String? get name => r'watchAllToursProvider';
}

/// See also [watchAllTours].
class WatchAllToursProvider extends AutoDisposeStreamProvider<List<Tour>> {
  /// See also [watchAllTours].
  WatchAllToursProvider(
    this.watchPublicOnly,
  ) : super.internal(
          (ref) => watchAllTours(
            ref,
            watchPublicOnly,
          ),
          from: watchAllToursProvider,
          name: r'watchAllToursProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchAllToursHash,
          dependencies: WatchAllToursFamily._dependencies,
          allTransitiveDependencies:
              WatchAllToursFamily._allTransitiveDependencies,
        );

  final bool watchPublicOnly;

  @override
  bool operator ==(Object other) {
    return other is WatchAllToursProvider &&
        other.watchPublicOnly == watchPublicOnly;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, watchPublicOnly.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
