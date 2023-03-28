// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseAuthHash() => r'71ffe81bf66998bc0d3e862a38892cde39c053ed';

/// See also [firebaseAuth].
@ProviderFor(firebaseAuth)
final firebaseAuthProvider = AutoDisposeProvider<FirebaseAuth>.internal(
  firebaseAuth,
  name: r'firebaseAuthProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$firebaseAuthHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FirebaseAuthRef = AutoDisposeProviderRef<FirebaseAuth>;
String _$authRepositoryHash() => r'dfae945b9bb70bb7541a0a32477043271c0eb924';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$userChangesStreamHash() => r'895bfdba5f0bb14dc4db3faa0852e0cb7cc4cc04';

/// See also [userChangesStream].
@ProviderFor(userChangesStream)
final userChangesStreamProvider = AutoDisposeStreamProvider<User?>.internal(
  userChangesStream,
  name: r'userChangesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userChangesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserChangesStreamRef = AutoDisposeStreamProviderRef<User?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
