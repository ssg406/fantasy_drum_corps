import 'dart:async';
import 'dart:typed_data';

import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/profile/data/storage_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsCardController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> uploadAvatarImage(FilePickerResult result) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return _uploadAvatarImage(result);
    });
  }

  Future<void> _uploadAvatarImage(FilePickerResult result) async {
    Uint8List bytes = result.files.first.bytes!;
    String fileName = result.files.first.name;
    String imageUrl =
        await ref.read(storageRepositoryProvider).uploadImage(fileName, bytes);
    await ref.read(setPhotoUrlProvider(imageUrl));
  }

  Future<void> setDisplayName(String displayName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(setDisplayNameProvider(displayName)));
  }
}

final detailsCardControllerProvider =
    AutoDisposeAsyncNotifierProvider<DetailsCardController, void>(
        DetailsCardController.new);
