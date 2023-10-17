// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$scoresRepositoryHash() => r'ebd96cbf66c7fc45975ed4312b9e956486b1dd03';

/// See also [scoresRepository].
@ProviderFor(scoresRepository)
final scoresRepositoryProvider = AutoDisposeProvider<ScoresRepository>.internal(
  scoresRepository,
  name: r'scoresRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scoresRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ScoresRepositoryRef = AutoDisposeProviderRef<ScoresRepository>;
String _$watchAllCorpsScoreHash() =>
    r'cf3234de2f46f6a2a05f585b33b654f52042b689';

/// See also [watchAllCorpsScore].
@ProviderFor(watchAllCorpsScore)
final watchAllCorpsScoreProvider =
    AutoDisposeStreamProvider<List<CorpsScore>>.internal(
  watchAllCorpsScore,
  name: r'watchAllCorpsScoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchAllCorpsScoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchAllCorpsScoreRef = AutoDisposeStreamProviderRef<List<CorpsScore>>;
String _$watchCorpsScoreHash() => r'66cee6d8d821f7ea9af74ae04fa62f8dff21f71d';

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

/// See also [watchCorpsScore].
@ProviderFor(watchCorpsScore)
const watchCorpsScoreProvider = WatchCorpsScoreFamily();

/// See also [watchCorpsScore].
class WatchCorpsScoreFamily extends Family<AsyncValue<CorpsScore>> {
  /// See also [watchCorpsScore].
  const WatchCorpsScoreFamily();

  /// See also [watchCorpsScore].
  WatchCorpsScoreProvider call(
    String id,
  ) {
    return WatchCorpsScoreProvider(
      id,
    );
  }

  @override
  WatchCorpsScoreProvider getProviderOverride(
    covariant WatchCorpsScoreProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'watchCorpsScoreProvider';
}

/// See also [watchCorpsScore].
class WatchCorpsScoreProvider extends AutoDisposeStreamProvider<CorpsScore> {
  /// See also [watchCorpsScore].
  WatchCorpsScoreProvider(
    String id,
  ) : this._internal(
          (ref) => watchCorpsScore(
            ref as WatchCorpsScoreRef,
            id,
          ),
          from: watchCorpsScoreProvider,
          name: r'watchCorpsScoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchCorpsScoreHash,
          dependencies: WatchCorpsScoreFamily._dependencies,
          allTransitiveDependencies:
              WatchCorpsScoreFamily._allTransitiveDependencies,
          id: id,
        );

  WatchCorpsScoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<CorpsScore> Function(WatchCorpsScoreRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchCorpsScoreProvider._internal(
        (ref) => create(ref as WatchCorpsScoreRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<CorpsScore> createElement() {
    return _WatchCorpsScoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchCorpsScoreProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchCorpsScoreRef on AutoDisposeStreamProviderRef<CorpsScore> {
  /// The parameter `id` of this provider.
  String get id;
}

class _WatchCorpsScoreProviderElement
    extends AutoDisposeStreamProviderElement<CorpsScore>
    with WatchCorpsScoreRef {
  _WatchCorpsScoreProviderElement(super.provider);

  @override
  String get id => (origin as WatchCorpsScoreProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
