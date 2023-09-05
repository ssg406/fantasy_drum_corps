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
String _$watchTourPlayersHash() => r'1640ac7df6b6b1b64179d0633da7c3463da4db31';

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

/// See also [watchTourPlayers].
@ProviderFor(watchTourPlayers)
const watchTourPlayersProvider = WatchTourPlayersFamily();

/// See also [watchTourPlayers].
class WatchTourPlayersFamily extends Family<AsyncValue<List<Player>>> {
  /// See also [watchTourPlayers].
  const WatchTourPlayersFamily();

  /// See also [watchTourPlayers].
  WatchTourPlayersProvider call(
    List<String> members,
  ) {
    return WatchTourPlayersProvider(
      members,
    );
  }

  @override
  WatchTourPlayersProvider getProviderOverride(
    covariant WatchTourPlayersProvider provider,
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
  String? get name => r'watchTourPlayersProvider';
}

/// See also [watchTourPlayers].
class WatchTourPlayersProvider extends AutoDisposeStreamProvider<List<Player>> {
  /// See also [watchTourPlayers].
  WatchTourPlayersProvider(
    List<String> members,
  ) : this._internal(
          (ref) => watchTourPlayers(
            ref as WatchTourPlayersRef,
            members,
          ),
          from: watchTourPlayersProvider,
          name: r'watchTourPlayersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchTourPlayersHash,
          dependencies: WatchTourPlayersFamily._dependencies,
          allTransitiveDependencies:
              WatchTourPlayersFamily._allTransitiveDependencies,
          members: members,
        );

  WatchTourPlayersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.members,
  }) : super.internal();

  final List<String> members;

  @override
  Override overrideWith(
    Stream<List<Player>> Function(WatchTourPlayersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchTourPlayersProvider._internal(
        (ref) => create(ref as WatchTourPlayersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        members: members,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Player>> createElement() {
    return _WatchTourPlayersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchTourPlayersProvider && other.members == members;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, members.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchTourPlayersRef on AutoDisposeStreamProviderRef<List<Player>> {
  /// The parameter `members` of this provider.
  List<String> get members;
}

class _WatchTourPlayersProviderElement
    extends AutoDisposeStreamProviderElement<List<Player>>
    with WatchTourPlayersRef {
  _WatchTourPlayersProviderElement(super.provider);

  @override
  List<String> get members => (origin as WatchTourPlayersProvider).members;
}

String _$fetchTourPlayersHash() => r'9b7945746aae4986cc1d7136e516fb3c0557684f';

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
    List<String> members,
  ) : this._internal(
          (ref) => fetchTourPlayers(
            ref as FetchTourPlayersRef,
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
          members: members,
        );

  FetchTourPlayersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.members,
  }) : super.internal();

  final List<String> members;

  @override
  Override overrideWith(
    FutureOr<List<Player>> Function(FetchTourPlayersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchTourPlayersProvider._internal(
        (ref) => create(ref as FetchTourPlayersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        members: members,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Player>> createElement() {
    return _FetchTourPlayersProviderElement(this);
  }

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

mixin FetchTourPlayersRef on AutoDisposeFutureProviderRef<List<Player>> {
  /// The parameter `members` of this provider.
  List<String> get members;
}

class _FetchTourPlayersProviderElement
    extends AutoDisposeFutureProviderElement<List<Player>>
    with FetchTourPlayersRef {
  _FetchTourPlayersProviderElement(super.provider);

  @override
  List<String> get members => (origin as FetchTourPlayersProvider).members;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
