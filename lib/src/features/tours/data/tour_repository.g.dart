// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tour_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseFirestoreHash() => r'bcd0de65a93e6108353c348ea0c88ca8795a64ae';

/// Generated Riverpod providers
///
/// Copied from [firebaseFirestore].
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
String _$watchTourHash() => r'4d77f7b8efbb7c3c6d7140b01916fd4cd1591ec5';

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

/// See also [watchTour].
@ProviderFor(watchTour)
const watchTourProvider = WatchTourFamily();

/// See also [watchTour].
class WatchTourFamily extends Family<AsyncValue<Tour?>> {
  /// See also [watchTour].
  const WatchTourFamily();

  /// See also [watchTour].
  WatchTourProvider call(
    String tourId,
  ) {
    return WatchTourProvider(
      tourId,
    );
  }

  @override
  WatchTourProvider getProviderOverride(
    covariant WatchTourProvider provider,
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
  String? get name => r'watchTourProvider';
}

/// See also [watchTour].
class WatchTourProvider extends AutoDisposeStreamProvider<Tour?> {
  /// See also [watchTour].
  WatchTourProvider(
    String tourId,
  ) : this._internal(
          (ref) => watchTour(
            ref as WatchTourRef,
            tourId,
          ),
          from: watchTourProvider,
          name: r'watchTourProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchTourHash,
          dependencies: WatchTourFamily._dependencies,
          allTransitiveDependencies: WatchTourFamily._allTransitiveDependencies,
          tourId: tourId,
        );

  WatchTourProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tourId,
  }) : super.internal();

  final String tourId;

  @override
  Override overrideWith(
    Stream<Tour?> Function(WatchTourRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchTourProvider._internal(
        (ref) => create(ref as WatchTourRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tourId: tourId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Tour?> createElement() {
    return _WatchTourProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchTourProvider && other.tourId == tourId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tourId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchTourRef on AutoDisposeStreamProviderRef<Tour?> {
  /// The parameter `tourId` of this provider.
  String get tourId;
}

class _WatchTourProviderElement extends AutoDisposeStreamProviderElement<Tour?>
    with WatchTourRef {
  _WatchTourProviderElement(super.provider);

  @override
  String get tourId => (origin as WatchTourProvider).tourId;
}

String _$fetchTourHash() => r'86be6826c0efbe83d2723a2e0e7e3ac32f73b1a3';

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
    String tourId,
  ) : this._internal(
          (ref) => fetchTour(
            ref as FetchTourRef,
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
          tourId: tourId,
        );

  FetchTourProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tourId,
  }) : super.internal();

  final String tourId;

  @override
  Override overrideWith(
    FutureOr<Tour?> Function(FetchTourRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchTourProvider._internal(
        (ref) => create(ref as FetchTourRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tourId: tourId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Tour?> createElement() {
    return _FetchTourProviderElement(this);
  }

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

mixin FetchTourRef on AutoDisposeFutureProviderRef<Tour?> {
  /// The parameter `tourId` of this provider.
  String get tourId;
}

class _FetchTourProviderElement extends AutoDisposeFutureProviderElement<Tour?>
    with FetchTourRef {
  _FetchTourProviderElement(super.provider);

  @override
  String get tourId => (origin as FetchTourProvider).tourId;
}

String _$watchJoinedToursHash() => r'd5809d33d7115878a1d2007f8fb93822623783b6';

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
String _$watchOwnedToursHash() => r'80ae4b3476f8e227381d62098d3126451f0558d9';

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
String _$addSelfToTourHash() => r'6523419213a25b8c2f7649a3acaf3a00cec278c5';

/// See also [addSelfToTour].
@ProviderFor(addSelfToTour)
const addSelfToTourProvider = AddSelfToTourFamily();

/// See also [addSelfToTour].
class AddSelfToTourFamily extends Family<AsyncValue<void>> {
  /// See also [addSelfToTour].
  const AddSelfToTourFamily();

  /// See also [addSelfToTour].
  AddSelfToTourProvider call(
    String tourId,
  ) {
    return AddSelfToTourProvider(
      tourId,
    );
  }

  @override
  AddSelfToTourProvider getProviderOverride(
    covariant AddSelfToTourProvider provider,
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
  String? get name => r'addSelfToTourProvider';
}

/// See also [addSelfToTour].
class AddSelfToTourProvider extends AutoDisposeFutureProvider<void> {
  /// See also [addSelfToTour].
  AddSelfToTourProvider(
    String tourId,
  ) : this._internal(
          (ref) => addSelfToTour(
            ref as AddSelfToTourRef,
            tourId,
          ),
          from: addSelfToTourProvider,
          name: r'addSelfToTourProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addSelfToTourHash,
          dependencies: AddSelfToTourFamily._dependencies,
          allTransitiveDependencies:
              AddSelfToTourFamily._allTransitiveDependencies,
          tourId: tourId,
        );

  AddSelfToTourProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tourId,
  }) : super.internal();

  final String tourId;

  @override
  Override overrideWith(
    FutureOr<void> Function(AddSelfToTourRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddSelfToTourProvider._internal(
        (ref) => create(ref as AddSelfToTourRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tourId: tourId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _AddSelfToTourProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddSelfToTourProvider && other.tourId == tourId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tourId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddSelfToTourRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `tourId` of this provider.
  String get tourId;
}

class _AddSelfToTourProviderElement
    extends AutoDisposeFutureProviderElement<void> with AddSelfToTourRef {
  _AddSelfToTourProviderElement(super.provider);

  @override
  String get tourId => (origin as AddSelfToTourProvider).tourId;
}

String _$removeSelfFromTourHash() =>
    r'de472e24a39c5cf955db96fc1e2d7c5261a67abc';

/// See also [removeSelfFromTour].
@ProviderFor(removeSelfFromTour)
const removeSelfFromTourProvider = RemoveSelfFromTourFamily();

/// See also [removeSelfFromTour].
class RemoveSelfFromTourFamily extends Family<AsyncValue<void>> {
  /// See also [removeSelfFromTour].
  const RemoveSelfFromTourFamily();

  /// See also [removeSelfFromTour].
  RemoveSelfFromTourProvider call(
    String tourId,
  ) {
    return RemoveSelfFromTourProvider(
      tourId,
    );
  }

  @override
  RemoveSelfFromTourProvider getProviderOverride(
    covariant RemoveSelfFromTourProvider provider,
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
  String? get name => r'removeSelfFromTourProvider';
}

/// See also [removeSelfFromTour].
class RemoveSelfFromTourProvider extends AutoDisposeFutureProvider<void> {
  /// See also [removeSelfFromTour].
  RemoveSelfFromTourProvider(
    String tourId,
  ) : this._internal(
          (ref) => removeSelfFromTour(
            ref as RemoveSelfFromTourRef,
            tourId,
          ),
          from: removeSelfFromTourProvider,
          name: r'removeSelfFromTourProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeSelfFromTourHash,
          dependencies: RemoveSelfFromTourFamily._dependencies,
          allTransitiveDependencies:
              RemoveSelfFromTourFamily._allTransitiveDependencies,
          tourId: tourId,
        );

  RemoveSelfFromTourProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tourId,
  }) : super.internal();

  final String tourId;

  @override
  Override overrideWith(
    FutureOr<void> Function(RemoveSelfFromTourRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveSelfFromTourProvider._internal(
        (ref) => create(ref as RemoveSelfFromTourRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tourId: tourId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _RemoveSelfFromTourProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveSelfFromTourProvider && other.tourId == tourId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tourId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RemoveSelfFromTourRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `tourId` of this provider.
  String get tourId;
}

class _RemoveSelfFromTourProviderElement
    extends AutoDisposeFutureProviderElement<void> with RemoveSelfFromTourRef {
  _RemoveSelfFromTourProviderElement(super.provider);

  @override
  String get tourId => (origin as RemoveSelfFromTourProvider).tourId;
}

String _$watchAllToursHash() => r'd5fa1216969e9d74068b771cc3aa1f9aa39e352d';

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
    bool watchPublicOnly,
  ) : this._internal(
          (ref) => watchAllTours(
            ref as WatchAllToursRef,
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
          watchPublicOnly: watchPublicOnly,
        );

  WatchAllToursProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.watchPublicOnly,
  }) : super.internal();

  final bool watchPublicOnly;

  @override
  Override overrideWith(
    Stream<List<Tour>> Function(WatchAllToursRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchAllToursProvider._internal(
        (ref) => create(ref as WatchAllToursRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        watchPublicOnly: watchPublicOnly,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<Tour>> createElement() {
    return _WatchAllToursProviderElement(this);
  }

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

mixin WatchAllToursRef on AutoDisposeStreamProviderRef<List<Tour>> {
  /// The parameter `watchPublicOnly` of this provider.
  bool get watchPublicOnly;
}

class _WatchAllToursProviderElement
    extends AutoDisposeStreamProviderElement<List<Tour>> with WatchAllToursRef {
  _WatchAllToursProviderElement(super.provider);

  @override
  bool get watchPublicOnly => (origin as WatchAllToursProvider).watchPublicOnly;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
