import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StorageRepository {
  const StorageRepository(this._storage);
  final FirebaseStorage _storage;

  Future<String> uploadImage(String referenceName, Uint8List data) async {
    final imageRef = _storage.ref().child('images/$referenceName');
    await imageRef.putData(data);
    return imageRef.getDownloadURL();
  }
}

final storageRepositoryProvider = Provider<StorageRepository>(
    (_) => StorageRepository(FirebaseStorage.instance));
