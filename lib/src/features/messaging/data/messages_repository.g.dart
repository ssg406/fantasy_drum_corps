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

typedef WatchTourMessagesRef = AutoDisposeStreamProviderRef<List<TourMessage>>;

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
    this.tourId,
  ) : super.internal(
          (ref) => watchTourMessages(
            ref,
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
        );

  final String tourId;

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
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
