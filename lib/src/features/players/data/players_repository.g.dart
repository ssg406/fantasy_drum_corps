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

typedef PlayerStreamByIdRef = AutoDisposeStreamProviderRef<Player?>;

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
    this.id,
  ) : super.internal(
          (ref) => playerStreamById(
            ref,
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
        );

  final String id;

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

String _$setDisplayNameHash() => r'e3b78350bd2c9af10ac3ee8d5089380de38dc962';
typedef SetDisplayNameRef = AutoDisposeFutureProviderRef<void>;

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
    required this.displayName,
  }) : super.internal(
          (ref) => setDisplayName(
            ref,
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
        );

  final String displayName;

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

String _$setSelectedCorpsHash() => r'badf3e2b405876803d3b929a73ba60cef3725da1';
typedef SetSelectedCorpsRef = AutoDisposeFutureProviderRef<void>;

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
    required this.selectedCorps,
  }) : super.internal(
          (ref) => setSelectedCorps(
            ref,
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
        );

  final DrumCorps selectedCorps;

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

String _$setPhotoUrlHash() => r'be732e2f13d90c4d2d7c7ac26b7872826e282f70';
typedef SetPhotoUrlRef = AutoDisposeFutureProviderRef<void>;

/// See also [setPhotoUrl].
@ProviderFor(setPhotoUrl)
const setPhotoUrlProvider = SetPhotoUrlFamily();

/// See also [setPhotoUrl].
class SetPhotoUrlFamily extends Family<AsyncValue<void>> {
  /// See also [setPhotoUrl].
  const SetPhotoUrlFamily();

  /// See also [setPhotoUrl].
  SetPhotoUrlProvider call({
    required String url,
  }) {
    return SetPhotoUrlProvider(
      url: url,
    );
  }

  @override
  SetPhotoUrlProvider getProviderOverride(
    covariant SetPhotoUrlProvider provider,
  ) {
    return call(
      url: provider.url,
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
  String? get name => r'setPhotoUrlProvider';
}

/// See also [setPhotoUrl].
class SetPhotoUrlProvider extends AutoDisposeFutureProvider<void> {
  /// See also [setPhotoUrl].
  SetPhotoUrlProvider({
    required this.url,
  }) : super.internal(
          (ref) => setPhotoUrl(
            ref,
            url: url,
          ),
          from: setPhotoUrlProvider,
          name: r'setPhotoUrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$setPhotoUrlHash,
          dependencies: SetPhotoUrlFamily._dependencies,
          allTransitiveDependencies:
              SetPhotoUrlFamily._allTransitiveDependencies,
        );

  final String url;

  @override
  bool operator ==(Object other) {
    return other is SetPhotoUrlProvider && other.url == url;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, url.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$clearPhotoUrlHash() => r'a371683bda60ba3065691fb0a732733d16901dc7';

/// See also [clearPhotoUrl].
@ProviderFor(clearPhotoUrl)
final clearPhotoUrlProvider = AutoDisposeFutureProvider<void>.internal(
  clearPhotoUrl,
  name: r'clearPhotoUrlProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clearPhotoUrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ClearPhotoUrlRef = AutoDisposeFutureProviderRef<void>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
