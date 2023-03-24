import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StorageRepository {
  const StorageRepository(this._storage);

  final FirebaseStorage _storage;

  Future<String> uploadImage(String referenceName, Uint8List data) async {
    final imageRef = _storage.ref().child('images/upload/$referenceName');
    await imageRef.putData(data);
    return imageRef.getDownloadURL();
  }

  Future<void> deleteImage(String photoUrl) async {
    final imageRef = _storage.refFromURL(photoUrl);
    await imageRef.delete();
  }
}

final storageRepositoryProvider = Provider<StorageRepository>(
    (_) => StorageRepository(FirebaseStorage.instance));
