// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messagesRepositoryHash() =>
    r'a8ae4c73e0a2d8e480c23943ea68d9df2624235a';

/// See also [messagesRepository].
@ProviderFor(messagesRepository)
final messagesRepositoryProvider =
    AutoDisposeProvider<MessagesRepository>.internal(
  messagesRepository,
  name: r'messagesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messagesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessagesRepositoryRef = AutoDisposeProviderRef<MessagesRepository>;
String _$watchTourMessagesHash() => r'709dcfe0ba5d0b6b09a1da7c90074531ca26585c';

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

/// See also [watchTourMessages].
@ProviderFor(watchTourMessages)
const watchTourMessagesProvider = WatchTourMessagesFamily();

/// See also [watchTourMessages].
class WatchTourMessagesFamily extends Family<AsyncValue<List<TourMessage>>> {
  /// See also [watchTourMessages].
  const WatchTourMessagesFamily();

  /// See also [watchTourMessages].
  WatchTourMessagesProvider call(
    String tourId,
  ) {
    return WatchTourMessagesProvider(
      tourId,
    );
  }

  @override
  WatchTourMessagesProvider getProviderOverride(
    covariant WatchTourMessagesProvider provider,
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
  String? get name => r'watchTourMessagesProvider';
}

/// See also [watchTourMessages].
class WatchTourMessagesProvider
    extends AutoDisposeStreamProvider<List<TourMessage>> {
  /// See also [watchTourMessages].
  WatchTourMessagesProvider(
    String tourId,
  ) : this._internal(
          (ref) => watchTourMessages(
            ref as WatchTourMessagesRef,
            tourId,
          ),
          from: watchTourMessagesProvider,
          name: r'watchTourMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$watchTourMessagesHash,
          dependencies: WatchTourMessagesFamily._dependencies,
          allTransitiveDependencies:
              WatchTourMessagesFamily._allTransitiveDependencies,
          tourId: tourId,
        );

  WatchTourMessagesProvider._internal(
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
    Stream<List<TourMessage>> Function(WatchTourMessagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WatchTourMessagesProvider._internal(
        (ref) => create(ref as WatchTourMessagesRef),
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
  AutoDisposeStreamProviderElement<List<TourMessage>> createElement() {
    return _WatchTourMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchTourMessagesProvider && other.tourId == tourId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tourId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WatchTourMessagesRef on AutoDisposeStreamProviderRef<List<TourMessage>> {
  /// The parameter `tourId` of this provider.
  String get tourId;
}

class _WatchTourMessagesProviderElement
    extends AutoDisposeStreamProviderElement<List<TourMessage>>
    with WatchTourMessagesRef {
  _WatchTourMessagesProviderElement(super.provider);

  @override
  String get tourId => (origin as WatchTourMessagesProvider).tourId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
