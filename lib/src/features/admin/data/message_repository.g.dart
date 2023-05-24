// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageRepositoryHash() => r'937852a979a36f0b4080b128dd8734d13e255dbf';

/// See also [messageRepository].
@ProviderFor(messageRepository)
final messageRepositoryProvider =
    AutoDisposeProvider<MessageRepository>.internal(
  messageRepository,
  name: r'messageRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessageRepositoryRef = AutoDisposeProviderRef<MessageRepository>;
String _$watchAllMessagesHash() => r'2a23eb4922660d518bbe9478bc4e291ca9ab52b3';

/// See also [watchAllMessages].
@ProviderFor(watchAllMessages)
final watchAllMessagesProvider =
    AutoDisposeStreamProvider<List<AdminMessage>>.internal(
  watchAllMessages,
  name: r'watchAllMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchAllMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchAllMessagesRef = AutoDisposeStreamProviderRef<List<AdminMessage>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
