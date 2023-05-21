// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fantasy_corps_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fantasyCorpsRepositoryHash() =>
    r'21b3cad7faec3d776feacf25286be894783d643a';

/// See also [fantasyCorpsRepository].
@ProviderFor(fantasyCorpsRepository)
final fantasyCorpsRepositoryProvider =
    AutoDisposeProvider<FantasyCorpsRepository>.internal(
  fantasyCorpsRepository,
  name: r'fantasyCorpsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fantasyCorpsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FantasyCorpsRepositoryRef
    = AutoDisposeProviderRef<FantasyCorpsRepository>;
String _$watchAllFantasyCorpsHash() =>
    r'3e24616e01d6c576ae614ded5868380ef6b058b0';

/// See also [watchAllFantasyCorps].
@ProviderFor(watchAllFantasyCorps)
final watchAllFantasyCorpsProvider =
    AutoDisposeStreamProvider<List<FantasyCorps>>.internal(
  watchAllFantasyCorps,
  name: r'watchAllFantasyCorpsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchAllFantasyCorpsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchAllFantasyCorpsRef
    = AutoDisposeStreamProviderRef<List<FantasyCorps>>;
String _$watchTourFantasyCorpsHash() =>
    r'00100dd39f6cfae783d78d688b7f1c37e3f868c4';

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

typedef WatchTourFantasyCorpsRef
    = AutoDisposeStreamProviderRef<List<FantasyCorps>>;

/// See also [watchTourFantasyCorps].
@ProviderFor(watchTourFantasyCorps)
const watchTourFantasyCorpsProvider = WatchTourFantasyCorpsFamily();

/// See also [watchTourFantasyCorps].
class WatchTourFantasyCorpsFamily
    extends Family<AsyncValue<List<FantasyCorps>>> {
  /// See also [watchTourFantasyCorps].
  const WatchTourFantasyCorpsFamily();

  /// See also [watchTourFantasyCorps].
  WatchTourFantasyCorpsProvider call(
    String tourId,
  ) {
    return WatchTourFantasyCorpsProvider(
      tourId,
    );
  }

  @override
  WatchTourFantasyCorpsProvider getProviderOverride(
    covariant WatchTourFantasyCorpsProvider provider,
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
  String? get name => r'watchTourFantasyCorpsProvider';
}

/// See also [watchTourFantasyCorps].
class WatchTourFantasyCorpsProvider
    extends AutoDisposeStreamProvider<List<FantasyCorps>> {
  /// See also [watchTourFantasyCorps].
  WatchTourFantasyCorpsProvider(
    this.tourId,
  ) : super.internal(
          (ref) => watchTourFantasyCorps(
            ref,
            tourId,
          ),
          from: watchTourFantasyCorpsProvider,
          name: r'watchTourFantasyCorpsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchTourFantasyCorpsHash,
          dependencies: WatchTourFantasyCorpsFamily._dependencies,
          allTransitiveDependencies:
              WatchTourFantasyCorpsFamily._allTransitiveDependencies,
        );

  final String tourId;

  @override
  bool operator ==(Object other) {
    return other is WatchTourFantasyCorpsProvider && other.tourId == tourId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tourId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$watchUserFantasyCorpsHash() =>
    r'9431846def479ac9ffecccc99af1774289988ce5';

/// See also [watchUserFantasyCorps].
@ProviderFor(watchUserFantasyCorps)
final watchUserFantasyCorpsProvider =
    AutoDisposeStreamProvider<List<FantasyCorps>>.internal(
  watchUserFantasyCorps,
  name: r'watchUserFantasyCorpsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchUserFantasyCorpsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchUserFantasyCorpsRef
    = AutoDisposeStreamProviderRef<List<FantasyCorps>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
