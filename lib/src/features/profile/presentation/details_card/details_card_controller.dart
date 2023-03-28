import 'dart:async';
import 'dart:typed_data';

import 'package:fantasy_drum_corps/src/features/players/application/player_service.dart';
import 'package:fantasy_drum_corps/src/features/players/data/players_repository.dart';
import 'package:fantasy_drum_corps/src/features/profile/data/storage_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'details_card_controller.g.dart';

@riverpod
class DetailsCardController extends _$DetailsCardController {
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
    ref.read(setPhotoUrlProvider(url: imageUrl));
  }

  Future<void> clearUploadedImage(String photoUrl) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(storageRepositoryProvider)
          .deleteImage(photoUrl)
          .then((_) => ref.read(clearPhotoUrlProvider));
    });
  }

  Future<void> setDisplayName(String displayName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => ref.read(playerServiceProvider).setDisplayName(displayName));
  }
}
