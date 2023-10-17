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
String _$userChangesStreamHash() => r'7b335e588be26c3ea0b07ae45e3c9ac1ad69130f';

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
String _$currentUserIsAdminHash() =>
    r'f00832ad8551b950e0eddbb6f2ba555e9ebe4c02';

/// See also [currentUserIsAdmin].
@ProviderFor(currentUserIsAdmin)
final currentUserIsAdminProvider = AutoDisposeFutureProvider<bool>.internal(
  currentUserIsAdmin,
  name: r'currentUserIsAdminProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserIsAdminHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserIsAdminRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
