// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_repository.dart';

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
String _$playersRepositoryHash() => r'8ab8ad1ad101a7d7c808fd91f7841daca479cc78';

/// See also [playersRepository].
@ProviderFor(playersRepository)
final playersRepositoryProvider =
    AutoDisposeProvider<PlayersRepository>.internal(
  playersRepository,
  name: r'playersRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$playersRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayersRepositoryRef = AutoDisposeProviderRef<PlayersRepository>;
String _$playerStreamHash() => r'adb28a689a70e68348dac2d5487b84bfa8db88e1';

/// See also [playerStream].
@ProviderFor(playerStream)
final playerStreamProvider = AutoDisposeStreamProvider<Player?>.internal(
  playerStream,
  name: r'playerStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playerStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayerStreamRef = AutoDisposeStreamProviderRef<Player?>;
String _$playerStreamByIdHash() => r'f8a61e629dca28e8f8423201a11eae219049678f';

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

/// See also [playerStreamById].
@ProviderFor(playerStreamById)
const playerStreamByIdProvider = PlayerStreamByIdFamily();

/// See also [playerStreamById].
class PlayerStreamByIdFamily extends Family<AsyncValue<Player?>> {
  /// See also [playerStreamById].
  const PlayerStreamByIdFamily();

  /// See also [playerStreamById].
  PlayerStreamByIdProvider call(
    String id,
  ) {
    return PlayerStreamByIdProvider(
      id,
    );
  }

  @override
  PlayerStreamByIdProvider getProviderOverride(
    covariant PlayerStreamByIdProvider provider,
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
  String? get name => r'playerStreamByIdProvider';
}

/// See also [playerStreamById].
class PlayerStreamByIdProvider extends AutoDisposeStreamProvider<Player?> {
  /// See also [playerStreamById].
  PlayerStreamByIdProvider(
    String id,
  ) : this._internal(
          (ref) => playerStreamById(
            ref as PlayerStreamByIdRef,
            id,
          ),
          from: playerStreamByIdProvider,
          name: r'playerStreamByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$playerStreamByIdHash,
          dependencies: PlayerStreamByIdFamily._dependencies,
          allTransitiveDependencies:
              PlayerStreamByIdFamily._allTransitiveDependencies,
          id: id,
        );

  PlayerStreamByIdProvider._internal(
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
    Stream<Player?> Function(PlayerStreamByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlayerStreamByIdProvider._internal(
        (ref) => create(ref as PlayerStreamByIdRef),
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
  AutoDisposeStreamProviderElement<Player?> createElement() {
    return _PlayerStreamByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlayerStreamByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlayerStreamByIdRef on AutoDisposeStreamProviderRef<Player?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PlayerStreamByIdProviderElement
    extends AutoDisposeStreamProviderElement<Player?> with PlayerStreamByIdRef {
  _PlayerStreamByIdProviderElement(super.provider);

  @override
  String get id => (origin as PlayerStreamByIdProvider).id;
}

String _$setDisplayNameHash() => r'e3b78350bd2c9af10ac3ee8d5089380de38dc962';

/// See also [setDisplayName].
@ProviderFor(setDisplayName)
const setDisplayNameProvider = SetDisplayNameFamily();

/// See also [setDisplayName].
class SetDisplayNameFamily extends Family<AsyncValue<void>> {
  /// See also [setDisplayName].
  const SetDisplayNameFamily();

  /// See also [setDisplayName].
  SetDisplayNameProvider call({
    required String displayName,
  }) {
    return SetDisplayNameProvider(
      displayName: displayName,
    );
  }

  @override
  SetDisplayNameProvider getProviderOverride(
    covariant SetDisplayNameProvider provider,
  ) {
    return call(
      displayName: provider.displayName,
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
  String? get name => r'setDisplayNameProvider';
}

/// See also [setDisplayName].
class SetDisplayNameProvider extends AutoDisposeFutureProvider<void> {
  /// See also [setDisplayName].
  SetDisplayNameProvider({
    required String displayName,
  }) : this._internal(
          (ref) => setDisplayName(
            ref as SetDisplayNameRef,
            displayName: displayName,
          ),
          from: setDisplayNameProvider,
          name: r'setDisplayNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setDisplayNameHash,
          dependencies: SetDisplayNameFamily._dependencies,
          allTransitiveDependencies:
              SetDisplayNameFamily._allTransitiveDependencies,
          displayName: displayName,
        );

  SetDisplayNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.displayName,
  }) : super.internal();

  final String displayName;

  @override
  Override overrideWith(
    FutureOr<void> Function(SetDisplayNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetDisplayNameProvider._internal(
        (ref) => create(ref as SetDisplayNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        displayName: displayName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SetDisplayNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetDisplayNameProvider && other.displayName == displayName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, displayName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SetDisplayNameRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `displayName` of this provider.
  String get displayName;
}

class _SetDisplayNameProviderElement
    extends AutoDisposeFutureProviderElement<void> with SetDisplayNameRef {
  _SetDisplayNameProviderElement(super.provider);

  @override
  String get displayName => (origin as SetDisplayNameProvider).displayName;
}

String _$setSelectedCorpsHash() => r'badf3e2b405876803d3b929a73ba60cef3725da1';

/// See also [setSelectedCorps].
@ProviderFor(setSelectedCorps)
const setSelectedCorpsProvider = SetSelectedCorpsFamily();

/// See also [setSelectedCorps].
class SetSelectedCorpsFamily extends Family<AsyncValue<void>> {
  /// See also [setSelectedCorps].
  const SetSelectedCorpsFamily();

  /// See also [setSelectedCorps].
  SetSelectedCorpsProvider call({
    required DrumCorps selectedCorps,
  }) {
    return SetSelectedCorpsProvider(
      selectedCorps: selectedCorps,
    );
  }

  @override
  SetSelectedCorpsProvider getProviderOverride(
    covariant SetSelectedCorpsProvider provider,
  ) {
    return call(
      selectedCorps: provider.selectedCorps,
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
  String? get name => r'setSelectedCorpsProvider';
}

/// See also [setSelectedCorps].
class SetSelectedCorpsProvider extends AutoDisposeFutureProvider<void> {
  /// See also [setSelectedCorps].
  SetSelectedCorpsProvider({
    required DrumCorps selectedCorps,
  }) : this._internal(
          (ref) => setSelectedCorps(
            ref as SetSelectedCorpsRef,
            selectedCorps: selectedCorps,
          ),
          from: setSelectedCorpsProvider,
          name: r'setSelectedCorpsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setSelectedCorpsHash,
          dependencies: SetSelectedCorpsFamily._dependencies,
          allTransitiveDependencies:
              SetSelectedCorpsFamily._allTransitiveDependencies,
          selectedCorps: selectedCorps,
        );

  SetSelectedCorpsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.selectedCorps,
  }) : super.internal();

  final DrumCorps selectedCorps;

  @override
  Override overrideWith(
    FutureOr<void> Function(SetSelectedCorpsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SetSelectedCorpsProvider._internal(
        (ref) => create(ref as SetSelectedCorpsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        selectedCorps: selectedCorps,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SetSelectedCorpsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SetSelectedCorpsProvider &&
        other.selectedCorps == selectedCorps;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, selectedCorps.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SetSelectedCorpsRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `selectedCorps` of this provider.
  DrumCorps get selectedCorps;
}

class _SetSelectedCorpsProviderElement
    extends AutoDisposeFutureProviderElement<void> with SetSelectedCorpsRef {
  _SetSelectedCorpsProviderElement(super.provider);

  @override
  DrumCorps get selectedCorps =>
      (origin as SetSelectedCorpsProvider).selectedCorps;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
